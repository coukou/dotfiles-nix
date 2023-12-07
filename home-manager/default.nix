
{ inputs, pkgs, config, ... }:

{
    imports = [
        ./apps
	./window-managers
        ./fonts
        ./terms
    ];
}
