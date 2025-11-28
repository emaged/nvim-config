return {
  "tpope/vim-dadbod",
  specs = {
    {
      "kristijanhusak/vim-dadbod-ui",
      dependencies = { "tpope/vim-dadbod" },
      cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
      },
      specs = {
        {
          "AstroNvim/astrocore",
          opts = {
            options = {
              g = {
                db_use_nerd_fonts = vim.g.icons_enabled and 1 or nil,
              },
            },
          },
        },
      },
    },
    {
      "kristijanhusak/vim-dadbod-completion",
      lazy = true,
      specs = {
        {
          "Saghen/blink.cmp",
          opts = {
            sources = {
              per_filetype = {
                sql = { "snippets", "dadbod", "buffer" },
              },
              -- add vim-dadbod-completion to your completion providers
              providers = {
                dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
              },
            },
          },
        },
      },
    },
  },
}
