{ pkgs, ... }:
{

  extraPackages = with pkgs; [
    nixpkgs-fmt
  ];

  plugins.lsp.servers.nil-ls = {
    enable = true;

    settings = {
      formatting = {
        command = [ "nixpkgs-fmt" ];
      };
    };
  };
}
