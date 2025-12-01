local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Navigation
  'kyazdani42/nvim-tree.lua',
  'majutsushi/tagbar',
  'nvim-telescope/telescope.nvim',

  -- Editing
  'numToStr/Comment.nvim',
  'mbbill/undotree',
  'tpope/vim-surround',
  -- 'editorconfig/editorconfig-vim,'

  -- Writing
  { 'junegunn/goyo.vim',      ft = 'markdown' },
  { 'junegunn/limelight.vim', ft = 'markdown' },

  -- Analysis
  -- {'dense-analysis/ale', ft = {'bash', 'sh', 'zsh', 'c', 'tex', 'lua', 'markdown'}},
  -- {'Valloric/YouCompleteMe',
  --     run = './install.py --clang-completer',
  --     ft = {'python', 'c'}
  -- }
  'neovim/nvim-lspconfig',
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'nvim-treesitter/playground',
  { 'scalameta/nvim-metals',           dependencies = { "nvim-lua/plenary.nvim" } },
  -- 'mfussenegger/nvim-dap',
  'saghen/blink.cmp',
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
  },

  -- Notes
  { 'vimwiki/vimwiki' },
  {
    'iamcco/markdown-preview.nvim',
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = { 'markdown' }
  },

  -- { "nvim-neorg/neorg",
  --     build = ":Neorg sync-parsers",
  --     dependencies = { "nvim-lua/plenary.nvim" },
  -- },

  -- Snippets
  'SirVer/ultisnips',
  'honza/vim-snippets',

  -- Git TODO load these only if in git repo
  'tpope/vim-fugitive',
  -- 'airblade/vim-gitgutter',
  'lewis6991/gitsigns.nvim',
  'tpope/vim-rhubarb',
  'sindrets/diffview.nvim',

  -- Looks
  'RRethy/base16-nvim',
  'hoob3rt/lualine.nvim',
  -- 'ryanoasis/vim-devicons'
  -- {'vim-airline/vim-airline', dependencies = 'vim-airline/vim-airline-themes'}
  -- 'RRethy/nvim-base16'

  -- Misc
  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-neotest/nvim-nio",
  --     "nvim-lua/plenary.nvim",
  --     "antoinemadec/FixCursorHold.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevanmilic/neotest-scala",
  --     "mrcjkb/neotest-haskell"
  --   }
  -- },
  { 'aserowy/tmux.nvim',      config = true },
  'metakirby5/codi.vim', -- TODO ft python, codi zsh func
  { 'Olical/conjure',         ft = { 'scheme', 'racket', 'python' } },
  { 'wlangstroth/vim-racket', ft = 'scheme' },
  'tweekmonster/startuptime.vim',
  'chrisbra/Recover.vim',
  {
    "olimorris/codecompanion.nvim",
    tag = "v17.33.0",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
})
