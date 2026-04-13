{ ... }: {
  flake.modules.homeManager.productivity = { mkNativeWebapp, ... }: {
    programs.obsidian.enable = true;

    home.packages = [
      (mkNativeWebapp { name = "draw"; desktopName = "draw"; url = "https://www.tldraw.com/"; })
    ];
  };
}
