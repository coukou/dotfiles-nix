{ pkgs, ... }: {

  extraPlugins = [
    {
      plugin = (
        pkgs.vimUtils.buildVimPlugin {
          pname = "artemave";
          version = "v1.0.0";
          src = pkgs.fetchFromGitHub {
            owner = "artemave";
            repo = "workspace-diagnostics.nvim";
            rev = "2c911e785f953241704918dcd0dbada8c852d716";
            sha256 = "sha256-d3gkcrprxIUU83ziaJJLSYixMbhkv5htzOLRn58otDo=";
          };
          meta.homepage = "https://github.com/artemave/workspace-diagnostics.nvim";
        }
      );
    }
  ];

  plugins.lsp.onAttach = ''require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)'';
}
