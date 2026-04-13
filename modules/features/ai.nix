{ ... }: {
  flake.modules.nixos.ai = { inputs, system, ... }: {
    nixpkgs.overlays = [
      (final: prev:
        let
          jail = inputs.jail-nix.lib.init final;
          opencode-pkg = inputs.llm-agents.packages.${system}.opencode;
        in
        {
          opencode = jail "opencode" opencode-pkg (with jail.combinators; [
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
              ast-grep
              gnugrep
              gawkInteractive
              ps
              findutils
              gzip
              unzip
              gnutar
              diffutils
            ])
          ]);
        }
      )
      (final: prev:
        let
          jail = inputs.jail-nix.lib.init final;
          pi-pkg = inputs.llm-agents.packages.${system}.pi;
        in
        {
          pi = jail "pi" pi-pkg (with jail.combinators; [
            network
            time-zone
            no-new-session
            mount-cwd
            (readwrite (noescape "~/.pi"))
            (with final; add-pkg-deps [
              bashInteractive
              curl
              wget
              jq
              git
              which
              ripgrep
              ast-grep
              gnugrep
              gawkInteractive
              ps
              findutils
              gzip
              unzip
              gnutar
              diffutils
            ])
          ]);
        }
      )
    ];
  };

  flake.modules.homeManager.ai = { pkgs, ... }: {
    programs.opencode.enable = true;
    home.packages = [ pkgs.pi ];
  };
}
