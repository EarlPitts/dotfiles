--Plugin Configs

--FZF
vim.g.fzf_layout = {
    up = '~90%',
    window = { 
        width = 0.8,
        height = 0.8,
        yoffset = 0.5,
        xoffset = 0.5,
        highlight = 'Todo',
        border = 'sharp' 
    }
}

--UltiSnips
vim.g.UltiSnipsExpandTrigger = '<tab>'
vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
--let g:UltiSnipsJumpBackwardTrigger="<c-z>"
vim.g.UltiSnipsSnippetDirectories = {'UltiSnips', 'my_snippets'}

--NvimTree
--vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})
require'nvim-tree'.setup {
    -- vim.g.nvim_tree_ignore = {'.git', '__pycache__', '.pytest_cache'}
    -- vim.g.nvim_tree_auto_close = 1                                              --Closes the tree when it's the last window
    -- vim.g.nvim_tree_add_trailing = 1                                            --Append slash to folder names
    -- vim.g.nvim_tree_symlink_arrow = ' -> '
    -- vim.g.nvim_tree_show_icons = {}                                             --Disable icons
}

--Ale
vim.g.ale_set_highlights = 0        --Disable highlights

--YouCompleteMe
vim.g.ycm_show_diagnostics_ui = 0 --Disable Diagnostics
vim.g.ycm_auto_trigger = 0
vim.g.ycm_key_invoke_completion = '<C-n>'
vim.g.ycm_autoclose_preview_window_after_insertion = 1
vim.g.ycm_key_list_select_completion = '[]'
vim.g.ycm_key_list_previous_completion = '[]'

--VimWiki
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

--Airline
vim.g.airline_powerline_fonts = 1

--Markdown Preview
vim.g.mkdp_command_for_global = 1       --Make it available for all formats

--Syntastic
vim.g.syntastic_always_populate_loc_list = 1
vim.g.syntastic_auto_loc_list = 2
vim.g.syntastic_check_on_open = 1
vim.g.syntastic_check_on_wq = 0

--Conjure
vim.g['conjure#filetype#scheme'] = 'conjure.client.guile.socket'
vim.g['conjure#client#guile#socket#pipename'] = "/tmp/.guile-socket"
