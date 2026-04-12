{ ... }: {
  flake.modules.nixos.coding-neovim = { pkgs, self, system, ... }: {
    nixpkgs.overlays = [
      (final: prev: {
        neovim = self.packages.${system}.nvim;
      })
    ];

    environment.systemPackages = [ pkgs.neovim ];
    environment.variables.EDITOR = "nvim";
  };
}
