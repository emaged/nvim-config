return {
  {
    "AstroNvim/astroui",
    opts = function(_, opts)
      local theme_file = vim.fn.expand "~/.config/omarchy/current/theme/neovim.lua"
      local ok, theme_spec = pcall(dofile, theme_file)

      if not ok or type(theme_spec) ~= "table" then return end

      for _, spec in ipairs(theme_spec) do
        if spec.opts and spec.opts.colorscheme then
          opts.colorscheme = spec.opts.colorscheme
          break
        end
      end
    end,
  },
}
