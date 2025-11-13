vim.g.mapleader = ","
vim.g.maplocalleader = "," -- Needed for conjure

local map = vim.keymap.set

map('n', ';', ':')
map('n', '<leader>,', '<cmd>w<CR>')
map('n', '<leader>.', '<cmd>Tagbar<CR>')
map('n', '<F2>', '<cmd>UndotreeToggle<CR>')
map('n', '<F3>', '<cmd>DiffviewOpen<CR>')
map('n', '<F12>', '<cmd>tabnew wiki/index.md<CR>:Tagbar<CR>')
map('n', '<leader>j', '<cmd>%!jq<CR>') -- Format JSON
map('n', '<leader>f', '<cmd>NvimTreeFindFile<CR>')
map('', '<F1>', '<cmd>!./%<CR>')
map('n', '<leader>md', '<cmd>MarkdownPreview<CR>')
map('n', '<leader>sr', '<cmd>ConjureEval (RESTART 1)<CR>') -- Restart Scheme
map('n', '<Esc>', '<cmd>nohlsearch<CR>')               -- Clear highlight
map('n', '<leader>bo', '<cmd>%bd|e#<CR>') -- Delete buffers

-- Make
map('', '<F5>', '<cmd>make!<CR>')
-- map('', '<F5>', '<cmd>!~/.scripts/compile.sh %:p<CR>')
map('', '<F6>', '<cmd>make test<CR>')

-- Version Control
map('n', '<leader>g', '<cmd>Git<CR>')
map('n', '<space>gl', '<cmd>G pull --autostash<CR>')
map('n', '<space>gd', '<cmd>Gdiffsplit<CR>')
map('n', '<space>gb', '<cmd>Gitsigns blame<CR>')
map('n', '<space>ga', '<cmd>Gitsigns stage_hunk<CR>')
map('n', '<space>gu', '<cmd>Gitsigns undo_stage_hunk<CR>')
map('n', '<space>gr', '<cmd>Gitsigns reset_hunk<CR>')
map('n', '<space>gt', ':DiffviewFileHistory --reverse --grep=')

-- Copilot
map('n', '<leader>cc', '<cmd>CodeCompanionChat Toggle<CR>')
map('v', '<leader>cc', '<cmd>CodeCompanionChat Add<CR>')

-- Telescope
map('n', '<C-b>', '<cmd>Telescope buffers<CR>')
map('n', '<C-g>', '<cmd>Telescope live_grep<CR>')
map('n', '<C-t>', '<cmd>Telescope tags<CR>')
map('n', '<leader><C-p>', '<cmd>Telescope find_files<CR>')
map('n', '<C-s>', '<cmd>lua require"telescope.builtin".find_files({cwd = "~/References/Snippets"})<CR>')

-- Neotest
-- map('n', "tO", '<cmd>lua require("neotest").summary.toggle()<cr>')
-- map('n', "tP", '<cmd>lua require("neotest").output_panel.toggle()<cr>')
-- map('n', "tR", '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>')
-- map('n', "td", '<cmd>lua require("neotest").run.run({strategy = "dap"})<cr>')
-- map('n', "to", '<cmd>lua require("neotest").output.open()<cr>')
-- map('n', "tr", '<cmd>lua require("neotest").run.run()<cr>')
-- map('n', "ts", '<cmd>lua require("neotest").run.stop()<cr>')

-- git awareness for file picker
if vim.fn.isdirectory(".git") == 1 then
  map('n', '<C-p>', '<cmd>Telescope git_files<CR>')
else
  map('n', '<C-p>', '<cmd>Telescope find_files<CR>')
end

-- map('n', '<Space>', 'za')                                -- Folding

-- Copy to/from clipboard
-- map('n', '<C-c>', '"+yy')
-- map('v', '<C-c>', '"+y')
map('n', '<C-c>', ':w !xclip -selection clipboard<CR><CR>')
map('v', '<C-c>', ':w !xclip -selection clipboard<CR><CR>')
map('i', '<C-v>', '<ESC>:.!xclip -selection clipboard -o<CR>') -- This is horrible, find some better way

-- Window switching
map('n', '<C-w>-', '5<C-w>-')
map('n', '<C-w>+', '5<C-w>+')
map('n', '<C-w>,', '10<C-w><')
map('n', '<C-w>.', '10<C-w>>')
