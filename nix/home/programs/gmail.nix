{ mkNativeWebapp, ... }: {
  home.packages = [
    (
      mkNativeWebapp {
        name = "gmail";
        desktopName = "GMail";
        url = "https://gmail.com/";
      }
    )
  ];
}
