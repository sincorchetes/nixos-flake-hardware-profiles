vim.g.mapleader = " "
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.cursorlineopt = "both"

require("nvim-web-devicons").setup({})
require("nvim-tree").setup({
  view = { width = 30 },
  renderer = { group_empty = true },
})
vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" })

require("lualine").setup({
  options = { theme = "auto" },
})

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  end,
})

vim.lsp.config("*", {
  capabilities = capabilities,
})

vim.lsp.enable({
  "nixd",
  "lua_ls",
  "bashls",
  "pyright",
  "terraformls",
  "html",
  "cssls",
  "ts_ls",
})

vim.diagnostic.config({ virtual_text = true, signs = true, underline = true })
