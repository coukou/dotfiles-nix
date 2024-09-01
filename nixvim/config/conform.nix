{ helpers, pkgs, ... }:
{

  extraPackages = with pkgs; [
    prettierd
  ];

  plugins.conform-nvim = {
    enable = true;

    settings = {
      formatters_by_ft = {
        lua = [ "stylua" ];
        javascript = [ "prettierd" ];
        typescript = [ "prettierd" ];
        typescriptreact = [ "prettierd" ];
      };

      format_after_save = helpers.toLuaObject {
        timeout_ms = 500;
        lsp_format = "fallback";
      };
    };
  };
}
