{ self, ... }: {
  imports = [ ./_llama-cpp.nix ./_llama-swap.nix ];

  flake.modules.nixos.local-ai = { ... }: {
    imports = with self.modules.nixos; [ local-ai-llama-cpp local-ai-llama-swap ];
  };

  flake.modules.homeManager.local-ai = { ... }: {
    imports = with self.modules.homeManager; [ local-ai-llama-swap ];
  };
}
