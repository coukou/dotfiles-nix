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
      noto-fonts-extra
    ];

    fontconfig = {
      enable = true;
      hinting = {
        enable = true;
        style = "slight";
      };
      antialias = true;
      subpixel = {
        rgba = "rgb";
      };
    };
  };
}
