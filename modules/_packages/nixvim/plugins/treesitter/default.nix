{ pkgs, ... }: {
  plugins.treesitter = {
    enable = true;

    settings = {
      indent = {
        enable = true;
      };
      highlight = {
        enable = true;
      };
    };

    grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
  };
}
