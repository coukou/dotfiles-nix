{
  plugins.comment = {
    enable = true;
  };

  plugins.nvim-surround = {
    enable = true;
  };

  plugins.nvim-ufo = {
    enable = true;

    luaConfig.post = #lua
      ''
        vim.o.foldcolumn = '1'
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
        vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:'
      '';
  };

  plugins.persistence = {
    enable = true;
  };
}
