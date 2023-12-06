{
    description = "NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { home-manager, nixpkgs, ... }@inputs: 
        let
            system = "x86_64-linux";
            pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
            lib = nixpkgs.lib;

            mkSystem = pkgs: system: username: hostName:
                pkgs.lib.nixosSystem {
		    inherit system;
                    modules = [
                        { networking.hostName = hostName; }

			# Load default shared configuration
			./system/configuration.nix

			# Load host configurations
                        (./. + "/hosts/${hostName}/configuration.nix")

			# Load host hardware configurations
                        (./. + "/hosts/${hostName}/hardware-configuration.nix")

			# Load host system modules
                        (./. + "/hosts/${hostName}/system.nix")

			# Setup home manager
                        home-manager.nixosModules.home-manager
                        {
                            home-manager = {
                                useUserPackages = true;
                                useGlobalPkgs = true;
                                extraSpecialArgs = { inherit inputs; };
				
                                users."${username}" = (./. + "/hosts/${hostName}/home.nix");
                            };
                        }
                    ];
                    specialArgs = { inherit inputs; };
                };

        in {
            nixosConfigurations = {
                desktop = mkSystem inputs.nixpkgs "x86_64-linux" "coukou" "desktop";
            };
    };
}

