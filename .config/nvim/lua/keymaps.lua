vim.g.mapleader = ","
vim.g.maplocalleader = ","                                  -- Needed for conjure
vim.opt.pastetoggle = '<leader>p'

local map = vim.keymap.set

map('n', ';', ':')
map('n', '<leader>,', ':w<CR>')
map('n', '<leader>.', ':Tagbar<CR>')
map('n', '<F2>', ':UndotreeToggle<CR>')
map('n', '<F12>', ':tabnew wiki/index.md<CR>:Tagbar<CR>')
map('n', '<leader>j', ':%!python -m json.tool<CR>')         -- Format JSON
map('', '<F1>', ':!./%<CR>')
map('n', '<leader>md', ':MarkdownPreview<CR>')
map('n', '<leader>sr', ':ConjureEval (RESTART 1)<CR>')      -- Restart Scheme

-- Make
map('', '<F5>', ':make!<CR>')
-- map('', '<F5>', ':!~/.scripts/compile.sh %:p<CR>')
map('', '<F6>', ':make test<CR>')

-- Version Control
map('n', '<F10>', ':Gdiffsplit<CR>')
map('n', '<leader>g', ':Git<CR>')

-- Telescope
map('n', '<C-b>', ':Telescope buffers<CR>')
map('n', '<C-g>', ':Telescope live_grep<CR>')
map('n', '<C-t>', ':Telescope tags<CR>')
map('n', '<C-s>', ':lua require"telescope.builtin".find_files({cwd = "~/References/Snippets"})<CR>')
-- git awareness for file picker
if vim.fn.isdirectory(".git") == 1 then
    map('n', '<C-p>', ':Telescope git_files<CR>')
else
    map('n', '<C-p>', ':Telescope find_files<CR>')
end

map('i', '<C-n>', '<C-x><C-o>' )                            -- Remap omnicomplete
-- map('n', '<Space>', 'za')                                -- Folding

-- Copy to/from clipboard
map('n', '<C-c>', '"+yy')
map('v', '<C-c>', '"+y')
map('i', '<C-v>', '<ESC>:.!xclip -selection clipboard -o<CR>') -- This is horrible, find some better way

-- Window switching
map('t', '<C-h>', '<C-\\><C-n><C-w>h')
map('t', '<C-j>', '<C-\\><C-n><C-w>j')
map('t', '<C-k>', '<C-\\><C-n><C-w>k')
map('t', '<C-l>', '<C-\\><C-n><C-w>l')
map('i', '<C-h>', '<C-\\><C-n><C-w>h')
map('i', '<C-j>', '<C-\\><C-n><C-w>j')
map('i', '<C-k>', '<C-\\><C-n><C-w>k')
map('i', '<C-l>', '<C-\\><C-n><C-w>l')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-w>-', '5<C-w>-')
map('n', '<C-w>+', '5<C-w>+')
map('n', '<C-w>,', '10<C-w><')
map('n', '<C-w>.', '10<C-w>>')
