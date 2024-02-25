{ pkgs, ... }: {
  home.packages = [
    (
      pkgs.makeDesktopItem {
        name = "notion";
        desktopName = "Notion";
        exec = "${pkgs.chromium}/bin/chromium --app=\"https://www.notion.so/\"";
      }
    )
  ];
}
