{ inputs, pkgs, ... }:
let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModule
  ];

  programs.spicetify = {
    enable = true;

    theme = spicePkgs.themes.catppuccin;

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      hidePodcasts
    ];
  };
}
