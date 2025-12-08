return {pkgs={{dir="/home/emiel/.local/share/nvim/lazy/astrocore",spec=function()
return {
  "AstroNvim/astrocore",
  opts_extend = {
    "rooter.ignore.servers",
    "rooter.ignore.dirs",
    "sessions.ignore.buftypes",
    "sessions.ignore.dirs",
    "sessions.ignore.filetypes",
    "git_worktrees",
  },
}

end,source="lazy",file="lazy.lua",name="astrocore",},{dir="/home/emiel/.local/share/nvim/lazy/astrolsp",spec=function()
return {
  "AstroNvim/astrolsp",
  opts_extend = {
    "formatting.disabled",
    "formatting.format_on_save.allow_filetypes",
    "formatting.format_on_save.ignore_filetypes",
    "servers",
  },
}

end,source="lazy",file="lazy.lua",name="astrolsp",},{dir="/home/emiel/.local/share/nvim/lazy/astroui",spec=function()
return {
  "AstroNvim/astroui",
  opts_extend = {
    "status.winbar.enabled.filetype",
    "status.winbar.enabled.buftype",
    "status.winbar.enabled.bufname",
    "status.winbar.disabled.filetype",
    "status.winbar.disabled.buftype",
    "status.winbar.disabled.bufname",
  },
}

end,source="lazy",file="lazy.lua",name="astroui",},{dir="/home/emiel/.local/share/nvim/lazy/blink.compat",spec=function()
return {
  {
    'saghen/blink.compat',
    lazy = true,
  },
}

end,source="lazy",file="lazy.lua",name="blink.compat",},{dir="/home/emiel/.local/share/nvim/lazy/plenary.nvim",spec={"nvim-lua/plenary.nvim",lazy=true,},source="lazy",file="community",name="plenary.nvim",},{dir="/home/emiel/.local/share/nvim/lazy/yazi.nvim",spec=function()
-- This file is used to define the dependencies of this plugin when the user is
-- using lazy.nvim.
--
-- If you are curious about how exactly the plugins are used, you can use e.g.
-- the search functionality on Github.
--
--https://lazy.folke.io/packages#lazy

---@module "lazy"
---@module "yazi"

---@type LazySpec
return {
  -- Needed for file path resolution mainly
  --
  -- https://github.com/nvim-lua/plenary.nvim/
  { "nvim-lua/plenary.nvim", lazy = true },

  {
    "mikavilpas/yazi.nvim",
    ---@type YaziConfig | {}
    opts = {},
    cmd = {
      "Yazi",
      "Yazi cwd",
      "Yazi toggle",
    },
  },
}

end,source="lazy",file="lazy.lua",name="yazi.nvim",},},version=12,}