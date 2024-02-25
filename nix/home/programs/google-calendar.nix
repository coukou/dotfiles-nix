{ pkgs, ... }:
let
  calendarScript =
    pkgs.writeScriptBin "google-calendar"
      ''
        ${pkgs.chromium}/bin/chromium --app="https://calendar.google.com/"
      '';

in
{
  home.packages = [
    calendarScript
    (
      pkgs.makeDesktopItem {
        name = "google-calender";
        desktopName = "Google Calendar";
        exec = "${calendarScript}/google-calendar";
      }
    )
  ];
}
