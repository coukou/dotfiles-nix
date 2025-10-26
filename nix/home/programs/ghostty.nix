{ ... }: {
  programs.ghostty = {
    enable = true;

    installVimSyntax = true;
    enableFishIntegration = true;

    settings = {
      theme = "TokyoNight";
      font-family = "Maple Mono NF";
      font-size = 13;
      window-padding-x = 12;
      window-padding-y = 12;
      cursor-invert-fg-bg = true;
    };
  };
}
