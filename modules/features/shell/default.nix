{ self, ... }: {
  imports = [
    ./_fish.nix
    ./_starship.nix
    ./_ghostty.nix
    ./_kitty.nix
    ./_tmux.nix
  ];

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
