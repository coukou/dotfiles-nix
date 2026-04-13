{ self, inputs, ... }: {
  flake.utils = {
    mkNativeWebapp = pkgs: { url, name, desktopName }:
      pkgs.makeDesktopItem {
        inherit name desktopName;
        exec = ''${pkgs.chromium}/bin/chromium --app="${url}"'';
      };

    mkNixos =
      { name
      , stateVersion
      , nixosModules
      , users ? { }
      , system ? "x86_64-linux"
      }:
      let
        baseModule = { pkgs, ... }: {
          imports = [ inputs.home-manager.nixosModules.home-manager ];

          nixpkgs.config.allowUnfree = true;

          nix = {
            package = pkgs.nixVersions.stable;
            gc.automatic = true;
            optimise.automatic = true;
            settings = {
              experimental-features = [ "nix-command" "flakes" "ca-derivations" ];
              auto-optimise-store = true;
              trusted-users = [ "root" "@wheel" ];
            };
            registry.nixpkgs.flake = inputs.nixpkgs;
          };

          time.timeZone = "Europe/Paris";
          i18n.defaultLocale = "en_US.UTF-8";

          environment.systemPackages = with pkgs; [ git htop ];

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "bak";
            extraSpecialArgs = {
              inherit inputs self stateVersion;
              mkNativeWebapp = self.utils.mkNativeWebapp pkgs;
            };
          };

          system.stateVersion = stateVersion;
        };

        usersModule = { pkgs, ... }: {
          users.users = builtins.mapAttrs (_: user: {
            isNormalUser = true;
            initialPassword = "changeme";
            shell = pkgs.fish;
            extraGroups = user.extraGroups;
          }) users;

          home-manager.users = builtins.mapAttrs (_: user:
            user.homeManager // { home.stateVersion = stateVersion; }
          ) users;
        };
      in
      {
        ${name} = inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs self stateVersion system; };
          modules = [ baseModule usersModule ] ++ nixosModules;
        };
      };
  };
}
