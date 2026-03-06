{ ... }:
(
  final: prev: {
    llama-cpp = (prev.llama-cpp.override {
      cudaSupport = true;
      rocmSupport = false;
      metalSupport = false;
      # Enable BLAS for optimized CPU layer performance (OpenBLAS)
      blasSupport = true;
    }).overrideAttrs
      (oldAttrs: rec {
        version = "8215";
        src = final.fetchFromGitHub {
          owner = "ggml-org";
          repo = "llama.cpp";
          tag = "b${version}";
          hash = "sha256-hBY2E3aJNnBJ5WjFrIjgpri6/7l6h2i6UI28V55fohg=";
          leaveDotGit = true;
          postFetch = ''
            git -C "$out" rev-parse --short HEAD > $out/COMMIT
            find "$out" -name .git -print0 | xargs -0 rm -rf
          '';
        };
        # Enable native CPU optimizations (AVX, AVX2, etc.)
        cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [
          "-DGGML_NATIVE=ON"
        ];
        # Disable Nix's march=native stripping
        preConfigure = ''
          export NIX_ENFORCE_NO_NATIVE=0
          ${oldAttrs.preConfigure or ""}
        '';
      });
  }
)
