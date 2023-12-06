
{ lib, config, pkgs, ... }:

let 
  cfg = config.apps.nvim;
in
{
  options.apps.nvim = { enable = lib.mkEnableOption "nvim"; };
  config = lib.mkIf cfg.enable {
    programs.neovim = 
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
      enable = true;
      vimAlias = true;

      extraPackages = with pkgs; [
        lua-language-server
        rnix-lsp

        xclip
        wl-clipboard
      ];


      plugins = with pkgs.vimPlugins; [

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
  };
}
