{ pkgs, ... }: {
  home.packages = [
    (
      pkgs.makeDesktopItem {
        name = "gmail";
        desktopName = "GMail";
        exec = "${pkgs.chromium}/bin/chromium --app=\"https://gmail.com/\"";
      }
    )
  ];
}
