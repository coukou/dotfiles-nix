{ ... }: {
  flake.modules.nixos.theming = { pkgs, ... }: {
    programs.dconf.enable = true;

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
  };

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
