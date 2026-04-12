{ self, ... }: {
  flake.modules.homeManager.ai = { ... }: {
    imports = with self.modules.homeManager; [ ai-opencode ];
  };
}
