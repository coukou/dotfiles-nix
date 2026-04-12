{ ... }: {
  flake.modules.homeManager.base = { pkgs, ... }: {
    home.packages = with pkgs; [
      dconf
      seahorse
    ];

    services.gnome-keyring = {
      enable = true;
      components = [ "secrets" ];
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    home.pointerCursor = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

    gtk = {
      enable = true;

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      theme = {
        name = "Catppuccin-GTK-Mauve-Dark";
        package = pkgs.magnetic-catppuccin-gtk.override {
          accent = [ "mauve" ];
          tweaks = [ "macos" "float" ];
        };
      };

      cursorTheme = {
        package = pkgs.catppuccin-cursors.mochaMauve;
        name = "Catppuccin Mocha Mauve";
        size = 24;
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        text-scaling-factor = 1.1;
        font-antialiasing = "rgba";
        font-hinting = "slight";
      };
    };
  };
}
