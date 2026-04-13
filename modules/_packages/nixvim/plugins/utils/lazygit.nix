{
  plugins.lazygit = {
    enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>lg";
      action = "<CMD>LazyGit<CR>";
      options.desc = "Open LazyGit";
    }
  ];
}
