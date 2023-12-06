
{ lib, config, pkgs, ... }:

let 
  cfg = config.modules.x11;
in
{
  options.modules.x11 = { enable = lib.mkEnableOption "x11"; };
  config = lib.mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;
	desktopManager.xterm.enable = true;
      };
    };
  };
}
