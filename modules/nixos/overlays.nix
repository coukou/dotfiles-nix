{ ... }: {
  flake.modules.nixos.overlays = { inputs, system, ... }: {
    nixpkgs.overlays = [
      # llama-cpp with CUDA + native optimisations
      (final: prev: {
        llama-cpp = (prev.llama-cpp.override {
          cudaSupport = true;
          rocmSupport = false;
          metalSupport = false;
          blasSupport = true;
        }).overrideAttrs (oldAttrs: {
          version = "8665";
          src = final.fetchFromGitHub {
            owner = "ggml-org";
            repo = "llama.cpp";
            tag = "b8665";
            hash = "sha256-5rioYM989O6wXEtC3SWg7v3ZgMCSzE6/RyF6ILzY9rQ=";
            leaveDotGit = true;
            postFetch = ''
              git -C "$out" rev-parse --short HEAD > $out/COMMIT
              find "$out" -name .git -print0 | xargs -0 rm -rf
            '';
          };
          cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [ "-DGGML_NATIVE=ON" ];
          preConfigure = ''
            export NIX_ENFORCE_NO_NATIVE=0
            ${oldAttrs.preConfigure or ""}
          '';
          postPatch = "";
        });
      })

      # llama-swap prebuilt binary
      (final: prev: {
        llama-swap = final.runCommand "llama-swap" { } ''
          mkdir -p $out/bin
          tar -xzf ${final.fetchurl {
            url = "https://github.com/mostlygeek/llama-swap/releases/download/v197/llama-swap_197_linux_amd64.tar.gz";
            hash = "sha256-GOP31onCrHvwvutsDXJV0uj+EKKaQdmZfiaBS0tX7Co=";
          }} -C $out/bin
          chmod +x $out/bin/llama-swap
        '';
      })

      # opencode wrapped with jail-nix
      (final: prev:
        let
          jail = inputs.jail-nix.lib.init final;
          opencode-pkg = inputs.llm-agents.packages.${system}.opencode;
        in
        {
          opencode = jail "opencode" opencode-pkg (with jail.combinators; [
            network
            time-zone
            no-new-session
            mount-cwd
            (readwrite (noescape "~/.config/opencode"))
            (readwrite (noescape "~/.local/share/opencode"))
            (readwrite (noescape "~/.local/state/opencode"))
            (with final; add-pkg-deps [
              bashInteractive
              curl
              wget
              jq
              git
              which
              ripgrep
              ast-grep
              gnugrep
              gawkInteractive
              ps
              findutils
              gzip
              unzip
              gnutar
              diffutils
            ])
          ]);
        }
      )

      # pi wrapped with jail-nix
      (final: prev:
        let
          jail = inputs.jail-nix.lib.init final;
          pi-pkg = inputs.llm-agents.packages.${system}.pi;
        in
        {
          pi = jail "pi" pi-pkg (with jail.combinators; [
            network
            time-zone
            no-new-session
            mount-cwd
            (readwrite (noescape "~/.pi"))
            (with final; add-pkg-deps [
              bashInteractive
              curl
              wget
              jq
              git
              which
              ripgrep
              ast-grep
              gnugrep
              gawkInteractive
              ps
              findutils
              gzip
              unzip
              gnutar
              diffutils
            ])
          ]);
        }
      )
    ];
  };
}
