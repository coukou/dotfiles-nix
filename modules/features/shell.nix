{ ... }: {
  flake.modules.nixos.shell = {
    programs.fish.enable = true;
  };

  flake.modules.homeManager.shell = { pkgs, ... }: {
    home.packages = with pkgs; [ jq socat ];

    programs.fish.enable = true;

    programs.starship = {
      enable = true;
      settings = { };
    };

    programs.ghostty = {
      enable = true;
      installVimSyntax = true;
      enableFishIntegration = true;
      settings = {
        theme = "Catppuccin Mocha";
        font-family = "Maple Mono NF";
        font-size = 13;
        window-padding-x = 12;
        window-padding-y = 4;
        cursor-invert-fg-bg = true;
      };
    };

    programs.kitty = {
      enable = true;
      extraConfig = ''
        font_family Maple Mono NF
        font_size 12.0
        window_padding_width 12
        background_opacity 0.62
        backgroud_blur 1
        cursor none
      '';
    };

    programs.tmux = {
      enable = true;
      plugins = with pkgs; [ tmuxPlugins.tokyo-night-tmux ];
      extraConfig = ''
        set -sg escape-time 10
        set-option -g xterm-keys on
        set-option -g terminal-features 'xterm*:extkeys'
        set-option -g allow-passthrough on
        set-option -g set-clipboard on
      '';
    };
  };
}
