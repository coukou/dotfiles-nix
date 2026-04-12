{

  plugins.snacks = {
    settings = {
      input = {
        enabled = true;
      };
    };
  };

  plugins.codecompanion = {
    enable = true;

    settings = {

      adapters = {
        http = {
          local-qwen.__raw = ''function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "http://127.0.0.1:10001",
                model = "Qwen3.5-9B"
              },
            })
          end'';
        };
      };

      strategies = {
        chat = {
          adapter = "opencode";
        };
        inline = {
          adapter = "local-qwen";
        };
      };
    };
  };

  keymaps = [
    {
      key = "<leader>ac";
      action = "<CMD>CodeCompanionChat<CR>";
      options.desc = "Open codecompanion chat";
    }
    {
      key = "<leader>aa";
      action = "<CMD>CodeCompanionActions<CR>";
      options.desc = "Open codecompanion action";
    }
  ];
}

