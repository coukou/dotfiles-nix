{ inputs
, self
, home-manager
, nixpkgs
, pkgs
, system
, stateVersion
}: rec {
  wms = {
    hyprland = "wayland";
  };

  homeConfig = user: userConfigs: wm: { ... }: {
    imports = [
      (./home/users + "/${user}.nix")
    ] ++ userConfigs ++ (if wms ? "${wm}" then [
      (./home/display + "/${wm}.nix")
    ] else [ ]);
  };

  mkComputer =
    { machineConfig
    , users
    , wm ? ""
    , extraModules ? [ ]
    , userConfigs ? [ ]
    }: nixpkgs.lib.nixosSystem {
      inherit system pkgs;

      # Arguments to pass to all modules
      specialArgs = {
        inherit system inputs users self stateVersion;
      };
      modules = [
        machineConfig

        ./common.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs self stateVersion; };
          home-manager.users = builtins.listToAttrs (map
            (user: {
              name = user;
              value = homeConfig user userConfigs wm { inherit inputs system pkgs self; };
            })
            users);
        }
      ] ++ extraModules ++ [
        ./common/fonts.nix

      ] ++ (if wms ? "${wm}" then [
        (./. + ("/display/" + wms."${wm}") + ".nix")
      ] else [ ]);
    };
}
