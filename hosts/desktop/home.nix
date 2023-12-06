
{ config, lib, inputs, ... }:

{
    imports = [ ../../home-manager ];
    config = {
      home.stateVersion = "23.11";

      apps = {
        nvim.enable = true;
    	firefox.enable = true;
    	wezterm.enable = true;
	discord.enable = true;
	spotify.enable = true;
      };

      fonts = {
        monaspace.enable = true;
      };

      windowManagers.i3.enable = true;

      services.picom = {
	enable = true;
	backend = "glx";
	vSync = true;

	settings = {
	  blur = {
	    method = "gaussian";
            size = 10;
            deviation = 5.0;
          };
          corner-radius = 10;
	};
      };
    };
}
