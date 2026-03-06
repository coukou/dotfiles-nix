args: [
  (import (./opencode.nix) args)
  (import (./neovim.nix) args)
  (import (./llama-cpp.nix) args)
  (import (./llama-swap.nix) args)
]
