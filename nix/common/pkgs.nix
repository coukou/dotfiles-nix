{ pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    git
    fish
    neovim
    htop

    # Nix 
    nil
    nixpkgs-fmt
    # Lua
    lua-language-server
    stylua
  ];

  environment.variables.EDITOR = "nvim";
}
