{ ... }: {
  flake.modules.homeManager.productivity-notion = { mkNativeWebapp, ... }: {
    home.packages = [
      (mkNativeWebapp {
        name = "notion";
        desktopName = "Notion";
        url = "https://www.notion.so/";
      })
    ];
  };
}
