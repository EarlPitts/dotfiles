vim.g.mapleader = ","
vim.g.maplocalleader = ","                  --Needed for conjure
vim.opt.pastetoggle = '<leader>p'

local map = vim.api.nvim_set_keymap
local noremap = {noremap = true}

map('n', ';', ':', noremap)
map('n', '<leader>,', ':w<CR>', noremap)
map('n', '<leader>.', ':Tagbar<CR>', noremap)
map('n', '<F2>', ':UndotreeToggle<CR>', noremap)
map('n', '<F12>', ':tabnew wiki/index.md<CR>:Tagbar<CR>', noremap)
map('n', '<leader>j', ':%!python -m json.tool<CR>', noremap) --Format JSON
map('', '<F1>', ':!./%<CR>', noremap)
map('n', '<leader>md', ':MarkdownPreview<CR>', noremap)
map('n', '<leader>sr', ':ConjureEval (RESTART 1)<CR>', noremap) -- Restart Scheme

--Make
map('', '<F5>', ':make!<CR>', noremap)
--map('', '<F5>', ':!~/.scripts/compile.sh %:p<CR>', noremap)
map('', '<F6>', ':make test<CR>', noremap)

--Version Control
map('n', '<F10>', ':Gdiffsplit<CR>', noremap)
map('n', '<leader>g', ':Git<CR>', noremap)

--FZF
map('n', '<C-b>', ':Buffers<CR>', noremap)
map('n', '<C-g>', ':Rg<CR>', noremap)
map('n', '<C-t>', ':Tags<CR>', noremap)
map('n', '<C-s>', ':Files ~/References/Snippets<CR>', noremap)
--map('n', '<C-s>', ':Snippets<CR>', noremap)

map('i', '<C-n>', '<C-x><C-o>', noremap )              --Remap omnicomplete
--map('n', '<Space>', 'za', noremap)                    --Folding

--Copy to clipboard
map('n', '<C-c>', '"*yy', noremap)
map('v', '<C-c>', '"*y', noremap)

--Window switching
map('t', '<C-h>', '<C-\\><C-n><C-w>h', noremap)
map('t', '<C-j>', '<C-\\><C-n><C-w>j', noremap)
map('t', '<C-k>', '<C-\\><C-n><C-w>k', noremap)
map('t', '<C-l>', '<C-\\><C-n><C-w>l', noremap)
map('i', '<C-h>', '<C-\\><C-n><C-w>h', noremap)
map('i', '<C-j>', '<C-\\><C-n><C-w>j', noremap)
map('i', '<C-k>', '<C-\\><C-n><C-w>k', noremap)
map('i', '<C-l>', '<C-\\><C-n><C-w>l', noremap)
map('n', '<C-h>', '<C-w>h', noremap)
map('n', '<C-j>', '<C-w>j', noremap)
map('n', '<C-k>', '<C-w>k', noremap)
map('n', '<C-l>', '<C-w>l', noremap)
map('n', '<C-w>-', '5<C-w>-', noremap)
map('n', '<C-w>+', '5<C-w>+', noremap)
map('n', '<C-w>,', '10<C-w><', noremap)
map('n', '<C-w>.', '10<C-w>>', noremap)

if vim.fn.isdirectory(".git") == 1 then
	-- if in a git project, use :GFiles
    map('n', '<C-p>', ':GitFiles<CR>', noremap)
else
	-- otherwise, use :FZF
    map('n', '<C-p>', ':Files<CR>', noremap)
end
