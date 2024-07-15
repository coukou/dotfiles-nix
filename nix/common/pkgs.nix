{ pkgs, lib, inputs, system, ... }: {
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

    (inputs.my-nixvim.packages.${system}.default)
  ];

  environment.variables.EDITOR = "nvim";
}
