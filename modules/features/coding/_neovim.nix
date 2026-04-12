{ ... }: {
  flake.modules.nixos.coding-neovim = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.neovim ];
    environment.variables.EDITOR = "nvim";
  };
}
