{ pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    git
    fish
    neovim
    htop
  ];

  environment.variables.EDITOR = "nvim";
}
