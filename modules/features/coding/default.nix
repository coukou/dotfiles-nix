{ self, ... }: {
  imports = [
    ./_vscode.nix
    ./_cursor.nix
    ./_zed.nix
    ./_idea.nix
    ./_android-studio.nix
    ./_postman.nix
    ./_lazygit.nix
  ];

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
