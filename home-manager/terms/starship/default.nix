{ config, lib, ... }:

let
  cfg = config.terms.starship;
in
{
  options.terms.starship = { enable = lib.mkEnableOption "starship"; };
  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {};
    };
  };
}
