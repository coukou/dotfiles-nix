{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    ubuntu_font_family
    fira-code-nerdfont
    nerdfonts
    monaspace
    jetbrains-mono
  ];
}
