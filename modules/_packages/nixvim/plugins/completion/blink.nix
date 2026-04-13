{
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
            border = "rounded";
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
          menu = {
            border = "rounded";
          };
          documentation = {
            auto_show = true;
            window = {
              border = "rounded";
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
