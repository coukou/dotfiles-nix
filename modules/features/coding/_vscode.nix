{ ... }: {
  flake.modules.homeManager.coding-vscode = { ... }: {
    programs.vscode.enable = true;
  };
}
