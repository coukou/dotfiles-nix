{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    fish
    htop

    # Nix 
    nil
    nixpkgs-fmt

    # Lua
    lua-language-server
    stylua

    neovim
    tmux
  ];

  environment.variables.EDITOR = "nvim";
}
