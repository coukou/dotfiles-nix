{ ... }: {
  plugins = {
    blink-compat = {
      enable = true;
      settings = {
        debug = false;
        impersonate_nvim_cmp = true;
      };
    };

    blink-cmp = {
      enable = true;

      settings = {
        keymap = {
          preset = "super-tab";
        };

        signature = {
          enabled = true;
          window = {
            border = "single";
          };
        };

        sources = {
          default = [
            "lsp"
            "path"
            "buffer"
          ];
        };

        completion = {
          ghost_text = {
            enabled = true;
          };

          menu = {
            border = "single";
            draw = {
              columns.__raw = ''{ { "kind_icon", gap = 1 }, { "label", "label_description", gap = 1 } }'';
            };
          };

          documentation = {
            auto_show = true;
            window = {
              border = "single";
            };
          };
        };
      };
    };

    lsp.setupWrappers = [
      (s: ''
        (function(config)
          if config ~= nil then
            config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
          end
          return config
        end)(${s})
      '')
    ];
  };
}
