-- ~/.config/nvim/init.lua

-- DISABLE SUSPENDING NEOVIM
vim.keymap.set({ "n", "v", "i" }, "<C-z>", "<Nop>")

-- GLOBAL SETTINGS
vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

-- COMMANDS & QOL (Universal)
vim.keymap.set("n", "<leader>;", ":")
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>")
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>") 
vim.keymap.set("n", "<leader>/", "<cmd>nohlsearch<CR>", { silent = true })

-- SELECTION
vim.keymap.set("n", "L", "vg_")
vim.keymap.set("n", "<leader>sa", "ggVG")

-- NORMAL MODE
vim.keymap.set("n", "<leader>f", "<C-f>zz")
vim.keymap.set("n", "<leader>b", "<C-b>zz")
vim.keymap.set("n", "<leader>d", "<C-d>zz")
vim.keymap.set("n", "<leader>u", "<C-u>zz")
vim.keymap.set("n", "<leader>e", "<C-e>")
vim.keymap.set("n", "<leader>y", "<C-y>")
vim.keymap.set("n", "<leader>o", "<C-o>")
vim.keymap.set("n", "<leader>i", "<C-i>")

-- VISUAL MODE
vim.keymap.set({"n", "v"}, "<C-S-v>", "<C-v>")

-- INSERT MODE
vim.keymap.set("i", "<<", "<C-d>")
vim.keymap.set("i", ">>", "<C-t>")

if vim.g.vscode then
    -- ==========================================
    -- VS CODE SPECIFIC SETTINGS
    -- ==========================================
    
    local vscode = require("vscode")

    -- [!!!] FORCE INSERT MODE BY DEFAULT [!!!]
    vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
        pattern = "*",
        callback = function()
            vim.cmd("startinsert")
        end,
    })

else
    -- ==========================================
    -- STANDALONE NEOVIM MODE
    -- ==========================================

    -- CENTERING
    vim.keymap.set("n", "n", "nzzzv")
    vim.keymap.set("n", "N", "Nzzzv")

    vim.keymap.set("i", "jj", "<Esc>")

    -- NORMAL MODE
    vim.keymap.set("n", "<leader>j", "<cmd>m .+1<CR>==")
    vim.keymap.set("n", "<leader>k", "<cmd>m .-2<CR>==")

    -- VISUAL MODE
    vim.keymap.set("v", "<leader>j", ":m '>+1<CR>gv=gv")
    vim.keymap.set("v", "<leader>k", ":m '<-2<CR>gv=gv")
end