-- =========================
-- Keymaps (run immediately)
-- =========================

-- Select all with Ctrl + A
vim.keymap.set("n", "<leader>a", "ggVG", { noremap = true, silent = true })

-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEORE ENABLING THIS FILE
-- Here are some examples:
---@type LazySpec
return { -- == Examples of Adding Plugins == 
    { 
        "andweeb/presence.nvim" 
    },

    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function()
            require("lsp_signature").setup()
        end
    }, -- == Examples of Overriding Plugins ==
    
    -- customize dashboard options
    {
        "folke/snacks.nvim",
        opts = {
            dashboard = {
                preset = {
                    header = table.concat(
                        {" █████  ███████ ████████ ██████   ██████ ",
                         "██   ██ ██         ██    ██   ██ ██    ██",
                         "███████ ███████    ██    ██████  ██    ██",
                         "██   ██      ██    ██    ██   ██ ██    ██",
                         "██   ██ ███████    ██    ██   ██  ██████ ",
                         "",
                         "███    ██ ██    ██ ██ ███    ███",
                         "████   ██ ██    ██ ██ ████  ████",
                         "██ ██  ██ ██    ██ ██ ██ ████ ██",
                         "██  ██ ██  ██  ██  ██ ██  ██  ██",
                         "██   ████   ████   ██ ██      ██"
                        }, "\n")
                }
            }
        }
    },
    
    -- You can disable default plugins as follows:
    {
        "max397574/better-escape.nvim",
        enabled = false
    },
    
    -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
    {
        "L3MON4D3/LuaSnip",
        config = function(plugin, opts)
            require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
            -- add more custom luasnip configuration such as filetype extend or custom snippets
            local luasnip = require "luasnip"
            luasnip.filetype_extend("javascript", {"javascriptreact"})
        end
    },

    {
        "windwp/nvim-autopairs",
        config = function(plugin, opts)
            require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
            -- add more custom autopairs configuration such as custom rules
            local npairs = require "nvim-autopairs"
            local Rule = require "nvim-autopairs.rule"
            local cond = require "nvim-autopairs.conds"
            npairs.add_rules({Rule("$", "$", {"tex", "latex"}) -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%") -- don't add a pair if  the previous character is xxx
            :with_pair(cond.not_before_regex("xxx", 3)) -- don't move right when repeat character
            :with_move(cond.none()) -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx") -- disable adding a newline when you press <cr>
            :with_cr(cond.none())}, -- disable for .vim files, but it work for another filetypes
            Rule("a", "a", "-vim"))
        end
    },

    {
        "jake-stewart/multicursor.nvim",
        branch = "1.0",
        config = function()
            local mc = require("multicursor-nvim")
            mc.setup()

            local set = vim.keymap.set

            -- Add or skip cursor above/below the main cursor.
            set({"n", "x"}, "<up>", function()
                mc.lineAddCursor(-1)
            end)
            set({"n", "x"}, "<down>", function()
                mc.lineAddCursor(1)
            end)
            set({"n", "x"}, "<leader><up>", function()
                mc.lineSkipCursor(-1)
            end)
            set({"n", "x"}, "<leader><down>", function()
                mc.lineSkipCursor(1)
            end)

            -- Add or skip adding a new cursor by matching word/selection
            set({"n", "x"}, "<leader>m", function()
                mc.matchAddCursor(1)
            end)
            set({"n", "x"}, "<leader>z", function()
                mc.matchSkipCursor(1)
            end)
            set({"n", "x"}, "<leader>M", function()
                mc.matchAddCursor(-1)
            end)
            set({"n", "x"}, "<leader>Z", function()
                mc.matchSkipCursor(-1)
            end)

            -- Advanced Actions
            -- Pressing `gaip` will add a cursor on each line of a paragraph.
            set("n", "ga", mc.addCursorOperator)

            -- Add and remove cursors with control + left click.
            set("n", "<c-leftmouse>", mc.handleMouse)
            set("n", "<c-leftdrag>", mc.handleMouseDrag)
            set("n", "<c-leftrelease>", mc.handleMouseRelease)

            -- Disable and enable cursors.
            set({"n", "x"}, "<c-q>", mc.toggleCursor)

            -- Mappings defined in a keymap layer only apply when there are
            -- multiple cursors. This lets you have overlapping mappings.
            mc.addKeymapLayer(function(layerSet)

                -- Select a different cursor as the main one.
                layerSet({"n", "x"}, "<left>", mc.prevCursor)
                layerSet({"n", "x"}, "<right>", mc.nextCursor)

                -- Delete the main cursor.
                layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)

                -- Enable and clear cursors using escape.
                layerSet("n", "<esc>", function()
                    if not mc.cursorsEnabled() then
                        mc.enableCursors()
                    else
                        mc.clearCursors()
                    end
                end)
            end)

            -- Customize how cursors look.
            local hl = vim.api.nvim_set_hl
            hl(0, "MultiCursorCursor", {
                reverse = true
            })
            hl(0, "MultiCursorVisual", {
                link = "Visual"
            })
            hl(0, "MultiCursorSign", {
                link = "SignColumn"
            })
            hl(0, "MultiCursorMatchPreview", {
                link = "Search"
            })
            hl(0, "MultiCursorDisabledCursor", {
                reverse = true
            })
            hl(0, "MultiCursorDisabledVisual", {
                link = "Visual"
            })
            hl(0, "MultiCursorDisabledSign", {
                link = "SignColumn"
            })
        end
    },

    -- AstroCommunity    
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.recipes.vscode" },

    -- Mini plugins
    { 
    'echasnovski/mini.surround', version = false,
    config = function()
        require("mini.surround").setup()
    end
    },

    -- UndoTree
    { 
    "mbbill/undotree", 
    config = function()
        vim.o.undofile = true
        vim.o.undodir = vim.fn.stdpath("data") .. "/undo"
        vim.keymap.set("n", "<leader>U", ":UndotreeToggle<CR>")
    end
    },

    -- Lorem ipsum generator
    {
    "derektata/lorem.nvim",
    config = function()
        require("lorem").opts {
            sentence_length = "mixed", -- using a default configuration
            comma_chance = 0.3, -- 30% chance to insert a comma
            max_commas = 2, -- maximum 2 commas per sentence
            debounce_ms = 200 -- default debounce time in milliseconds
        }
    end
    }
}

