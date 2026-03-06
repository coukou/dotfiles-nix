{ pkgs
, lib
, ...
}:
let
  config = {
    models = {
      "Qwen3.5-9B" = {
        cmd = ''
          llama-server
            -hf unsloth/Qwen3.5-9B-GGUF:Q4_K_M
            --port ''${PORT}
            --ctx-size 65536
        '';
      };
      "sweep/next-edit-1.5" = {
        cmd = ''
          llama-server
            -hf sweepai/sweep-next-edit-1.5B:latest
            --port ''${PORT}
        '';
      };
    };
  };
  configFile = pkgs.writeText "config.yaml" (lib.generators.toYAML { } config);
in
{
  systemd.user.services.llama-swap = {
    Unit = {
      Description = "Llama swap server";
    };

    Service = {
      ExecStart = "${pkgs.llama-swap}/bin/llama-swap --config ${configFile} --listen 0.0.0.0:10001";
      Restart = "always";
      RestartSec = "60";
      Environment = [
        "PATH=${lib.makeBinPath [ pkgs.llama-cpp ]}"
      ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
