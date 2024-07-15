{ helpers, ... }:
{

  imports = [
    ./servers
    ./lspkind.nix
    ./lsp-signature.nix
    ./action-preview.nix
    ./workspace-diagnostics.nix
  ];

  plugins.cmp-nvim-lsp = {
    enable = true;

  };

  plugins.lsp = {
    enable = true;
    inlayHints = true;

    keymaps.extra = [
      {
        key = "K";
        action = helpers.mkRaw "vim.lsp.buf.hover";
        options.desc = "LSP Hover";
      }
      {
        key = "<leader>r";
        action = helpers.mkRaw "vim.lsp.buf.rename";
        options.desc = "LSP Rename";
      }
      {
        key = "gd";
        action = helpers.mkRaw "vim.lsp.buf.definition";
        options.desc = "go to definition";
      }
      {
        key = "gD";
        action = helpers.mkRaw "vim.lsp.buf.declaration";
        options.desc = "go to declaration";
      }
      {
        key = "gI";
        action = helpers.mkRaw "vim.lsp.buf.implementation";
        options.desc = "go to implementation";
      }
      {
        key = "<leader>D";
        action = helpers.mkRaw "vim.lsp.buf.type_definition";
        options.desc = "LSP type definition";
      }
      {
        key = "<leader>ih";
        action = helpers.mkRaw "function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end";
        options.desc = "Toggle inlay hint";
      }
    ];

    postConfig = ''
      local border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      }

      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end
    '';
  };
}
