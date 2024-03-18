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

  mkNativeWebapp = { url, name, desktopName }:
    pkgs.makeDesktopItem {
      name = name;
      desktopName = desktopName;
      exec = ''
        ${pkgs.chromium}/bin/chromium --app="${url}"
      '';
    };

  mkComputer =
    { machineConfig
    , users
    , gpu
    , wm ? ""
    , extraModules ? [ ]
    , userConfigs ? [ ]
    }:
    let
      windowServer = wms."${wm}";
      nixosWayland = windowServer == "wayland";
    in
    nixpkgs.lib.nixosSystem {
      inherit system pkgs;

      # Arguments to pass to all modules
      specialArgs = {
        inherit system inputs users self wm stateVersion gpu nixpkgs;
      };

      modules = [
        machineConfig

        ./common.nix

        home-manager.nixosModules.home-manager
        {
          home-manager. useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit inputs self stateVersion gpu mkNativeWebapp nixosWayland;
          };
          home-manager.users = builtins.listToAttrs (map
            (user: {
              name = user;
              value = homeConfig user userConfigs wm { inherit inputs system pkgs self; };
            })
            users);
        }
      ] ++ extraModules ++ [
        ./common/fonts.nix
        (./. + "/display/${windowServer}.nix")

      ];
    };
}
