{ self, ... }: {
  imports = [ ./_notion.nix ./_obsidian.nix ./_gmail.nix ./_proton-pass.nix ./_draw.nix ];

  flake.modules.homeManager.productivity = { ... }: {
    imports = with self.modules.homeManager; [
      productivity-notion
      productivity-obsidian
      productivity-gmail
      productivity-proton-pass
      productivity-draw
    ];
  };
}
