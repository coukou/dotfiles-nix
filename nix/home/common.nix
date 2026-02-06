{ stateVersion, pkgs, ... }: {
  imports = [ ];

  home.packages = with pkgs; [
    dconf
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.pointerCursor = {
    name = "Numix-Cursor";
    package = pkgs.numix-cursor-theme;
  };

  targets.genericLinux.nixGL.vulkan.enable = true;

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

  home.stateVersion = stateVersion;
}
