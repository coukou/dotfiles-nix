{
  colorschemes.catppuccin = {
    enable = true;
    settings = {
      transparent_background = true;

      custom_highlights.__raw = ''
        function(colors)
          local hl = {
            NeoTreeNormal      = { bg = colors.mantle },
            NeoTreeNormalNC    = { bg = colors.mantle },
            NeoTreeEndOfBuffer = { bg = colors.mantle },

            -- hlchunk bracket and indent guide colours
            HLChunk  = { fg = colors.overlay1 },
            HLIndent = { fg = colors.surface2 },

            WinSeparator = { fg = colors.surface2 },
            FloatBorder  = { fg = colors.overlay0 },
            FloatTitle   = { fg = colors.subtext1, bold = true },

            NormalNC = { fg = colors.overlay1, bg = "NONE" },

            Backdrop = { bg = colors.base },

            TreesitterContext           = { fg = colors.overlay0, bg = colors.mantle },
            TreesitterContextBottom     = { bg = colors.mantle, underline = true, sp = colors.surface1 },
            TreesitterContextLineNumber = { fg = colors.overlay0, bg = colors.mantle },
            BlinkCmpGhostText    = { fg = colors.overlay2, italic = true },
            BlinkCmpMenuBorder   = { fg = colors.overlay0 },
            BlinkCmpDocBorder    = { fg = colors.overlay0 },
            BlinkCmpDocSeparator = { fg = colors.overlay0 },
          }

          -- Blink-cmp kind icons — one colour per LSP kind
          local kinds = {
            Text          = colors.subtext0,
            Method        = colors.blue,
            Function      = colors.blue,
            Constructor   = colors.sapphire,
            Field         = colors.teal,
            Variable      = colors.peach,
            Class         = colors.yellow,
            Interface     = colors.green,
            Module        = colors.lavender,
            Property      = colors.teal,
            Unit          = colors.peach,
            Value         = colors.peach,
            Enum          = colors.yellow,
            Keyword       = colors.mauve,
            Snippet       = colors.green,
            Color         = colors.pink,
            File          = colors.rosewater,
            Reference     = colors.red,
            Folder        = colors.yellow,
            EnumMember    = colors.yellow,
            Constant      = colors.peach,
            Struct        = colors.sky,
            Event         = colors.pink,
            Operator      = colors.sky,
            TypeParameter = colors.teal,
          }
          for kind, color in pairs(kinds) do
            hl["BlinkCmpKind" .. kind] = { fg = color }
          end

          -- Blink-cmp UI groups
          hl.BlinkCmpMenu             = { bg = colors.base }
          hl.BlinkCmpMenuSelection    = { bg = colors.surface0, bold = true }
          hl.BlinkCmpLabel            = { fg = colors.text }
          hl.BlinkCmpLabelMatch       = { fg = colors.blue, bold = true }
          hl.BlinkCmpLabelDescription = { fg = colors.overlay0 }
          hl.BlinkCmpLabelDeprecated  = { fg = colors.overlay0, strikethrough = true }
          hl.BlinkCmpSource           = { fg = colors.surface2 }
          hl.BlinkCmpDoc              = { bg = colors.base }
          hl.BlinkCmpDocCursorLine    = { bg = colors.surface0 }
          hl.BlinkCmpScrollBarThumb   = { bg = colors.surface1 }
          hl.BlinkCmpScrollBarGutter  = { bg = colors.mantle }

          return hl
        end
      '';
    };
  };

  opts = {
    termguicolors = true;
    winborder = "single";

    fillchars = {
      vert = "│";
      horiz = "─";
      horizup = "┴";
      horizdown = "┬";
      vertleft = "┤";
      vertright = "├";
      verthoriz = "┼";
      eob = " ";
    };
  };

  # fillchars set again post-startup to survive any plugin that resets them.
  # Also patches lualine section backgrounds here — custom_highlights runs
  # before lualine's own ColorScheme handler and gets overwritten, so the
  # only reliable fix is vim.schedule'd nvim_set_hl after lualine has fired.
  extraConfigLuaPost = ''
    vim.opt.fillchars = {
      vert      = "│",
      horiz     = "─",
      horizup   = "┴",
      horizdown = "┬",
      vertleft  = "┤",
      vertright = "├",
      verthoriz = "┼",
      eob       = " ",
    }

    do
      local function patch_lualine()
        vim.schedule(function()
          local ok, c = pcall(function() return require("catppuccin.palettes").get_palette() end)
          if not ok then return end
          local mantle = tonumber(c.mantle:sub(2), 16)
          local modes  = { "normal", "insert", "visual", "replace", "command", "terminal", "inactive" }
          for _, mode in ipairs(modes) do
            for _, sec in ipairs({ "b", "c" }) do
              local name = "lualine_" .. sec .. "_" .. mode
              local hl   = vim.api.nvim_get_hl(0, { name = name, link = false })
              if next(hl) then
                hl.bg = mantle
                vim.api.nvim_set_hl(0, name, hl)
              end
            end
          end
        end)
      end

      patch_lualine()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = patch_lualine })
    end

    -- Backdrop: show a dark overlay behind any focused float --------------------
    do
      local function open_backdrop(cfg)
        local buf = vim.api.nvim_create_buf(false, true)
        local bd  = vim.api.nvim_open_win(buf, false, {
          relative  = "editor",
          row       = 0,
          col       = 0,
          width     = vim.o.columns,
          height    = vim.o.lines,
          style     = "minimal",
          border    = "none",
          focusable = false,
          zindex    = math.max(1, (cfg.zindex or 50) - 1),
        })
        vim.wo[bd].winhighlight = "Normal:Backdrop,EndOfBuffer:Backdrop"
        vim.wo[bd].winblend     = 30
        return bd, buf
      end

      -- Create backdrop when entering a float from a non-float window
      vim.api.nvim_create_autocmd("WinEnter", {
        callback = function()
          local win = vim.api.nvim_get_current_win()
          local cfg = vim.api.nvim_win_get_config(win)
          if cfg.relative == "" then return end

          local prev_winnr = vim.fn.winnr("#")
          if prev_winnr ~= 0 then
            local prev_win = vim.fn.win_getid(prev_winnr)
            if vim.api.nvim_win_is_valid(prev_win)
              and vim.api.nvim_win_get_config(prev_win).relative ~= "" then
              return
            end
          end

          local bd, buf = open_backdrop(cfg)
          vim.api.nvim_create_autocmd("WinClosed", {
            pattern  = tostring(win),
            once     = true,
            callback = function()
              pcall(vim.api.nvim_win_close, bd, true)
              pcall(vim.api.nvim_buf_delete, buf, { force = true })
            end,
          })
        end,
      })

      -- Resize all backdrop windows when the terminal is resized
      vim.api.nvim_create_autocmd("VimResized", {
        callback = function()
          for _, w in ipairs(vim.api.nvim_list_wins()) do
            local ok, hl = pcall(function() return vim.wo[w].winhighlight end)
            if ok and hl and hl:find("Backdrop") then
              pcall(vim.api.nvim_win_set_config, w, {
                relative = "editor",
                row = 0, col = 0,
                width  = vim.o.columns,
                height = vim.o.lines,
              })
            end
          end
        end,
      })
    end
  '';
}
