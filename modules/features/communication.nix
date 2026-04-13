{ ... }: {
  flake.modules.homeManager.communication = { pkgs, ... }: {
    home.packages = [
      pkgs.vesktop
      (pkgs.discord.override { withOpenASAR = true; withVencord = true; })
      (pkgs.slack.overrideAttrs (old: {
        installPhase = old.installPhase + ''
          sed -i'.backup' -e 's/,"WebRTCPipeWireCapturer"/,"LebRTCPipeWireCapturer"/' $out/lib/slack/resources/app.asar
        '';
      }))
    ];
  };
}
