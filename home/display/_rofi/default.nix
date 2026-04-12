{ pkgs, ... }:
let
  theme = pkgs.stdenv.mkDerivation {
    name = "rofi-theme";
    src = ./themes;
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
