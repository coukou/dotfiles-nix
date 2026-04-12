{ self, ... }: {
  flake.modules.homeManager.display = { ... }: {
    imports = with self.modules.homeManager; [
      display-hyprland
      display-hyprpanel
      display-rofi
      display-waybar
    ];
  };
}
