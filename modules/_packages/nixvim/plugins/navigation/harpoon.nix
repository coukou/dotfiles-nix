{
  plugins.harpoon = {
    enable = true;
    enableTelescope = true;
  };

  keymaps = [
    {
      key = "<leader>ha";
      action.__raw = ''function() require("harpoon"):list():add() end'';
      options.desc = "Add file to harpoon list";
    }
    {
      key = "<leader>he";
      action.__raw = ''function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end'';
      options.desc = "Toggle harpoon quick menu";
    }
  ];
}
