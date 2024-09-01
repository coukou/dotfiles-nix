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

    (self.packages."${system}".nvim)
  ];

  environment.variables.EDITOR = "nvim";
}
