{ ... }: {
  programs.kitty = {
    enable = true;

    extraConfig = ''
      font_family FiraCode Nerd Font

      window_padding_width 8
      background_opacity 0.8
      backgroud_blur 1
      cursor none
    '';
  };
}
