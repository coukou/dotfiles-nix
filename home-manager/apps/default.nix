
{ inputs, pkgs, config, ... }:

{
    imports = [
        ./nvim
        ./firefox
        ./wezterm
        ./spotify
        ./discord
    ];
}
