{
  imports = [
    ./autocommands.nix
    ./keymaps.nix
    ./settings.nix

    ./plugins/completion/blink.nix
    ./plugins/completion/actions-preview.nix
    ./plugins/git/gitsigns.nix
    ./plugins/lsp/conform.nix
    ./plugins/lsp/lsp.nix
    ./plugins/mini
    ./plugins/snacks
    ./plugins/treesitter
    ./plugins/ui/lualine.nix
    ./plugins/ui/neotree.nix
    ./plugins/ui/render-markdown.nix
    ./plugins/ui/inline-diagnostics.nix
    ./plugins/ui/hlchunk.nix
    ./plugins/utils/comment.nix
    ./plugins/utils/telescope.nix
    ./plugins/utils/whichkey.nix
    ./plugins/utils/oil.nix
    ./plugins/utils/diffview.nix
    ./plugins/utils/lazygit.nix
    ./plugins/utils/surround.nix
    ./plugins/ai/codecompanion.nix
    ./plugins/navigation/harpoon.nix
  ];

  options = { };

  config = { };
}
