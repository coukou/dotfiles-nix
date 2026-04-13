{
  plugins.neo-tree = {
    enable = true;
  };

  plugins.oil = {
    enable = true;
  };

  keymaps = [
    {
      key = "<C-b>";
      action = "<CMD>Neotree toggle<CR>";
      options.desc = "Open neotree";
    }
    {
      key = "-";
      action = "<CMD>Oil<CR>";
      options.desc = "Open oil";
    }
  ];
}
