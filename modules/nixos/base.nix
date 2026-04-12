{ ... }: {
  flake.modules.nixos.base = { inputs, pkgs, self, stateVersion, ... }: {
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

    programs.fish.enable = true;

    environment.systemPackages = with pkgs; [
      git
      htop
      neovim
      devenv
    ];

    environment.variables.EDITOR = "nvim";

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
}
