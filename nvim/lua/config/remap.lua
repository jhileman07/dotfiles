vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.opt.timeoutlen = 300
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("v", "jj", "<Esc>")

-- copy and paste remaps
vim.keymap.set("v", "<leader>yy", '"+yy')
vim.keymap.set("n", "<leader>yy", '"+yy')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>y", '"+y')

vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>p", '"+p')

-- move things with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- search for current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- move current line up one and join with the (now) line below = original previous line
vim.keymap.set("n", "<leader>K", ":m-2 | .-1join<CR>", { silent = true })

-- visual: move selection up one, then join top line with the previous
vim.keymap.set("v", "<leader>K", ":m '<-2<CR>gv=gv:.-1join<CR>", { silent = true })

-- big jumps
vim.keymap.set("n", "G", "Gzz")
vim.keymap.set("n", "gg", "ggzz")
vim.keymap.set("n", "<C-o>", "<C-o>zz") -- jump back
vim.keymap.set("n", "<C-i>", "<C-i>zz") -- jump forward

-- paragraph/section-ish moves
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")

-- search by word
vim.keymap.set("n", "*", "*zzzv")
vim.keymap.set("n", "#", "#zzzv")

-- folds: open what you're on and center
vim.keymap.set("n", "za", "zazz")
