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
        style    = "HLChunk";
        duration = 0;
        delay    = 0;
      };

      indent = {
        enable = true;
        style  = "HLIndent";
      };
    };
  };

  plugins.tiny-inline-diagnostic = {
    enable = true;
  };

  plugins.lualine = {
    enable = true;

    settings = {
      sections = {
        lualine_c = [
          {
            __unkeyed-1 = "filename";
            path = 1;
            symbols = {
              modified = " ●";
              readonly = " ";
              unnamed = "[No Name]";
              newfile = "[New]";
            };
          }
        ];
      };
    };
  };

  plugins.which-key = {
    enable = true;

    settings = {
      preset = "helix";
    };
  };
}
