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

      hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      hyprland.inputs.nixpkgs.follows = "nixpkgs";
      hyprland.inputs.systems.follows = "systems";

      zen-browser.url = "github:youwen5/zen-browser-flake?ref=f2f8aff94529e763665b807bad23396aed9d1fe8";
      zen-browser.inputs.nixpkgs.follows = "nixpkgs";

      nixvim.url = "github:coukou/nixvim";
    };

  outputs =
    inputs @ { self
    , home-manager
    , nixpkgs
    , flake-utils
    , nixvim
    , ...
    }:
    let
      system = "x86_64-linux";
      stateVersion = "24.11";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;

        overlays = [
          (final: prev: {
            neovim = inputs.nixvim.packages.${pkgs.system}.default;
          })
        ];
      };

      utils = import
        ./nix/utils.nix
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
