{
  highlight = {
    # Headings — text color only, fading by level, no backgrounds
    RenderMarkdownH1 = { fg = "#cdd6f4"; bold = true; };
    RenderMarkdownH2 = { fg = "#bac2de"; bold = true; };
    RenderMarkdownH3 = { fg = "#a6adc8"; bold = true; };
    RenderMarkdownH4 = { fg = "#9399b2"; };
    RenderMarkdownH5 = { fg = "#9399b2"; italic = true; };
    RenderMarkdownH6 = { fg = "#7f849c"; italic = true; };

    # Code — Mantle as a subtle "card" bg, mauve for inline
    RenderMarkdownCode       = { bg = "#181825"; };
    RenderMarkdownCodeInline = { fg = "#cba6f7"; bg = "#1e1e2e"; };

    # Everything else — quiet, desaturated
    RenderMarkdownBullet    = { fg = "#585b70"; };
    RenderMarkdownQuote     = { fg = "#6c7086"; italic = true; };
    RenderMarkdownDash      = { fg = "#313244"; };
    RenderMarkdownLink      = { fg = "#89b4fa"; };
    RenderMarkdownChecked   = { fg = "#a6e3a1"; };
    RenderMarkdownUnchecked = { fg = "#45475a"; };
    RenderMarkdownTableHead = { fg = "#7f849c"; bold = true; };
    RenderMarkdownTableRow  = { fg = "#bac2de"; };
  };

  plugins.render-markdown = {
    enable = true;

    settings = {
      file_types = [ "markdown" "codecompanion" ];

      heading = {
        sign        = false;
        icons       = [ ];
        backgrounds = [ "" "" "" "" "" "" ];
        width       = "block";
        position    = "overlay";
      };

      code = {
        sign          = false;
        style         = "full";
        border        = "none";
        width         = "block";
        min_width     = 40;
        language_name = true;
      };

      bullet = {
        icons     = [ "•" "◦" "·" ];
        right_pad = 1;
      };

      checkbox = {
        unchecked = { icon = "☐ "; };
        checked   = { icon = "☑ "; };
      };

      quote = {
        icon             = "│";
        repeat_linebreak = true;
      };

      dash = {
        icon  = "─";
        width = "full";
      };

      table = {
        preset = "none";
        style  = "full";
        cell   = "padded";
      };

      link = {
        image     = "󰥶 ";
        email     = "󰀓 ";
        hyperlink = "󰌹 ";
      };

      sign = {
        enabled = false;
      };
    };
  };
}
