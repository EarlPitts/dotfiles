local set = vim.opt

-- Experimental, filetype.lua TODO
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

-- Indentation
set.expandtab = true                        -- Use spaces instead of tabs
set.shiftround = true                       -- Round indent to multiple of shiftwidth
set.shiftwidth = 4                          -- Indent size
set.tabstop = 4                             -- How many columns a tab counts for
set.softtabstop = 4                         -- Number of columns when you hit tab

-- Text Rendering
set.linebreak = true                        -- Wrap long lines between words
vim.cmd 'syntax enable'                     -- Enable syntax

-- Search
set.ignorecase = true                       -- Case insensitive search
set.smartcase = true
set.showmatch = true                        -- Highlight matching parentheses

-- Performance
set.lazyredraw = true                       -- Redraw only when needed

-- UI
set.ruler = false
set.cursorline = true                       -- Highlight current line
set.cursorlineopt = 'line'                  -- Don't underline line number
set.number = true                           -- Show line numbers
set.relativenumber = true                   -- Relative number
set.title = true                            -- TODO
set.shortmess = set.shortmess + 'I'         -- Turn off intro message
set.laststatus = 3                          -- Global statusline
set.showcmd = true

-- Folding
set.foldmethod = 'indent'                   -- Fold based on indent level
set.foldnestmax = 5                         -- 5 nested fold max
set.foldlevelstart = 5                      -- Open most folds by default

-- Colors
vim.g.base16colorspace = 256
vim.cmd 'colorscheme base16-tomorrow-night-eighties'

-- Misc
set.clipboard = 'unnamed'                   -- System clipboard TODO
-- set.omnifunc = 'syntaxcomplete#Complete'    -- TODO what's this? :D