{ ... }: {
  flake.modules.homeManager.ai-opencode = { ... }: {
    programs.opencode.enable = true;
  };
}
