{ inputs, self, pkgs, ... }: {

  imports = [
    ../common.nix
    ../programs/fish.nix
    ../programs/starship.nix
    ../programs/spotify.nix
    ../programs/discord.nix
    ../programs/gmail.nix
    ../programs/notion.nix
    ../programs/vscode.nix
    ../programs/slack.nix
    ../programs/nvim
  ];

  home.packages = with pkgs; [ ];
}
