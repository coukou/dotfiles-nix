{
  highlight = {
    # Headings — only H1 gets a Catppuccin surface1 background
    RenderMarkdownH1 = { fg = "#89b4fa"; bold = true; }; # blue on surface1
    RenderMarkdownH1Bg = { bg = "#45475a"; }; # surface1
    RenderMarkdownH2 = { fg = "#bac2de"; bold = true; };
    RenderMarkdownH3 = { fg = "#a6adc8"; bold = true; };
    RenderMarkdownH4 = { fg = "#9399b2"; };
    RenderMarkdownH5 = { fg = "#9399b2"; italic = true; };
    RenderMarkdownH6 = { fg = "#7f849c"; italic = true; };

    # Code — transparent background, borders in surface1
    RenderMarkdownCode = { bg = "NONE"; };
    RenderMarkdownCodeInline = { fg = "#cba6f7"; };
    RenderMarkdownCodeBorder = { fg = "#45475a"; };

    # Everything else — quiet, desaturated
    RenderMarkdownBullet = { fg = "#585b70"; };
    RenderMarkdownQuote = { fg = "#6c7086"; italic = true; };
    RenderMarkdownDash = { fg = "#313244"; };
    RenderMarkdownLink = { fg = "#89b4fa"; };
    RenderMarkdownChecked = { fg = "#a6e3a1"; };
    RenderMarkdownUnchecked = { fg = "#45475a"; };
    RenderMarkdownTableHead = { fg = "#7f849c"; bold = true; };
    RenderMarkdownTableRow = { fg = "#bac2de"; };
  };

  plugins.render-markdown = {
    enable = true;

    settings = {
      file_types = [ "markdown" "codecompanion" ];

      heading = {
        sign = false;
        icons = [ "# " "## " "### " "#### " "##### " "###### " ];
        backgrounds = [ "RenderMarkdownH1Bg" "" "" "" "" "" ];
        width = "block";
        position = "overlay";
      };

      code = {
        sign = true;
        width = "block";
        language_name = true;
      };

      bullet = {
        icons = [ "•" "◦" "·" ];
        right_pad = 1;
      };

      checkbox = {
        unchecked = { icon = "☐ "; };
        checked = { icon = "☑ "; };
      };

      quote = {
        icon = "│";
        repeat_linebreak = true;
      };

      dash = {
        icon = "─";
        width = "full";
      };

      table = {
        preset = "none";
        style = "full";
        cell = "padded";
      };

      link = {
        image = "󰥶 ";
        email = "󰀓 ";
        hyperlink = "󰌹 ";
      };

      sign = {
        enabled = false;
      };
    };
  };
}
