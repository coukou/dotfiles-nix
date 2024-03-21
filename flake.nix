{
  description = "My nix configuration";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

      systems.url = "github:nix-systems/default";
      flake-utils.url = "github:numtide/flake-utils";
      flake-utils.inputs.systems.follows = "systems";

      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      hyprland.url = "github:hyprwm/Hyprland/v0.37.1";
      hyprland.inputs.nixpkgs.follows = "nixpkgs";
      hyprland.inputs.systems.follows = "systems";
    };

  outputs = inputs @ { self, home-manager, nixpkgs, flake-utils, ... }:
    let
      system = "x86_64-linux";
      stateVersion = "24.05";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      utils = import ./nix/utils.nix
        {
          inherit inputs self home-manager nixpkgs system pkgs stateVersion;
        };
    in
    {
      nixosConfigurations = {
        desktop = utils.mkComputer {
          machineConfig = ./nix/machines/desktop.nix;
          wm = "hyprland";
          users = [ "coukou" "coukou-work" ];
        };

        xps13 = utils.mkComputer {
          machineConfig = ./nix/machines/xps13.nix;
          wm = "hyprland";
          users = [ "coukou" ];
        };
      };
    };
}
