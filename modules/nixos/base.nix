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

    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 30;
    };

    time.timeZone = "Europe/Paris";
    i18n.defaultLocale = "en_US.UTF-8";

    programs.fish.enable = true;
    services.gnome.gnome-keyring.enable = true;
    security.polkit.enable = true;

    environment.systemPackages = with pkgs; [
      git
      htop
      nil
      nixpkgs-fmt
      lua-language-server
      stylua
      neovim
      devenv
    ];

    environment.variables.EDITOR = "nvim";

    fonts = {
      packages = with pkgs; [
        maple-mono.NF
        nerd-fonts.fira-code
        inter
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
      ];
      fontconfig = {
        enable = true;
        defaultFonts = {
          sansSerif = [ "Noto Sans" ];
          serif = [ "Noto Serif" ];
          monospace = [ "Noto Sans Mono" ];
          emoji = [ "Noto Color Emoji" ];
        };
        antialias = true;
        subpixel = { rgba = "rgb"; lcdfilter = "default"; };
        hinting = { enable = true; style = "slight"; autohint = false; };
      };
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "bak";
      extraSpecialArgs = {
        inherit inputs self stateVersion;
        mkNativeWebapp = { url, name, desktopName }:
          pkgs.makeDesktopItem {
            inherit name desktopName;
            exec = ''${pkgs.chromium}/bin/chromium --app="${url}"'';
          };
      };
    };

    system.stateVersion = stateVersion;
  };
}
