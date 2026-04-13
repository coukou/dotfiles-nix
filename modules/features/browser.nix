{ ... }: {
  flake.modules.homeManager.browser = { inputs, pkgs, ... }: {
    home.packages = [
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.brave
    ];
  };
}
