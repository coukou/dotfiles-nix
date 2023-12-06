
{ lib, config, pkgs, ... }:

let 
  cfg = config.windowManagers.i3;
in
{
  options.windowManagers.i3 = { enable = lib.mkEnableOption "i3"; };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      font-awesome
    ];

    xsession = {
      enable = true;

      windowManager.i3 = {
        enable = true;
	package = pkgs.i3-gaps;

	config = rec {
	  modifier = "Mod4";

	  window.border = 0;

	  bars = [
	    {
	      position = "bottom";
	      statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
	    }
	  ];

	  gaps = {
	    inner = 15;
	    outer = 5;
	  };

	  keybindings = lib.mkOptionDefault {
	    "${modifier}+Return" = "exec wezterm";
	    "${modifier}+Q" = "kill";
	  };

	  startup = [
	    {
	      command = "exec i3-msg workspace 1";
	      always = true;
	      notification = false;
	    }
	  ];
	};
      };
    };
  };
}
