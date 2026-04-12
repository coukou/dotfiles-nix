{ self, ... }: {
  flake.modules.homeManager.shell = { ... }: {
    imports = with self.modules.homeManager; [
      shell-fish
      shell-starship
      shell-ghostty
      shell-kitty
      shell-tmux
    ];
  };
}
