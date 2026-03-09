-- removing default screen



-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "stevearc/conform.nvim",
        opts = {
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },

            formatters_by_ft = {
                python = { "black" },
                go = { "gofmt" },
                vue = { "prettier" },        
                markdown = { "prettier" },    
            },
        },
    },

    -------------------------------------------------
    -- Dependencies
    -------------------------------------------------
    { "nvim-lua/plenary.nvim", lazy = false },

    -------------------------------------------------
    -- Mason
    -------------------------------------------------
    {
        "williamboman/mason.nvim",
        config = true,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { 
                "pyright",
                "gopls",
                "ts_ls",        -- TypeScript
            },
        },
    },

    -------------------------------------------------
    -- Native LSP (Neovim 0.11+)
    -------------------------------------------------
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Python
            vim.lsp.config("pyright", {})
            vim.lsp.enable("pyright")

            -- Go
            vim.lsp.config("gopls", {})
            vim.lsp.enable("gopls")


            -- TypeScript
            vim.lsp.config("ts_ls", {})
            vim.lsp.enable("ts_ls")

            -- Vue (Volar)
            vim.lsp.config("volar", {})
            vim.lsp.enable("volar")


            -- LSP keymaps
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local opts = { buffer = args.buf }

                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                end,
            })
        end,
    },

    -------------------------------------------------
    -- Autocomplete
    -------------------------------------------------
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },

                },
            })
        end,
    },

    -------------------------------------------------
    -- Treesitter (CORRECT modern setup)
    -------------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            ensure_installed = { 
                "python", 
                "go",
                "lua",
                "vue",          
                "javascript",   
                "typescript",   
                "tsx",           
                "markdown",         
                "markdown_inline",  
            },
            highlight = { enable = true },
            indent = { enable = true },
        },
    },

    -------------------------------------------------
    -- Telescope
    -------------------------------------------------
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>pf", builtin.find_files)
            vim.keymap.set("n", "<leader>ps", builtin.live_grep)
            vim.keymap.set("n", "<leader>pb", builtin.buffers)
            vim.keymap.set("n", "<leader>pg", builtin.git_files)
        end,
    },

    -------------------------------------------------
    -- Auto Pairs
    -------------------------------------------------
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        dependencies = { "hrsh7th/nvim-cmp" },
        config = function()
            local npairs = require("nvim-autopairs")

            npairs.setup({
                check_ts = true, -- use treesitter
            })

            -- integration with nvim-cmp
            local cmp = require("cmp")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on(
                "confirm_done",
                cmp_autopairs.on_confirm_done()
            )
        end,
    },
    -------------------------------------------------
    -- Comment Toggle
    -------------------------------------------------
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require("Comment").setup()
        end,
    },


    -- running git in neovim
    {
        "tpope/vim-fugitive",
        cmd = { "Git" },
    },



    --git  signs in neovim
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "│" },
                    change = { text = "│" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
            })

            -- Optional keymaps
            vim.keymap.set("n", "]h", require("gitsigns").next_hunk)
            vim.keymap.set("n", "[h", require("gitsigns").prev_hunk)
            vim.keymap.set("n", "<leader>hs", require("gitsigns").stage_hunk)
            vim.keymap.set("n", "<leader>hr", require("gitsigns").reset_hunk)
            vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk)
        end,
    },


    -- colorsssssss
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000, -- load first
    }
})
