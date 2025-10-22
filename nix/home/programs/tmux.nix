{ pkgs, ... }: {
  programs.tmux = {
    enable = true;

    plugins = with pkgs; [
      tmuxPlugins.tokyo-night-tmux
    ];
  };
}
