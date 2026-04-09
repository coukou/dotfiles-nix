{ pkgs, ... }: {
  home.packages = with pkgs; [
    proton-pass
    proton-pass-cli
  ];

  home.sessionVariables = {
    PROTON_PASS_LINUX_KEYRING = "dbus";
  };

}
