
{ lib, config, pkgs, ... }:

let 
  cfg = config.modules.sound;
in
{
  options.modules.sound = { enable = lib.mkEnableOption "sound"; };
  config = lib.mkIf cfg.enable {
    hardware.pulseaudio.enable = true;
    hardware.pulseaudio.support32Bit = true;
  };
}
