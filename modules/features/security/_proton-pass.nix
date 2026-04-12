{ ... }: {
  flake.modules.homeManager.security-proton-pass = { pkgs, config, ... }: {
    home.packages = with pkgs; [
      proton-pass
      proton-pass-cli
    ];

    home.sessionVariables = {
      PROTON_PASS_LINUX_KEYRING = "dbus";
      SSH_AUTH_SOCK = "${config.home.homeDirectory}/.ssh/proton-pass-agent.sock";
    };

    systemd.user.services.proton-pass-ssh-agent = {
      Unit = {
        Description = "Proton Pass SSH agent";
        After = [ "gnome-keyring-daemon.service" ];
        Wants = [ "gnome-keyring-daemon.service" ];
      };
      Service = {
        ExecStart = "${pkgs.proton-pass-cli}/bin/pass-cli ssh-agent start --vault-name=${config.myConfig.protonPassVault}";
        Environment = [ "PROTON_PASS_LINUX_KEYRING=dbus" ];
        Restart = "on-failure";
        RestartSec = "5";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
