{ config, lib, inputs, ... }:

{
    imports = [ ../../modules/default.nix ];
    config = {
	    modules = {
		x11.enable = true;
		_1password.enable = true;
		sound.enable = true;
		nvidia.enable = true;
	    };
    };

}
