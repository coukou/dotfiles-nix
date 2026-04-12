{ self, ... }: {
  flake.modules.homeManager.communication = { ... }: {
    imports = with self.modules.homeManager; [
      communication-discord
      communication-slack
    ];
  };
}
