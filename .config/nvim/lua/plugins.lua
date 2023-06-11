return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Navigation
    use 'kyazdani42/nvim-tree.lua'
    use 'majutsushi/tagbar'
    use 'nvim-telescope/telescope.nvim'

    -- Editing
    use 'numToStr/Comment.nvim'
    use 'mbbill/undotree'
    use 'tpope/vim-surround'
    -- use 'editorconfig/editorconfig-vim'

    -- Writing
    use {'junegunn/goyo.vim', ft = 'markdown'}
    use {'junegunn/limelight.vim', ft = 'markdown'}

    -- Analysis
    use {'dense-analysis/ale', ft = {'bash', 'sh', 'zsh', 'c', 'tex', 'lua'}}
    -- use {'Valloric/YouCompleteMe', 
    --     run = './install.py --clang-completer',
    --     ft = {'python', 'c'}
    -- }
    use 'neovim/nvim-lspconfig'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/playground'

    -- Notes
    use {'vimwiki/vimwiki', ft = 'markdown'}
    use {'iamcco/markdown-preview.nvim', 
        run = function() vim.fn["mkdp#util#install"]() end,
        ft = {'markdown'}
    }
    -- use 'nvim-neorg/neorg'

    -- Snippets
    use 'SirVer/ultisnips'
    use 'honza/vim-snippets'

    -- Git TODO load these only if in git repo
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'
    use 'tpope/vim-rhubarb'
    use 'sindrets/diffview.nvim'

    -- Looks
    use 'chriskempson/base16-vim'
    use 'hoob3rt/lualine.nvim'
    -- use 'ryanoasis/vim-devicons'
    -- use {'vim-airline/vim-airline', requires = 'vim-airline/vim-airline-themes'}
    -- use 'RRethy/nvim-base16'

    -- Misc
    use 'christoomey/vim-tmux-navigator'
    use 'metakirby5/codi.vim' -- TODO ft python, codi zsh func
    use {'Olical/conjure', ft = {'scheme', 'racket'}}
    use {'wlangstroth/vim-racket', ft = 'scheme'}
    use 'tweekmonster/startuptime.vim'
    use 'nvim-lua/plenary.nvim'
    use 'lewis6991/impatient.nvim'
end)
