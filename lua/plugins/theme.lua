return {
  {
    "AstroNvim/astroui",
    opts = function(_, opts)
      local theme_file = vim.fn.expand "~/.config/omarchy/current/theme/neovim.lua"
      local ok, theme_spec = pcall(dofile, theme_file)

      if not ok or type(theme_spec) ~= "table" then return end

      for _, spec in ipairs(theme_spec) do
        if type(spec) == "table" and spec[1] == "LazyVim/LazyVim" and spec.opts and spec.opts.colorscheme then
          local cs = spec.opts.colorscheme

          -- 🔥 Force mocha if catppuccin
          if cs == "catppuccin" then cs = "catppuccin-mocha" end

          opts.colorscheme = cs
          break
        end
      end
    end,
  },
}
