{ pkgs, lib, inputs, system, self, ... }: {
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

    # dev
    devenv

    neovim
    tmux
  ];

  environment.variables.EDITOR = "nvim";
}
