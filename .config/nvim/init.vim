let mapleader = ","
set nocompatible
syntax on

"Plugin Manager
call plug#begin(stdpath('data') . '/plugged')

"Navigation
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'majutsushi/tagbar'

"Editing
Plug 'tpope/vim-commentary'
Plug 'mbbill/undotree'

"Analysis
Plug 'dense-analysis/ale'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clangd-completer --ts-completer' }
Plug 'sheerun/vim-polyglot'

"Looks
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

"Notes
Plug 'vimwiki/vimwiki'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

"Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'

"Misc
Plug 'christoomey/vim-tmux-navigator'
Plug 'metakirby5/codi.vim'

call plug#end()    

"### Plugin Configs ###

"FZF
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

"UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]


"NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
let NERDTreeIgnore=['.git', '__pycache__', '.pytest_cache']

"Ale
let g:ale_set_highlights = 0 "Disable highlights

"YouCompleteMe
let g:ycm_show_diagnostics_ui = 0 "Disable Diagnostics
let ycm_trigger_key = '<C-n>'
let g:ycm_auto_trigger = 0
let g:ycm_key_invoke_completion = ycm_trigger_key
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

"VimWiki
let g:vimwiki_list = [{
	\ 'path': '~/Personal/Notes',
	\ 'template_path': '~/Personal/Notes/templates/',
	\ 'template_default': 'default',
	\ 'index': 'Home',
	\ 'syntax': 'markdown',
	\ 'ext': '.md',
	\ 'path_html': '~/notes/',
	\ 'custom_wiki2html': '~/.config/nvim/md2html.sh',
    \ 'links_space_char': '-',
	\ 'template_ext': '.tpl'}]
"    \ 'auto_export': 1}]

"let g:vimwiki_folding = 'list'

let g:tagbar_type_vimwiki = {
          \   'ctagstype':'vimwiki'
          \ , 'kinds':['h:header']
          \ , 'sro':'&&&'
          \ , 'kind2scope':{'h':'header'}
          \ , 'sort':0
          \ , 'ctagsbin':'~/.config/nvim/vwtags.py'
          \ , 'ctagsargs': 'markdown'
          \ }

"Airline
let g:airline_powerline_fonts = 1

"Markdown Preview
let g:mkdp_command_for_global = 1 " Make it available for all formats
nmap <leader>md :MarkdownPreview<CR>

"Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


"### Editor ###

"Indentation
set autoindent " Copy indent when starting new line
set expandtab " Use spaces instead of tabs
filetype plugin indent on " Filetype detection with indent and plugin stuff loaded
set shiftround " Round indent to multiple of shiftwidth
set shiftwidth=4 " Indent size
set smarttab
set tabstop=4
set softtabstop=4 " Number of spaces while editing

"Text Rendering
set display+=lastline
set encoding=UTF-8
set linebreak " Wrap long lines between words
set wrap " Wrap lines
syntax enable " Enable syntax 

"Search
set incsearch " Search as characters are entered
set hlsearch " Highlight matches
set ignorecase
set smartcase
set showmatch " Highlight matching parentheses

"Performance
set lazyredraw " Redraw only when needed

"UI
set noruler
set wildmenu " Visual autocomplete for command menu
set cursorline " Highlight current line
set nu " Show line numbers
set rnu " Relative number
set title
set showcmd	" Show commands in bot line
set shortmess+=I " Turn off intro message

"Folding
set foldmethod=indent " Fold based on indent level
set foldnestmax=5	" 5 nested fold max
set foldenable " Enable folding
set foldlevelstart=5 " Open most folds by default
"nnoremap  <space> za	

"Misc
set hidden " Enables hidden buffers, so you can have modified buffers in the background
set autoread " Reload externally modified files in vim
set backspace=indent,eol,start
set history=1000
set omnifunc=syntaxcomplete#Complete " TODO what's this? :D
set clipboard=unnamed " System clipboard TODO

"Mappings
if isdirectory(".git")
	" if in a git project, use :GFiles
	nmap <C-p> :GitFiles --cached --others --exclude-standard<cr>
else
	" otherwise, use :FZF
	nmap <C-p> :Files<CR>
endif
nnoremap ; :
nmap <C-b> :Buffers<CR>
nmap <leader>. :Tagbar<CR>
nmap <leader>, :w<CR>
nnoremap <C-g> :Rg<CR>
nnoremap <C-t> :Tags<CR>
nnoremap <C-s> :Snippets<CR>
map <F1> :!./%<CR>
map <F5> :make!<CR>
"map <F5> :!~/.scripts/compile.sh %:p<CR>
map <F6> :make test<CR>
" Format JSON
map <leader>j :%!python -m json.tool<CR>
map gd :YcmCompleter GoToDefinition<CR>
map gr :YcmCompleter GoToReferences<CR>
map K :YcmCompleter GetDoc<CR>
nnoremap <F2> :UndotreeToggle<cr>
nmap <F12> :tabnew wiki/index.md<CR>:Tagbar<CR>
nmap <F10> :Gdiffsplit<CR>

"Meetings
map <leader>mr :.!echo - - $(date +\%F)-review<CR>
map <leader>mp :.!echo - - $(date +\%F)-planning<CR>
map <leader>ms :.!echo - - $(date +\%F)-scrum<CR>
map <leader>mt :.!echo - - $(date +\%F)-retro<CR>

"Copy to clipboard
nmap <C-c> "*y
vmap <C-c> "*y

set pastetoggle=<leader>p

"Windows
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-W>- 5<C-w>-
nnoremap <C-W>+ 5<C-w>+
nnoremap <C-W>, 10<C-w><
nnoremap <C-W>. 10<C-w>>

"Colors
let base16colorspace=256
set t_Co=256
set background=dark
colorscheme base16-eighties

"Autocommands
autocmd BufNewFile ~/Personal/Notes/diary/*.md :silent 0r !~/.scripts/diary_template.sh '%'
autocmd BufNewFile,BufRead *.ih set syntax=cpp

"Custom functions
function Stdlib()
    :tabnew
    :lcd /usr/lib/python3.?   
endfunction