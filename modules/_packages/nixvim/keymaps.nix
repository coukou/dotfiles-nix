{
  globals.mapleader = " ";

  keymaps = [
    {
      key = "<leader>y";
      action = "\"+y";
      options.desc = "Copy selection into system clipboard";
    }
    {
      mode = "x";
      key = "p";
      action = "\"_dP";
      options.desc = "do not overwrite currently yanked text when pasting";
    }
    {
      key = "<leader>d";
      action = "\"_d";
      options.desc = "Blackhole delete";
    }
  ];
}
