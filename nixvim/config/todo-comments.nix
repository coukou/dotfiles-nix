{ helpers, ... }:
{
  keymaps = [
    {
      mode = "n";
      key = "]t";
      action = helpers.mkRaw ''
        function()
          require("todo-comments").jump_next()
        end
      '';
      options.desc = "Jump to next todo";
    }
    {
      mode = "n";
      key = "[t";
      action = helpers.mkRaw ''
        function()
          require("todo-comments").jump_prev()
        end
      '';
      options.desc = "Jump to previous todo";
    }
  ];

  plugins.todo-comments = {
    enable = true;
  };
}
