{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      maple-mono.NF
      nerd-fonts.fira-code
      inter
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];

    fontconfig = {
      enable = true;

      defaultFonts = {
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
        monospace = [ "Noto Sans Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };

      antialias = true;
      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
      hinting = {
        enable = true;
        style = "slight";
        autohint = false;
      };
    };
  };
}
