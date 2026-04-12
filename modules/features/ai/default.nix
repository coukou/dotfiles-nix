{ self, ... }: {
  imports = [ ./_opencode.nix ];

  flake.modules.nixos.ai = { ... }: {
    imports = [ self.modules.nixos.ai-opencode ];
  };

  flake.modules.homeManager.ai = { ... }: {
    imports = with self.modules.homeManager; [ ai-opencode ];
  };
}
