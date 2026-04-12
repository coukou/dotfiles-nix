{ self, ... }: {
  imports = [ ./_opencode.nix ];

  flake.modules.homeManager.ai = { ... }: {
    imports = with self.modules.homeManager; [ ai-opencode ];
  };
}
