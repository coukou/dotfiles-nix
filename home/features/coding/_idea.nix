{ pkgs, ... }:
let
  waylandIdea = pkgs.jetbrains.idea-oss.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
    postFixup = ''
      wrapProgram $out/bin/idea-oss \
        --add-flags "-Dawt.toolkit.name=WLToolkit"
    '';
  });
in
{
  home.packages = [ waylandIdea ];
}
