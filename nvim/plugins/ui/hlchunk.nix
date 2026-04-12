{
  plugins.hlchunk = {
    enable = true;
    settings = {
      chunk = {
        enable = true;
        use_treesitter = true;
        chars = {
          horizontal_line = "━";
          vertical_line = "┃";
          left_top = "┏";
          left_bottom = "┗";
          left_arrow = "━";
          right_arrow = "━";
        };
        style = "#806d9c";
        duration = 0;
        delay = 0;
      };

      indent = {
        enable = true;
      };
    };
  };
}
