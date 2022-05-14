return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    --Navigation
    use 'junegunn/fzf.vim'
    use 'kyazdani42/nvim-tree.lua'
    use 'majutsushi/tagbar'

    --Editing
    use 'tpope/vim-commentary'
    use 'mbbill/undotree'
    use 'tpope/vim-surround'
    -- use 'editorconfig/editorconfig-vim'

    --Writing
    use 'junegunn/goyo.vim'
    use 'junegunn/limelight.vim'

    --Analysis
    use 'dense-analysis/ale'
    use {'Valloric/YouCompleteMe', run = './install.py --clang-completer'}
    use 'sheerun/vim-polyglot'
    -- use 'neovim/nvim-lspconfig'
    -- use 'nvim-treesitter/nvim-treesitter' --TODO TSUpdate is recommended after update

    --Notes
    use 'vimwiki/vimwiki'
    use { 'iamcco/markdown-preview.nvim', run = function() vim.fn["mkdp#util#install"]() end}

    --Snippets
    use 'SirVer/ultisnips'
    use 'honza/vim-snippets'

    --Git
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'
    use 'tpope/vim-rhubarb'
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

    --Looks
    use 'chriskempson/base16-vim'
    -- 'hoob3rt/lualine.nvim';
    --'ryanoasis/vim-devicons';
    use {'vim-airline/vim-airline', requires = 'vim-airline/vim-airline-themes'}

    --Misc
    use 'christoomey/vim-tmux-navigator'
    use 'metakirby5/codi.vim'
    use 'Olical/conjure'
    use 'tweekmonster/startuptime.vim'
end)
