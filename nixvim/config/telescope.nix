{ pkgs, ... }:
{
  extraPackages = with pkgs; [ ripgrep ];
  plugins.telescope = {
    enable = true;
    settings = {
      file_ignore_patterns = [
        "node_modules"
      ];
    };

    keymaps = {
      "<leader>ff" = "find_files";
      "<leader>fb" = "buffers";
      "<leader>fw" = "live_grep";
      "<leader>gb" = "git_branches";
      "<leader>gc" = "git_commits";
      "<leader>gt" = "git_status";
      "<leader>ls" = "lsp_document_symbols";
      "<leader>lG" = "lsp_workspace_symbols";
    };
  };
}
