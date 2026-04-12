{ self, ... }: {
  imports = [ ./_proton-pass.nix ];

  flake.modules.homeManager.security = { ... }: {
    imports = with self.modules.homeManager; [ security-proton-pass ];
  };
}
