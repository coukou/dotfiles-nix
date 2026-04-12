{ pkgs, ... }: {
  plugins.lsp = {
    enable = true;
    inlayHints = true;

    servers = {
      nil_ls = {
        enable = true;

        settings = {
          formatting = {
            command = [ "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt" ];
          };
        };
      };

      rust_analyzer = {
        enable = true;

        installRustc = false;
        installCargo = false;
      };

      ts_ls = {
        enable = true;
      };

      oxlint = {
        enable = true;
      };

      svelte = {
        enable = true;
      };

      tailwindcss = {
        enable = true;
      };

    };

    keymaps = {
      silent = true;
      lspBuf = {
        gd = {
          action = "definition";
          desc = "Goto definition";
        };
        K = {
          action = "hover";
          desc = " Hover";
        };
        "<leader>r" = {
          action = "rename";
          desc = "LSP rename";
        };
      };
    };
  };
}
