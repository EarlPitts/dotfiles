local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
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
    {'junegunn/goyo.vim', ft = 'markdown'},
    {'junegunn/limelight.vim', ft = 'markdown'},

    -- Analysis
    {'dense-analysis/ale', ft = {'bash', 'sh', 'zsh', 'c', 'tex', 'lua'}},
    -- {'Valloric/YouCompleteMe', 
    --     run = './install.py --clang-completer',
    --     ft = {'python', 'c'}
    -- }
    'neovim/nvim-lspconfig',
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    'nvim-treesitter/playground',

    -- Notes
    {'vimwiki/vimwiki', ft = 'markdown'},
    {'iamcco/markdown-preview.nvim', 
        build = function() vim.fn["mkdp#util#install"]() end,
        ft = {'markdown'}
    },
    -- 'nvim-neorg/neorg'

    -- Snippets
    'SirVer/ultisnips',
    'honza/vim-snippets',

    -- Git TODO load these only if in git repo
    'tpope/vim-fugitive',
    'airblade/vim-gitgutter',
    'tpope/vim-rhubarb',
    'sindrets/diffview.nvim',

    -- Looks
    'chriskempson/base16-vim',
    'hoob3rt/lualine.nvim',
    -- 'ryanoasis/vim-devicons'
    -- {'vim-airline/vim-airline', dependencies = 'vim-airline/vim-airline-themes'}
    -- 'RRethy/nvim-base16'

    -- Misc
    {'aserowy/tmux.nvim', config = true},
    'metakirby5/codi.vim', -- TODO ft python, codi zsh func
    {'Olical/conjure', ft = {'scheme', 'racket'}},
    {'wlangstroth/vim-racket', ft = 'scheme'},
    'tweekmonster/startuptime.vim',
    'nvim-lua/plenary.nvim'
})
