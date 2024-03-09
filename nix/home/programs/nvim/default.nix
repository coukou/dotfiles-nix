{ lib, config, pkgs, ... }:
{
  programs.neovim =
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
      enable = true;
      vimAlias = true;

      extraPackages = with pkgs; [
        xclip
        wl-clipboard

        rust-analyzer
        lua-language-server
        nil
        nodePackages.typescript-language-server
        nodePackages."@astrojs/language-server"

        stylua
        prettierd
        eslint_d
        ripgrep
      ];

      extraConfig = ''
        colorscheme catppuccin
        set rnu
      '';

      plugins = with pkgs.vimPlugins; [
        {
          plugin = catppuccin-nvim;
          config = toLua ''
            require("catppuccin").setup({
              transparent_background = true
            })
          '';
        }

        {
          plugin = lualine-nvim;
          config = toLuaFile ./lua/lualine.lua;
        }

        {
          plugin = gitsigns-nvim;
          config = toLua ''
            require("gitsigns").setup {}
          '';
        }

        {
          plugin = orgmode;
          config = toLuaFile ./lua/orgmode.lua;
        }

        {
          plugin = neo-tree-nvim;
          config = toLuaFile ./lua/neo-tree.lua;
        }

        {
          plugin = telescope-nvim;
          config = toLuaFile ./lua/telescope.lua;
        }

        {
          plugin = conform-nvim;
          config = toLuaFile ./lua/conform.lua;
        }

        {
          plugin = nvim-lint;
          config = toLuaFile ./lua/nvim-lint.lua;
        }

        {
          plugin = guess-indent-nvim;
          config = toLua ''
            require('guess-indent').setup {}
          '';
        }

        {
          plugin = comment-nvim;
          config = toLua ''
            require('Comment').setup()
          '';
        }

        luasnip

        # cmp
        cmp_luasnip
        {
          plugin = nvim-cmp;
          config = toLuaFile ./lua/cmp.lua;
        }

        # LSP
        cmp-nvim-lsp
        {
          plugin = nvim-lspconfig;
          config = toLuaFile ./lua/lsp.lua;
        }

        # Treesitter
        {
          plugin = nvim-treesitter.withAllGrammars;
          config = toLuaFile ./lua/treesitter.lua;
        }

        # Others
        neodev-nvim
        nvim-web-devicons
        vim-nix
      ];
    };
}
