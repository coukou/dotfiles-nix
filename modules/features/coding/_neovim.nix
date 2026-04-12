{ ... }: {
  flake.modules.nixos.coding-neovim = { pkgs, inputs, system, ... }: {
    nixpkgs.overlays = [
      (final: prev: {
        neovim = inputs.nixvim.packages.${system}.default;
      })
    ];

    environment.systemPackages = [ pkgs.neovim ];
    environment.variables.EDITOR = "nvim";
  };
}
