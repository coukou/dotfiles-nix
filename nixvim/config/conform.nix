{ helpers, pkgs, ... }:
{

  extraPackages = with pkgs; [
    prettierd
  ];

  plugins.conform-nvim = {
    enable = true;
    formattersByFt = {
      lua = [ "stylua" ];
      javascript = [ "prettierd" ];
      typescript = [ "prettierd" ];
      typescriptreact = [ "prettierd" ];
    };
    formatAfterSave = helpers.toLuaObject {
      timeout_ms = 500;
      lsp_format = "fallback";
    };
  };
}
