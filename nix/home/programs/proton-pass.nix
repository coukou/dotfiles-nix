{ pkgs, ... }: {
  home.packages = with pkgs; [
    proton-pass
    proton-pass-cli
  ];
}
