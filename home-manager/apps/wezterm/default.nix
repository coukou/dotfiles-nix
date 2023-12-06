
{ lib, config, pkgs, ... }:

let 
  cfg = config.apps.wezterm;
in
{
  options.apps.wezterm = { enable = lib.mkEnableOption "wezterm"; };
  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      enable = true;

      extraConfig = ''
        return {
	  window_background_opacity = 0.90,
          font = wezterm.font("Monaspace Neon"),

          use_fancy_tab_bar = false,
          colors = {
            tab_bar = {
              background = "rgba(0, 0, 0, 0.9)",
            },
          },
	}
      '';
    };
  };
}
