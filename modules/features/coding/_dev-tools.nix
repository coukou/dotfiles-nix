{ ... }: {
  flake.modules.nixos.coding-dev-tools = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      nil
      nixpkgs-fmt
      lua-language-server
      stylua
      devenv
    ];
  };
}
