
{ lib, config, pkgs, ... }:

let 
  cfg = config.apps.firefox;
in
{
  options.apps.firefox = { enable = lib.mkEnableOption "firefox"; };
  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };
  };
}
