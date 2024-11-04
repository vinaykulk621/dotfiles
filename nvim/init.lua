require("vinakulk")
local lspconfig = require("lspconfig")

-- path to python 3 executable
vim.g.python3_host_prog = '/afs/localcell/cm/gv2.6/sysname/pkg.@sys/qct/software/python/sles12/3.9.7/bin/python'


-- path to go executable
vim.g.go_bin_path = '/afs/localcell/cm.pvw/gv2.6/sysname/pkg.@sys/qct/software/golang/go1.19.3/bin/'


-- Copy to clipboard
vim.api.nvim_set_keymap({'n','v'}, '<leader>y', '"+y', { noremap = true, silent = true })

-- Paste from clipboard
vim.api.nvim_set_keymap({'n','v'}, '<leader>p', '"+p', { noremap = true, silent = true })

-- nvim-comment
vim.keymap.set({"n", "v"}, "<leader>/", ":CommentToggle<cr>")

-- lsp configuration 
require'lspconfig'.pyright.setup {
    cmd={'/usr2/vinakulk/.local/bin/pyright'},
    root_dir = function()
        return vim.fn.getcwd()
    end,
    single_file_support=true,
}

-- lsp configuration 
require'lspconfig'.pylsp.setup{
    cmd={'/usr2/vinakulk/.local/bin/pylsp'},
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = true,
                    ignore = {'W391'},
                    maxLineLength = 100
                },
                pylsp_black = {
                    enabled = true
                },
            }
        }
    }
}

-- lsp configuration 
lspconfig.gopls.setup{
    cmd={"/usr2/vinakulk/go/bin/gopls"},
    filetypes={"go","gomod","gowork","gotmpl"},
    settings={
        gopls={
            completeUnimported=true,
            usePlaceholders=true,
        },
        analyses={
            unusedimports=true,
        },
    },
}
