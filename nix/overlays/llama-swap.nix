{ ... }:
(
  final: prev: {
    llama-swap = final.runCommand "llama-swap" { } ''
      mkdir -p $out/bin
      tar -xzf ${
        final.fetchurl {
          url = "https://github.com/mostlygeek/llama-swap/releases/download/v197/llama-swap_197_linux_amd64.tar.gz";
          hash = "sha256-GOP31onCrHvwvutsDXJV0uj+EKKaQdmZfiaBS0tX7Co=";
        }
      } -C $out/bin
      chmod +x $out/bin/llama-swap
    '';
  }
)
