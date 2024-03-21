{ pkgs, ... }:
let
  # Slack with screen sharing patch
  # https://github.com/flathub/com.slack.Slack/issues/101#issuecomment-1927729514
  slack = pkgs.slack.overrideAttrs (previousAttrs: {
    installPhase =
      previousAttrs.installPhase
      + ''
        sed -i'.backup' -e 's/,"WebRTCPipeWireCapturer"/,"LebRTCPipeWireCapturer"/' $out/lib/slack/resources/app.asar

      '';
  });
in
{
  home.packages = [
    slack
  ];
}
