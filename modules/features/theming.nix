{ ... }: {
  flake.modules.homeManager.theming = { pkgs, ... }: {
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
  };
}
