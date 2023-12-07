{ config, lib, ... }:

let
  cfg = config.terms.fish;
in
{
  options.terms.fish = { enable = lib.mkEnableOption "fish"; };
  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;
    };
  };
}
