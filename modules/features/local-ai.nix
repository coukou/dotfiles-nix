{ ... }: {
  flake.modules.nixos.local-ai = { ... }: {
    nixpkgs.overlays = [
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
          cmakeFlags = oldAttrs.cmakeFlags or [ ];
          postPatch = "";
        });
      })
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
    ];
  };

  flake.modules.homeManager.local-ai = { pkgs, lib, ... }:
    let
      config = {
        globalTTL = 180;
        models = {
          "Qwen3.5-9B" = {
            cmd = ''
              llama-server
                -hf unsloth/Qwen3.5-9B-GGUF:Q4_K_M
                --port ''${PORT}
                --ctx-size 86016
                --temp 0.6
                --top-p 0.95
                --top-k 20
                --min-p 0.00
            '';
          };
          "gemma-4-E4B-thinking" = {
            cmd = ''
              llama-server
                -hf unsloth/gemma-4-E4B-it-GGUF:Q8_0
                --port ''${PORT}
                --ctx-size 65536
                --temp 1.0
                --top-p 0.95
                --top-k 64
                --reasoning on
            '';
          };
          "gemma-4-E4B" = {
            cmd = ''
              llama-server
                -hf unsloth/gemma-4-E4B-it-GGUF:Q8_0
                --port ''${PORT}
                --ctx-size 32768
                --temp 1.0
                --top-p 0.95
                --top-k 64
                --reasoning off
            '';
          };
        };
      };
      configFile = pkgs.writeText "llama-swap-config.yaml" (lib.generators.toYAML { } config);
    in
    {
      systemd.user.services.llama-swap = {
        Unit.Description = "Llama swap server";
        Service = {
          ExecStart = "${pkgs.llama-swap}/bin/llama-swap --config ${configFile} --listen 0.0.0.0:10001";
          Restart = "always";
          RestartSec = "60";
          Environment = [ "PATH=${lib.makeBinPath [ pkgs.llama-cpp ]}" ];
        };
        Install.WantedBy = [ "default.target" ];
      };
    };
}
