-- Plugin Configs

local map = vim.api.nvim_set_keymap
local noremap = {noremap = true}

-- Lower startup time
vim.loader.enable()

-- Treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = {'c', 'bash', 'lua', 'python', 'scheme', 'comment', 'make', 'norg', 'haskell', 'erlang'},
    highlight = {
        enable = true,
    },
    indent = {
        -- enable = true
    },
}

vim.api.nvim_exec([[
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
]], true)

-- Markdown preview
vim.g.mkdp_theme = 'light'

-- Comment.nvim
require('Comment').setup()

-- Lualine
require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'seoul256',
    },
}

-- Telescope
require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = require('telescope.actions').close,
            },
        }
    },
    pickers = {
        git_files = {
            show_untracked = false,
            follow = true -- TODO seems to have no effect
        }
    }
}

-- UltiSnips
vim.g.UltiSnipsExpandTrigger = '<tab>'
vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
--let g:UltiSnipsJumpBackwardTrigger="<c-z>"
vim.g.UltiSnipsSnippetDirectories = {'UltiSnips', 'my_snippets'}

-- NvimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

map('n', '<C-n>', ':NvimTreeToggle<CR>', noremap)
vim.api.nvim_create_autocmd('BufEnter', {                                   -- Close nvim-tree is last buffer
    command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
    nested = true,
})
require'nvim-tree'.setup {
    filters = {custom = {'.git', '__pycache__', '.pytest_cache'}},
    renderer = {
        icons = {
            symlink_arrow = ' -> ',
            show = {
                file = false,
                folder = false,
                folder_arrow = false,
                git = false
            }
        },
        add_trailing = true                                                 -- Append slash to folder names
    }
}

-- Ale
vim.g.ale_set_highlights = 0        -- Disable highlights

-- YouCompleteMe
-- map('n', 'gd', ':YcmCompleter GoToDefinition<CR>', noremap)
-- map('n', 'gr', ':YcmCompleter GoToReferences<CR>', noremap)
-- map('n', 'K', ':YcmCompleter GetDoc<CR>', noremap)
-- vim.g.ycm_show_diagnostics_ui = 0 -- Disable Diagnostics
-- vim.g.ycm_auto_trigger = 0
-- vim.g.ycm_key_invoke_completion = '<C-n>'
-- vim.g.ycm_autoclose_preview_window_after_insertion = 1
-- vim.g.ycm_key_list_select_completion = '[]'
-- vim.g.ycm_key_list_previous_completion = '[]'

-- VimWiki
vim.g.vimwiki_list = {{
    path = '~/Personal/Wiki',
    template_path = '~/Personal/Notes/templates/',
    template_default = 'default',
    index = 'index',
    syntax = 'markdown',
    ext = '.md',
    path_html = '~/notes/',
    custom_wiki2html = '~/.config/nvim/md2html.sh',
    links_space_char = '-',
    template_ext = '.tpl'
    --    \ 'auto_export': 1}]
}}
vim.g.tagbar_type_vimwiki = {
    ctagstype ='vimwiki',
    kinds = {'h:header'},
    sro = '&&&',
    kind2scope = {h ='header'},
    sort = 0,
    ctagsbin = '~/.config/nvim/vwtags.py',
    ctagsargs = 'markdown',
}
--vim.g.vimwiki_folding = 'list'

-- Neorg
-- require("neorg").setup {
--     load = {
--     ["core.defaults"] = {}, -- Loads default behaviour
--     ["core.concealer"] = {}, -- Adds pretty icons to your documents
--     ["core.dirman"] = { -- Manages Neorg workspaces
--         config = {
--         workspaces = {
--             notes = "~/Projects/active/neorg/notes",
--         },
--         },
--     },
--     },
-- }

-- Markdown Preview
vim.g.mkdp_command_for_global = 1       -- Make it available for all formats

-- Syntastic
vim.g.syntastic_always_populate_loc_list = 1
vim.g.syntastic_auto_loc_list = 2
vim.g.syntastic_check_on_open = 1
vim.g.syntastic_check_on_wq = 0

-- Diffview
local cb = require'diffview.config'.diffview_callback
require'diffview'.setup {
    use_icons = false
}

-- Conjure
vim.g['conjure#filetype#scheme'] = 'conjure.client.guile.socket'
vim.g['conjure#client#guile#socket#pipename'] = "/tmp/.guile-socket"
vim.g['conjure#client#racket#stdio#command']  = "racket" -- -I pie"

-- Tagbar Haskell
vim.g.tagbar_type_haskell = {
    ctagsbin = 'hasktags',
    ctagsargs = '-x -c -o-',
    kinds = {
        'm:modules:0:1',
        'd:data: 0:1',
        'd_gadt: data gadt:0:1',
        't:type names:0:1',
        'nt:new types:0:1',
        'c:classes:0:1',
        'cons:constructors:1:1',
        'c_gadt:constructor gadt:1:1',
        'c_a:constructor accessors:1:1',
        'ft:function types:1:1',
        'fi:function implementations:0:1',
        'i:instance:0:1',
        'o:others:0:1'
    },
    sro = '.',
    kind2scope = {
        m = 'module',
        c = 'class',
        d = 'data',
        t = 'type',
        i = 'instance'
    },
    scope2kind = {
        module   = 'm',
        class    = 'c',
        data     = 'd',
        type     = 't',
        instance = 'i'
    }
}

-- Tagbar Scala Support
vim.g.tagbar_type_scala = {
    ctagstype = 'scala',
    kinds =     {
        'p:packages:1',
        'V:values',
        'v:variables',
        'T:types',
        't:traits',
        'o:objects',
        'a:aclasses',
        'c:classes',
        'r:cclasses',
        'm:methods'
    }
}
