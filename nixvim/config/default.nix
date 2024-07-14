{
  imports = [
    ./lsp
    ./lualine

    ./colorschemes.nix
    ./vcs.nix
    ./telescope.nix
    ./neo-tree.nix
    ./guess-indent.nix
    ./comment.nix
    ./todo-comments.nix
    ./treesitter.nix
    ./which-key.nix
    ./notify.nix
    ./conform.nix
    ./cmp.nix
  ];

  globals.mapleader = " ";

  opts = {
    number = true;

    foldmethod = "manual";
    foldlevel = 99;
  };
}
