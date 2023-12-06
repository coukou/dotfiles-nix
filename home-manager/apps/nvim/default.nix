
{ lib, config, pkgs, ... }:

let 
  cfg = config.apps.nvim;
in
{
  options.apps.nvim = { enable = lib.mkEnableOption "nvim"; };
  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
    };
  };
}
