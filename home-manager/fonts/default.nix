
{ inputs, pkgs, config, ... }:

{
    imports = [
        ./monaspace
    ];
    fonts.fontconfig.enable = true;
}
