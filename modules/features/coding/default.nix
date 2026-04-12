{ self, ... }: {
  imports = [
    ./_neovim.nix
    ./_dev-tools.nix
    ./_vscode.nix
    ./_cursor.nix
    ./_zed.nix
    ./_idea.nix
    ./_android-studio.nix
    ./_postman.nix
    ./_lazygit.nix
  ];

  flake.modules.nixos.coding = { ... }: {
    imports = with self.modules.nixos; [ coding-neovim coding-dev-tools ];
  };

  flake.modules.homeManager.coding = { ... }: {
    imports = with self.modules.homeManager; [
      coding-vscode
      coding-cursor
      coding-zed
      coding-idea
      coding-android-studio
      coding-postman
      coding-lazygit
    ];
  };
}
