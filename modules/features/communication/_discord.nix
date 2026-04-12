{ ... }: {
  flake.modules.homeManager.communication-discord = { pkgs, ... }: {
    home.packages = [
      pkgs.vesktop
      (pkgs.discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
    ];
  };
}
