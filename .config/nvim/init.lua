-- Set leader key
vim.g.mapleader = " "

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
  -- Theme: Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },

  -- mini.icons
  { 'echasnovski/mini.nvim', version = false },
 
  -- File icons
  "nvim-tree/nvim-web-devicons",

  -- File explorer
  "nvim-tree/nvim-tree.lua",

  -- Syntax highlighting
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- Statusline
  "nvim-lualine/lualine.nvim",

  -- Git integration
  "lewis6991/gitsigns.nvim",

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Keybinding helper
  "folke/which-key.nvim",
})

-- Theme setup
vim.g.catppuccin_flavour = "mocha"
vim.cmd.colorscheme("catppuccin")

-- Treesitter configuration
require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  indent = { enable = true },
})

-- Lualine setup
require("lualine").setup()

-- Gitsigns setup
require("gitsigns").setup()

-- Nvim-tree setup
require("nvim-tree").setup({
  git = {
    enable = true,
    ignore = false,
  },
  filters = {
    dotfiles = false,
  },
})

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", {
  noremap = true,
  silent = true,
  desc = "Explorer",
})

-- Telescope keymaps
vim.keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end, { desc = "Live Grep" })

vim.keymap.set("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end, { desc = "Buffers" })

vim.keymap.set("n", "<leader>fh", function()
  require("telescope.builtin").help_tags()
end, { desc = "Help Tags" })

-- Which-key setup
require("which-key").setup()

local wk = require("which-key")
wk.add({
  { "<leader>f", group = "Telescope" }, -- group
  {
    mode = { "n", "v" }, -- NORMAL and VISUAL mode
    { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
    { "<leader>w", "<cmd>w<cr>", desc = "Write" },
  }
})

