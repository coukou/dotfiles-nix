{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    ubuntu_font_family
    nerd-fonts.fira-code
    monaspace
    jetbrains-mono
    noto-fonts-color-emoji
  ];
}
