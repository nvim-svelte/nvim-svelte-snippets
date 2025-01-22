-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key before lazy
vim.g.mapleader = " "

-- Setup plugins
require("lazy").setup({
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
  },
  {
    dir = vim.fn.getcwd(),
    dependencies = "L3MON4D3/LuaSnip",
  },
})

-- Add current directory to runtimepath
vim.opt.runtimepath:append(vim.fn.getcwd())
