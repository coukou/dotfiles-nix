{ pkgs, ... }: {
  programs.tmux = {
    enable = true;

    plugins = with pkgs; [
      tmuxPlugins.tokyo-night-tmux
    ];

    extraConfig = ''
      set -sg escape-time 10
      set-option -g xterm-keys on
      set-option -g terminal-features 'xterm*:extkeys'
      set-option -g allow-passthrough on
      set-option -g set-clipboard on
    '';
  };
}
