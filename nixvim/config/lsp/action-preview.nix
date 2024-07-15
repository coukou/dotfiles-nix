{ pkgs, toLua, helpers, ... }:
{

  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = actions-preview-nvim;
      config =
        let
          settings = {
            telescope = {
              sorting_strategy = "ascending";
              layout_strategy = "vertical";
              layout_config = {
                width = 0.8;
                height = 0.9;
                prompt_position = "top";
                preview_cutoff = 20;
                preview_height = helpers.mkRaw ''
                  function(_, _, max_lines)
                    return max_lines - 15
                  end
                '';
              };
            };
          };
        in
        toLua ''
          require("actions-preview").setup ${helpers.toLuaObject settings}
        '';
    }
  ];

  plugins.lsp.keymaps.extra = [
    {
      key = "<C-.>";
      action = helpers.mkRaw "require('actions-preview').code_actions";
      options.desc = "LSP Code action";
    }
  ];
}

