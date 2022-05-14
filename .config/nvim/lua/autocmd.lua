vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = {'*.ih'},
    command = 'set syntax=cpp'
})
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = {'*.sage'},
    command = 'set filetype=python'
})
--autocmd BufNewFile ~/Personal/Notes/diary/*.md :silent 0r !~/.scripts/diary_template.sh '%'
