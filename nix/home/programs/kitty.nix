{ ... }: {
  programs.kitty = {
    enable = true;

    extraConfig = ''
      font_family Maple Mono NF

      font_size 12.0
      window_padding_width 12
      background_opacity 0.62
      backgroud_blur 1
      cursor none
    '';
  };
}
