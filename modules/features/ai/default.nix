{ self, ... }: {
  imports = [ ./_opencode.nix ./_pi.nix ];

  flake.modules.nixos.ai = { ... }: {
    imports = with self.modules.nixos; [ ai-opencode ai-pi ];
  };

  flake.modules.homeManager.ai = { ... }: {
    imports = with self.modules.homeManager; [ ai-opencode ai-pi ];
  };
}
