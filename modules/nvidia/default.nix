
{ lib, config, pkgs, ... }:

let 
  cfg = config.modules.nvidia;
in
{
  options.modules.nvidia = { enable = lib.mkEnableOption "nvidia"; };

  config = lib.mkIf cfg.enable {

  	services.xserver.videoDrivers = [ "nvidia" ];

	  hardware.opengl = {
	    enable = true;
	    driSupport = true;
	    driSupport32Bit = true;
	  };

	  hardware.nvidia = {
	    modesetting.enable = true;
	    powerManagement.enable = false;
	    powerManagement.finegrained = false;
	    open = false;
	    nvidiaSettings = true;
	  };
  };
}
