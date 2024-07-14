{ helpers, ... }:
{
  imports = [
    ./lsp-progress.nix
  ];

  plugins.lualine = {
    enable = true;

    sections = {
      lualine_x = [
        {
          name = "lsp-progress";
          fmt = ''
            function()
              return require('lsp-progress').progress()
            end
          '';
        }
      ];
    };
  };

  autoGroups = {
    lualine_augroup = {
      clear = true;
    };
  };

  autoCmd = [
    {
      event = [ "User" ];
      group = "lualine_augroup";
      pattern = "LspProgressStatusUpdated";
      callback = helpers.mkRaw ''
        require('lualine').refresh
      '';
    }
  ];
}
