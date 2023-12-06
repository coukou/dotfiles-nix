
{ inputs, pkgs, config, ... }:

{
    imports = [
        ./x11
        ./_1password
        ./sound
	./nvidia
    ];
}
