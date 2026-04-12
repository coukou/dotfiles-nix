{ self, ... }: {
  imports = [
    ./_hyprland.nix
    ./_hyprpanel.nix
    ./_rofi/default.nix
    ./_waybar/default.nix
  ];

  flake.modules.homeManager.display = { ... }: {
    imports = with self.modules.homeManager; [
      display-hyprland
      display-hyprpanel
      display-rofi
      display-waybar
    ];
  };
}
