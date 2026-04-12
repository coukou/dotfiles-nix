{ ... }: {
  flake.modules.homeManager.productivity-proton-pass = { pkgs, config, ... }: {
    home.packages = with pkgs; [
      proton-pass
      proton-pass-cli
    ];

    home.sessionVariables = {
      PROTON_PASS_LINUX_KEYRING = "dbus";
      SSH_AUTH_SOCK = "${config.home.homeDirectory}/.ssh/proton-pass-agent.sock";
    };
  };
}
