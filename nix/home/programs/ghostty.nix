{ ... }: {
  programs.ghostty = {
    enable = true;

    installVimSyntax = true;
    enableFishIntegration = true;

    settings = {
      theme = "tokyonight";
      font-family = "Maple Mono NF";
      font-size = 12;
      window-padding-x = 12;
      window-padding-y = 12;
      cursor-invert-fg-bg = true;
    };
  };
}
