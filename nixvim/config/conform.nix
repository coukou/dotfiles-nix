{ helpers, ... }:
{
  plugins.conform-nvim = {
    enable = true;
    formattersByFt = {
      lua = [ "stylua" ];
      javascript = [ "prettierd" ];
      typescript = [ "prettierd" ];
      typescriptreact = [ "prettierd" ];
    };
    formatAfterSave = helpers.toLuaObject {
      timeoutMs = 500;
      lspFallback = true;
    };
  };
}
