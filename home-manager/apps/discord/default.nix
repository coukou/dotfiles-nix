
{ lib, config, pkgs, ... }:

let 
  cfg = config.apps.discord;
in
{
  options.apps.discord = { enable = lib.mkEnableOption "discord"; };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
    ];
  };
}
