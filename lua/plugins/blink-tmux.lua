return {
  {
    "mgalliou/blink-cmp-tmux",
    lazy = true,
    specs = {
      {
        "Saghen/blink.cmp",
        optional = true,
        opts = {
          sources = {
            default = { "tmux" },
            providers = {
              tmux = { name = "tmux", module = "blink-cmp-tmux" },
            },
          },
        },
      },
    },
  },
  {
    "Kaiser-Yang/blink-cmp-git",
    lazy = true,
    specs = {
      "Saghen/blink.cmp",
      optional = true,
      opts = {
        sources = {
          default = { "git" },
          providers = {
            git = {
              module = "blink-cmp-git",
              name = "Git",
            },
          },
        },
      },
    },
  },
}
