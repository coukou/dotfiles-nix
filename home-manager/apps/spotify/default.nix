
{ lib, config, pkgs, ... }:

let 
  cfg = config.apps.spotify;
in
{
  options.apps.spotify = { enable = lib.mkEnableOption "spotify"; };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      spotify
    ];
  };
}
