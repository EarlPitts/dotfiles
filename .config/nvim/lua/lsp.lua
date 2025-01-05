--LSP Config
local lspconfig = require('lspconfig')

local map = vim.keymap.set

lspconfig.pyright.setup {
    root_dir = function(fname)
        return lspconfig.util.path.dirname(fname)
    end
}

lspconfig.lua_ls.setup {}

lspconfig.hls.setup {
    root_dir = function(fname)
        return lspconfig.util.path.dirname(fname)
    end
}

lspconfig.erlangls.setup {}

lspconfig.nixd.setup {}

lspconfig.volar.setup {}
local plugin_loc = function()
    if os.execute("command -v npm") == 0 then
        local handle = io.popen("npm root -g")
        local dir = handle:read("*a")
        handle:close()
        return dir .. "@vue/typescript-plugin"
    else
        return ""
    end
end
lspconfig.ts_ls.setup {
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = plugin_loc(),
                languages = { "javascript", "typescript", "vue" },
            },
        },
    },
    filetypes = {
        "javascript",
        "typescript",
        "vue",
    },
}

lspconfig.purescriptls.setup {
    settings = {
        purescript = {
            formatter = "purs-tidy",
        }
    }
}

lspconfig.bashls.setup {
    root_dir = function(fname)
        return lspconfig.util.path.dirname(fname)
    end
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})


local metals_config = require("metals").bare_config()
metals_config.init_options.statusBarProvider = "on"
metals_config.settings = {
    showImplicitArguments = true,
    showImplicitConversionsAndClasses = true,
    showInferredType = true,
    defaultBspToBuildTool = true
}

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "java", "sc" },
    callback = function()
        require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
})

metals_config.on_attach = function(client, bufnr)
    map("v", "K", require("metals").type_of_range)
    map("n", "<leader>er", require("metals").hover_worksheet)
    map('n', '<space>t', require("telescope").extensions.metals.commands)
    map("n", "<space><C-g>", require("telescope.builtin").lsp_dynamic_workspace_symbols)
    map('n', '<space>n', require("metals.tvp").toggle_tree_view)
    map('n', '<space>gn', require("metals.tvp").reveal_in_tree)
    -- require("metals").setup_dap()
end
