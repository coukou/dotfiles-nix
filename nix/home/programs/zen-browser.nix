{ system, inputs, ... }: {
  home.packages = [ inputs.zen-browser.packages."${system}".default ];
}
