{ pkgs, toLua, ... }: {

  extraPlugins = [
    {
      plugin = (
        pkgs.vimUtils.buildVimPlugin {
          pname = "lsp-progress";
          version = "v1.0.9";
          src = pkgs.fetchFromGitHub {
            owner = "linrongbin16";
            repo = "lsp-progress.nvim";
            rev = "c336039f3b03176a7b2f0c585a0e78056769b681";
            sha256 = "sha256-wCVh/cZ7E60G4R+b8qzb8t7vGEMRA+469jCPsiyNlKw=";
          };
          meta.homepage = "https://github.com/linrongbin16/lsp-progress.nvim";
        }
      );
      config = toLua ''
        require("lsp-progress").setup {}
      '';
    }
  ];

}
