{ ... }: {
  flake.modules.nixos.coding = { pkgs, self, system, ... }: {
    nixpkgs.overlays = [
      (final: prev: {
        neovim = self.packages.${system}.nvim;
      })
    ];

    environment.systemPackages = with pkgs; [
      neovim
      nil
      nixpkgs-fmt
      lua-language-server
      stylua
      devenv
    ];

    environment.variables.EDITOR = "nvim";
  };

  flake.modules.homeManager.coding = { pkgs, ... }: {
    home.packages = [ pkgs.lazygit ];

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
