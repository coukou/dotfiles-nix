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

    # dev
    devenv
  ];

  environment.variables.EDITOR = "nvim";
}
