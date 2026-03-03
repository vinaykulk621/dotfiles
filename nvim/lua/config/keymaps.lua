vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", '"+y')
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")

-- filetype specific formatter
local function set_keymaps()
    local filetype = vim.bo.filetype
    if filetype == "go" then
        vim.keymap.set("n", "<leader>f", ":!gofmt -s -w %<CR>", { silent = true })
    end
end

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = set_keymaps,
})
vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ async = true})
end)

-- quickfix navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- replace word
vim.keymap.set("n", "<leader>s",
[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Go helper
vim.keymap.set("n", "<leader>ee",
"oif err != nil {<CR>}<Esc>Oreturn err")



-- Ctrl + / to toggle comment
vim.keymap.set("n", "<leader>/", "gcc", { remap = true })
vim.keymap.set("v", "<leader>/", "gc", { remap = true })
vim.keymap.set("i", "<leader>/", "gc", { remap = true })




