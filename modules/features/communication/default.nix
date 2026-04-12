{ self, ... }: {
  imports = [ ./_discord.nix ./_slack.nix ];

  flake.modules.homeManager.communication = { ... }: {
    imports = with self.modules.homeManager; [
      communication-discord
      communication-slack
    ];
  };
}
