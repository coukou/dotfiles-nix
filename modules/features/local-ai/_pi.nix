{ ... }: {
  flake.modules.nixos.local-ai-pi = { inputs, system, ... }: {
    nixpkgs.overlays = [
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
              bashInteractive curl wget jq git which ripgrep
              ast-grep gnugrep gawkInteractive ps findutils
              gzip unzip gnutar diffutils
            ])
          ]);
        }
      )
    ];
  };

  flake.modules.homeManager.local-ai-pi = { pkgs, ... }: {
    home.packages = [ pkgs.pi ];
  };
}
