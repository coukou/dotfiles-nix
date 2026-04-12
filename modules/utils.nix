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
      , system ? "x86_64-linux"
      }:
      {
        ${name} = inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs self stateVersion system; };
          modules = nixosModules;
        };
      };
  };
}
