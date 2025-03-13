{ ... }: {
  programs.kitty = {
    enable = true;

    extraConfig = ''
      font_family FiraCode Nerd Font

      font_size 11.0
      window_padding_width 12
      background_opacity 0.62
      backgroud_blur 1
      cursor none
    '';
  };
}
