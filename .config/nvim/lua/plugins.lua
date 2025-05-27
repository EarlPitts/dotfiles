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
  { 'aserowy/tmux.nvim', config = true },
  'metakirby5/codi.vim', -- TODO ft python, codi zsh func
  { 'Olical/conjure',         ft = { 'scheme', 'racket', 'python' } },
  { 'wlangstroth/vim-racket', ft = 'scheme' },
  'tweekmonster/startuptime.vim',
  'chrisbra/Recover.vim',
  {
    {
      "CopilotC-Nvim/CopilotChat.nvim",
      dependencies = {
        { "zbirenbaum/copilot.lua" },
        { "nvim-lua/plenary.nvim", branch = "master" },
      },
      build = "make tiktoken",
      opts = {
        model = "claude-3.5-sonnet",
        mappings = { reset = { normal = "", }, }
      },
    },
  }
})
