vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", '"+y')

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
local function set_keymaps()
    local filetype = vim.bo.filetype
    if filetype == "python" then
        -- python file formatter
        -- using black here
        vim.api.nvim_set_keymap('n', '<leader>f', ':!black %<CR>', { noremap = true, silent = true })
    elseif filetype == "go" then
        -- go file formatter
        -- using inbuilt gofmt 
        vim.api.nvim_set_keymap('n', '<leader>f', ':!gofmt -s -w %<CR>', { noremap = true, silent = true })
    end
end

-- Create an autocmd to call the function when entering a buffer
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = set_keymaps,
})

-- these are for navigating through errors in your file
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")


-- no idea what this is, but yeah let this be here
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")


-- replace the current word under the cursor everywhere
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- hot key to get if err in golang
vim.keymap.set(
"n",
"<leader>ee",
"oif err != nil {<CR>}<Esc>Oreturn err"
)

--aoc bro
vim.api.nvim_set_keymap('n', '<leader>gg', 'ipackage main<CR><CR><CR>import "os"<CR><CR>func readInput(path string) string {<CR>file,err:=os.ReadFile(path)<CR>if err!=nil{<CR>panic(err)<CR>}<CR>data:=string(file)<CR>return data<CR>}<CR><CR>func one(path string) {<CR>// data:=readInput(path)<CR>}<CR><CR>func two(path string) {<CR>// data:=readInput(path)<CR>}<CR><CR>func main() {<CR> one("../data")<CR>two("../data")<CR>}', { noremap = true, silent = true })


vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
