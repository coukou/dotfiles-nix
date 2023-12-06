
{ lib, config, pkgs, ... }:

let 
  cfg = config.fonts.monaspace;
in
{
  options.fonts.monaspace = { enable = lib.mkEnableOption "monaspace"; };
  config = lib.mkIf cfg.enable {
	  home.packages = with pkgs; [
	    monaspace
	  ];
  };
}
