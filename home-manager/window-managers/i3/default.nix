
{ lib, config, pkgs, ... }:

let 
  cfg = config.windowManagers.i3;
in
{
  options.windowManagers.i3 = { enable = lib.mkEnableOption "i3"; };
imports = [
./config.nix
];
  config = lib.mkIf cfg.enable {
    xsession = {
      enable = true;

      windowManager.i3 = {
        enable = true;
	package = pkgs.i3-gaps;
	config = null;
      };
    };
  };
}
