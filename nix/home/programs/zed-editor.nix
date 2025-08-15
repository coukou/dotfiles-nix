{ lib, pkgs, ... }: {
  programs.zed-editor = {
    extensions = [
      "biome"
    ];
    enable = true;
    userSettings = {
      icon_theme = "Catppuccin Macchiato";

      edit_predictions = {
        mode = "subtle";
      };
      features = {
        edit_prediction_provider = "zed";
      };

      telemetry = {
        metrics = false;
        diagnostics = false;
      };

      vim_mode = true;
      ui_font_size = 18;
      buffer_font_size = 15;

      theme = {
        mode = "system";
        light = "Catppuccin Macchiato";
        dark = "One Dark";
      };

      project_panel = {
        auto_fold_dirs = false;
      };

      lsp = {
        biome = {
          binary = {
            arguments = [ "lsp-proxy" ];
            path = lib.getExe pkgs.biome;
          };
        };
      };
    };
  };
}
