{
  keymaps = [
    {
      mode = "n";
      key = "<C-b>";
      action = "<Cmd>Neotree focus<CR>";
      options.desc = "Open / Focus Neotree";
    }
  ];
  plugins.neo-tree = {
    enable = true;
  };
}
