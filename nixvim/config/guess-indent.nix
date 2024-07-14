{ pkgs, toLua, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = guess-indent-nvim;
      config = toLua ''
        require('guess-indent').setup {}
      '';
    }
  ];
}
