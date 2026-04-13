{
  plugins.neo-tree = {
    enable = true;
  };

  keymaps = [
    {
      key = "<C-b>";
      action = "<CMD>Neotree toggle<CR>";
      options.desc = "Open neotree";
    }
  ];
}
