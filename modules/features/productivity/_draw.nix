{ ... }: {
  flake.modules.homeManager.productivity-draw = { mkNativeWebapp, ... }: {
    home.packages = [
      (mkNativeWebapp {
        name = "draw";
        desktopName = "draw";
        url = "https://www.tldraw.com/";
      })
    ];
  };
}
