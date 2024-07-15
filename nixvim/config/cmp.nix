{ helpers, ... }:
{
  plugins.cmp = {
    enable = true;

    settings = {

      sources = [
        { name = "nvim_lsp"; }
      ];

      mapping = {
        "<C-n>" = "cmp.mapping.select_next_item()";
        "<C-p>" = "cmp.mapping.select_prev_item()";
        "<C-[>" = "cmp.mapping.scroll_docs(-4)";
        "<C-]>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete({})";
        "<CR>" = ''
          cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          })
        '';
        "<Tab>" = ''
          cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" })
        '';
        "<S-Tab>" = ''
          cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" })
        '';
      };

      window.completion = helpers.mkRaw "cmp.config.window.bordered()";
      window.documentation = helpers.mkRaw "cmp.config.window.bordered()";
    };
  };
}
