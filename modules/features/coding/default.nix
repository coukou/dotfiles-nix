{ self, ... }: {
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
