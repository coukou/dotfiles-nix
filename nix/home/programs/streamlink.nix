{pkgs, ... }: {
  home.packages = with pkgs; [
    streamlink
  ];
}
