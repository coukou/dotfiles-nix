{ pkgs, helpers, ... }: {

  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = lsp_signature-nvim;
    }
  ];

  plugins.lsp.onAttach =
    let
      settings = {
        bind = true;
        handler_opts = {
          border = "rounded";
        };
      };
    in
    ''require("lsp_signature").on_attach(${helpers.toLuaObject settings}, bufnr)'';
}
