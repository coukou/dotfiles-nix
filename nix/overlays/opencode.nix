{ inputs, system }:
final: prev:
let
  jail = inputs.jail-nix.lib.init final;
  opencode-pkg = inputs.llm-agents.packages.${system}.opencode;
in
{
  opencode = jail "opencode" opencode-pkg (with jail.combinators; (
    [
      network
      time-zone
      no-new-session
      mount-cwd

      (readwrite (noescape "~/.config/opencode"))
      (readwrite (noescape "~/.local/share/opencode"))
      (readwrite (noescape "~/.local/state/opencode"))

      (with final; add-pkg-deps [
        bashInteractive
        curl
        wget
        jq
        git
        which
        ripgrep
        gnugrep
        gawkInteractive
        ps
        findutils
        gzip
        unzip
        gnutar
        diffutils
      ])
    ]
  ));
}
