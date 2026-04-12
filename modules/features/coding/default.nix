{ self, ... }: {
  imports = [
    ./_neovim.nix
    ./_dev-tools.nix
    ./_lazygit.nix
  ];

  flake.modules.nixos.coding = { ... }: {
    imports = with self.modules.nixos; [ coding-neovim coding-dev-tools ];
  };

  flake.modules.homeManager.coding = { ... }: {
    imports = with self.modules.homeManager; [ coding-lazygit ];
  };
}
