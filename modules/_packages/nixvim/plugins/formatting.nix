{ lib, ... }: {
  plugins.conform-nvim = {
    enable = true;

    settings = {
      formatters_by_ft = {
        lua = [ "stylua" ];
        javascript = [ "oxfmt" "biome" "biome-organize-imports" ];
        typescript = [ "oxfmt" "biome" "biome-organize-imports" ];
        typescriptreact = [ "oxfmt" "biome" "biome-organize-imports" ];
        json = [ "oxfmt" ];
      };

      format_after_save = lib.nixvim.toLuaObject {
        timeout_ms = 500;
        lsp_format = "fallback";
      };

      notify_on_error = true;
    };
  };
}
