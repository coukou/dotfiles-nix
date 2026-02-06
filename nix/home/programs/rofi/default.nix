{ config, pkgs, ... }:

let
  theme = pkgs.stdenv.mkDerivation {
    name = "my-rofi-theme";
    src = ./themes; # Folder containing main.rasi, colors.rasi, etc.
    installPhase = ''
      mkdir -p $out
      cp * $out/
    '';
  };
in
{
  programs.rofi = {
    enable = true;

    theme = "${theme}/main.rasi";
  };
}
