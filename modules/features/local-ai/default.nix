{ self, ... }: {
  flake.modules.homeManager.local-ai = { ... }: {
    imports = with self.modules.homeManager; [
      local-ai-llama-swap
      local-ai-pi
    ];
  };
}
