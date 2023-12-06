
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
	  font = wezterm.font("Monaspace Neon"),
	}
      '';
    };
  };
}
