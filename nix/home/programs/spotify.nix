{ pkgs, nixosWayland, ... }:
let
  spotifyPkg =
    if nixosWayland
    then
      pkgs.symlinkJoin
        {
          name = "spotify";
          paths = [ pkgs.spotify ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/spotify --set NIXOS_OZONE_WL=1
          '';
        }
    else
      pkgs.spicetify-cli;
in
{
  home.packages = [
    spotifyPkg
  ];
}
