{ pkgs, ... }:
{
  programs.neovim =
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";

      lsp-progress = pkgs.vimUtils.buildVimPlugin {
        pname = "lsp-progress";
        version = "v1.0.9";
        src = pkgs.fetchFromGitHub {
          owner = "linrongbin16";
          repo = "lsp-progress.nvim";
          rev = "c336039f3b03176a7b2f0c585a0e78056769b681";
          sha256 = "sha256-wCVh/cZ7E60G4R+b8qzb8t7vGEMRA+469jCPsiyNlKw=";
        };
        meta.homepage = "https://github.com/linrongbin16/lsp-progress.nvim";
      };
    in
    {
      enable = true;
      vimAlias = true;

      extraPackages = with pkgs; [
        ripgrep

        rust-analyzer
        lua-language-server
        nil
        nodePackages.typescript-language-server
        nodePackages."@astrojs/language-server"
        prettierd
        eslint_d
        stylua
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

        # Lualine
        {
          plugin = lualine-nvim;
          config = toLuaFile ./lua/lualine.lua;
        }
        lsp-progress

        # Git
        {
          plugin = gitsigns-nvim;
          config = toLua ''
            require("gitsigns").setup {}
          '';
        }

        # File explorer
        {
          plugin = neo-tree-nvim;
          config = toLuaFile ./lua/neo-tree.lua;
        }

        # Telescope
        {
          plugin = telescope-nvim;
          config = toLuaFile ./lua/telescope.lua;
        }

        # Formatter
        {
          plugin = conform-nvim;
          config = toLuaFile ./lua/conform.lua;
        }

        # Linter
        {
          plugin = nvim-lint;
          config = toLuaFile ./lua/nvim-lint.lua;
        }

        # Indent utils
        {
          plugin = guess-indent-nvim;
          config = toLua ''
            require('guess-indent').setup {}
          '';
        }

        # Comment
        {
          plugin = comment-nvim;
          config = toLua ''
            require('Comment').setup()
          '';
        }
        {
          plugin = todo-comments-nvim;
          config = toLuaFile ./lua/todo-comments.lua;
        }

        # CMP
        {
          plugin = nvim-cmp;
          config = toLuaFile ./lua/cmp.lua;
        }
        lspkind-nvim
        lsp_signature-nvim

        # Snippet
        luasnip
        cmp_luasnip

        # LSP
        cmp-nvim-lsp
        {
          plugin = nvim-lspconfig;
          config = toLuaFile ./lua/lsp.lua;
        }

        # whichkey
        {
          plugin = which-key-nvim;
          config = toLuaFile ./lua/which-key.lua;
        }

        # Treesitter
        {
          plugin = nvim-treesitter.withAllGrammars;
          config = toLuaFile ./lua/treesitter.lua;
        }

        # Notification
        {
          plugin = nvim-notify;
          config = toLuaFile ./lua/notify.lua;
        }

        # Others
        neodev-nvim
        nvim-web-devicons
        vim-nix
        twilight-nvim
        zen-mode-nvim
      ];
    };
}
