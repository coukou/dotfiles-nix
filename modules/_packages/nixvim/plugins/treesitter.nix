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

  plugins.treesitter-context = {
    enable = true;
    settings = {
      max_lines = 1;
    };
  };
}
