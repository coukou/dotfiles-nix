{ pkgs, nixosWayland, ... }:
let
  discordPkg =
    if nixosWayland then
      pkgs.symlinkJoin
        {
          name = "vesktop";
          paths = [ pkgs.vesktop ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/vesktop --set NIXOS_OZONE_WL=1
          '';
        }
    else pkgs.vesktop;
in
{
  home.packages = [
    discordPkg
  ];
}
