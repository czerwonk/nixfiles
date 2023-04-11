vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.scrolloff = 8

vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.mouse = ''

vim.opt.encoding = 'UTF-8'
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert', 'preview'}
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.opt.termguicolors = true

vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

vim.g.mapleader = ' '

vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- icons
require('nvim-web-devicons').get_icons()

-- convinience key mappings
vim.keymap.set('n', 'Y', 'Y', { desc = 'Yank line' }) -- restore yank behavior of VIM
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' }) -- reposition after scrolling down
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up' }) -- reposition after scrolling up
vim.keymap.set("n", "n", "nzzzv") -- reposition after junp to match
vim.keymap.set("n", "N", "Nzzzv") -- reposition after junp to match
vim.keymap.set("n", "<leader>b", "<cmd>bnext<CR>", { desc = 'Switch to next buffer' })
vim.keymap.set("n", "<leader>w", "<cmd>bdelete<CR>", { desc = 'Close current buffer' })
vim.keymap.set("n", "Q", "<nop>") -- disable Q
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = 'Yank to Clipbaord' })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = 'Yank to Clipbaord' })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move down' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move up'})

-- sessions
require('persistence').setup {
  options = { "buffers", "curdir", "tabpages", "winsize", "help" }
}
vim.keymap.set('n', '<leader>qs', function() require('persistence').load() end, { desc = "Restore Session" })
vim.keymap.set('n', '<leader>ql', function() require('persistence').load({ last = true }) end, { desc = "Restore Last Session" })
vim.keymap.set('n', '<leader>qd', function() require('persistence').stop() end,  { desc = "Don't Save Current Session"})

-- terminal
require("toggleterm").setup {
  open_mapping = '<C-t>',
  direction = 'horizontal',
  shade_terminals = true
}

-- undotree
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.keymap.set('n', '<leader>z', vim.cmd.UndotreeToggle, { desc = 'UndoTree' })

-- todo
require('todo-comments').setup()

-- trouble
local trouble = require("trouble")
trouble.setup()
local troubleTelescope = require("trouble.providers.telescope")
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<CR>",
  {silent = true, noremap = true, desc = 'Toggle'}
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>",
  {silent = true, noremap = true, desc = 'Toggle (Workspace)'}
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>",
  {silent = true, noremap = true, desc = 'Toggle (Document)'}
)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<CR>",
  {silent = true, noremap = true, desc = 'Toggle (Locations)'}
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>",
  {silent = true, noremap = true, desc = 'Toggle (Quickfix)'}
)
vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<CR>",
  {silent = true, noremap = true, desc = 'TODO'}
)
vim.keymap.set("n", "<leader>xn", function () trouble.next({skip_groups = true, jump = true}) end,
  {silent = true, noremap = true, desc = 'Next'}
)
vim.keymap.set("n", "<leader>xp", function () trouble.previous({skip_groups = true, jump = true}) end,
  {silent = true, noremap = true, desc = 'Previous'}
)
vim.keymap.set("n", "<leader>x0", function () trouble.first({skip_groups = true, jump = true}) end,
  {silent = true, noremap = true, desc = 'First'}
)
vim.keymap.set("n", "<leader>x$", function () trouble.last({skip_groups = true, jump = true}) end,
  {silent = true, noremap = true, desc = 'Last'}
)

-- telescope
local telescope = require('telescope')
telescope.setup {
  defaults = {
    mappings = {
      i = { ["<C-t>"] = troubleTelescope.open_with_trouble },
      n = { ["<C-t>"] = troubleTelescope.open_with_trouble },
    },
  },
}
require('telescope').load_extension('fzf')

local telescopeBuiltin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescopeBuiltin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', telescopeBuiltin.live_grep, { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>fb', telescopeBuiltin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fc', telescopeBuiltin.commands, { desc = 'Commands' })
vim.keymap.set('n', '<leader>fh', telescopeBuiltin.search_history, { desc = 'Search History' })
vim.keymap.set('n', '<leader>fq', telescopeBuiltin.quickfix, { desc = 'Quickfix' })
vim.keymap.set('n', '<leader>fj', telescopeBuiltin.jumplist, { desc = 'Jumplist' })
vim.keymap.set('n', '<leader>fk', telescopeBuiltin.keymaps, { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>fv', telescopeBuiltin.vim_options, { desc = 'Options' })
vim.keymap.set('n', '<leader>fs', telescopeBuiltin.git_commits, { desc = 'Git Commits' })
vim.keymap.set('n', '<leader>ft', "<cmd>TodoTelescope<CR>", { desc = 'TODOs' })

-- git
require('gitsigns').setup {
  on_attach = function(buffer)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
    end

    map("n", "<leader>sS", gs.stage_buffer, "Stage Buffer")
    map("n", "<leader>su", gs.undo_stage_hunk, "Undo Stage Hunk")
    map("n", "<leader>sR", gs.reset_buffer, "Reset Buffer")
    map("n", "<leader>sp", gs.preview_hunk, "Preview Hunk")
    map("n", "<leader>sb", function() gs.blame_line({ full = true }) end, "Blame Line")
    map("n", "<leader>sd", gs.diffthis, "Diff This")
    map("n", "<leader>sD", function() gs.diffthis("~") end, "Diff This ~")
  end,
}

require("git-worktree").setup()
telescope.load_extension("git_worktree")
vim.keymap.set('n', '<leader>sw', telescope.extensions.git_worktree.git_worktrees,
  { noremap = true, desc = 'Worktrees' }
)
vim.keymap.set('n', '<leader>sc', telescope.extensions.git_worktree.create_git_worktree,
  { noremap = true, desc = 'Create Worktree' }
)

-- harpoon
require("harpoon").setup {
  global_settings = {
    save_on_toggle = true,
  },
}
local harpoonMark = require("harpoon.mark")
local harpoonUI = require("harpoon.ui")
vim.keymap.set("n", "<leader>ma", harpoonMark.add_file, { desc = 'Add File' })
vim.keymap.set("n", "<leader>mm", harpoonUI.toggle_quick_menu, { desc = 'Toggle' })
vim.keymap.set("n", "<leader>mn", harpoonUI.nav_next, { desc = 'Next File' })
vim.keymap.set("n", "<leader>mp", harpoonUI.nav_prev, { desc = 'Previous File' })
vim.keymap.set("n", "<leader>m1", function() harpoonUI.nav_file(1) end, { desc = 'File 1' })
vim.keymap.set("n", "<leader>m2", function() harpoonUI.nav_file(2) end, { desc = 'File 2' })
vim.keymap.set("n", "<leader>m3", function() harpoonUI.nav_file(3) end, { desc = 'File 3' })
vim.keymap.set("n", "<leader>m4", function() harpoonUI.nav_file(4) end, { desc = 'File 4' })

-- indetation visibility / syntax highlight / refactoring
vim.opt.list = true
vim.opt.listchars:append({
  trail = '⋅',
  tab = '⇢ ',
})
require('indent_blankline').setup {
  char = '│',
  space_char_blankline = ' ',
  show_first_indent_level = true,
  show_trailing_blankline_indent = false,
  filetype_exclude = {
    'lspinfo',
    'checkhealth',
    'help',
    'man',
    'git',
    'markdown',
    'text',
    'terminal',
    'TelescopePrompt',
    'TelescopeResults',
  },
  buftype_exclude = {
    'terminal',
    'nofile',
    'quickfix',
    'prompt',
  },
}

require('Comment').setup()

local refactoring = require('refactoring')
refactoring.setup()
telescope.load_extension('refactoring')
vim.keymap.set('v', '<leader>rr', telescope.extensions.refactoring.refactors,
  { noremap = true, desc = 'Refactoring' }
)
vim.keymap.set('n', '<leader>rp', function() refactoring.debug.printf({below = false}) end,
	{ noremap = true, desc = 'Printf Debug' }
)
vim.keymap.set('n', '<leader>rv', function() refactoring.debug.print_var({ normal = true }) end,
  { noremap = true, desc = 'Print Variable' }
)
vim.keymap.set('v', '<leader>rv', refactoring.debug.print_var,
  { noremap = true, desc = 'Print Variable' }
)
vim.keymap.set('n', '<leader>rc', refactoring.debug.cleanup,
 { noremap = true, desc = 'Cleanup' }
)

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  rainbow = {
    enable = true,
    query = 'rainbow-parens',
    strategy = require('ts-rainbow.strategy.global'),
    max_file_lines = 5000,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
    },
  },
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = true,
    },
    highlight_current_scope = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "<leader>re",
      }
    }
  }
}

-- completion
require('nvim-autopairs').setup()
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

local cmp = require('cmp')
local cmp_icons = {
  Array = " ",
  Boolean = " ",
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = " ",
  Key = " ",
  Keyword = " ",
  Method = " ",
  Module = " ",
  Namespace = " ",
  Null = " ",
  Number = " ",
  Object = " ",
  Operator = " ",
  Package = " ",
  Property = " ",
  Reference = " ",
  Snippet = " ",
  String = " ",
  Struct = " ",
  Text = " ",
  TypeParameter = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help'},
    { name = 'nvim_lua', keyword_length = 2},
    { name = 'buffer', keyword_length = 2 },
    { name = 'vsnip', keyword_length = 2 },
    { name = 'path' },
  },
  formatting = {
    format = function(_, item)
      if cmp_icons[item.kind] then
        item.kind = cmp_icons[item.kind] .. item.kind
      end
      return item
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = {
      hl_group = "LspCodeLens",
    },
  },
}

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  if client.server_capabilities["documentSymbolProvider"] then
    require("nvim-navic").attach(client, bufnr)
  end

  local map = function (mode, key, binding, desc)
    vim.keymap.set(mode, key, binding, { desc = desc, noremap = true, silent = true, buffer = bufnr })
  end
  map('n', 'gi', vim.lsp.buf.implementation, 'Find Implementation (LSP)')
  map('n', 'gh', vim.lsp.buf.signature_help, 'Show Signature Help (LSP)')
  map('n', 'gr', vim.lsp.buf.references, 'Find References (LSP)')
  map('n', '<leader>gD', vim.lsp.buf.declaration, 'Find Declatation (LSP)')
  map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder (LSP)')
  map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove Workspace Folder (LSP)')
  map('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'List Workspace Folders (LSP)')
  map('n', '<leader>F', function() vim.lsp.buf.format { async = true } end, 'Format (LSP)')

  -- lspsaga
  require("lspsaga").setup()
  map('n', 'gf', '<cmd>Lspsaga lsp_finder<CR>', 'Find (LSP)')
  map('n', '<leader>re', '<cmd>Lspsaga rename ++project<CR>', 'Rename (LSP)')
  map({'n','v'}, '<leader>,', '<cmd>Lspsaga code_action<CR>', 'Code Action (LSP)')
  map('n', '<leader>gd', '<cmd>Lspsaga peek_definition<CR>', 'Peek Definition (LSP)')
  map('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', 'Find Definition (LSP)')
  map('n', '<leader>gt', '<cmd>Lspsaga peek_type_definition<CR>', 'Peek Type Definition (LSP)')
  map('n', 'gt', '<cmd>Lspsaga goto_type_definition<CR>', 'Find Type Definition (LSP)')
  map('n', '<leader>o', '<cmd>Lspsaga outline<CR>', 'Outline (LSP)')
  map('n', 'K', '<cmd>Lspsaga hover_doc<CR>', 'Hover Doc (LSP)')

  -- trouble
  map('n', "<leader>xR", "<cmd>TroubleToggle lsp_references<CR>", 'Toggle (LSP References)')

  -- telescope
  map('n', '<leader>fi', telescopeBuiltin.lsp_implementations, 'Implementations (LSP)')
  map('n', '<leader>fd', telescopeBuiltin.lsp_definitions, 'Definitions (LSP)')
  map('n', '<leader>fr', telescopeBuiltin.lsp_references, 'References (LSP)')
  map('n', '<leader>p', telescopeBuiltin.lsp_document_symbols, 'Symbols in document (LSP)')
  map('n', '<leader>P', telescopeBuiltin.lsp_workspace_symbols, 'Symbols in workspace (LSP)')
end

local lspconfig = require('lspconfig')
lspconfig.pyright.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
lspconfig.solargraph.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
lspconfig.rnix.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}
lspconfig.bashls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim'},
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

-- dap
local dap = require('dap')

local function on_attach_with_debug(client, bufnr)
  on_attach(client, bufnr)

  vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = 'Continue (Debug)' })
  vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = 'Step over (Debug)' })
  vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = 'Step into (Debug)' })
  vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = 'Step out (Debug)' })
  vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = 'Toggle Breakpoint (Debug)' })
  vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = 'Breakpoint with message (Debug)' })
  vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end, { desc = 'Open REPL (Debug)' })
  vim.keymap.set('n', '<leader>dl', function() dap.run_last() end, { desc = 'Run Last (Debug)' })
  vim.keymap.set({'n', 'v'}, '<leader>dh', function()
    require('dap.ui.widgets').hover()
  end, { desc = 'Widgets (hover)' })
  vim.keymap.set({'n', 'v'}, '<leader>dp', function()
    require('dap.ui.widgets').preview()
  end, { desc = 'Widgets (preview)' })
  vim.keymap.set('n', '<leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
  end, { desc = 'Frames' })
  vim.keymap.set('n', '<leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
  end, { desc = 'Scopes' })
  vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
  vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})
end

local dapui = require('dapui')
dapui.setup() dap.listeners.after.event_initialized["dapui_config"]=function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"]=function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"]=function()
  dapui.close()
end

-- go
require('go').setup({
  max_line_len = 180,
  lsp_cfg = {
    capabilities = capabilities,
    on_attach = on_attach_with_debug,
  },
  lsp_gofumpt = true,
  dap_debug = true,
  dap_debug_gui = true,
})
local go_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = go_sync_grp,
})

-- rust
local rt = require("rust-tools")
rt.setup {
  server = {
    capabilities = capabilities,
    on_attach = on_attach_with_debug,
  }
}

-- vsnip
vim.cmd([[
  imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
  smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

  " Expand or jump
  imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
  smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

  " Jump forward or backward
  imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
  smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
  imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
  smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
]])

-- theme
vim.opt.background = 'dark'
vim.cmd('colorscheme codedark')
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'codedark',
    global = true,
  },
  tabline = {
    lualine_a = {'buffers'},
  },
  extensions = { 'fugitive', 'nvim-tree', 'toggleterm' },
}

vim.opt.updatetime = 200
require("barbecue").setup {
  attach_navic = false,
  create_autocmd = false,
}
vim.api.nvim_create_autocmd({
  "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
  "BufWinEnter",
  "CursorHold",
  "InsertLeave",
  "BufWritePost",
  "TextChanged",
  "TextChangedI",
}, {
  group = vim.api.nvim_create_augroup("barbecue.updater", {}),
  callback = function()
    require("barbecue.ui").update()
  end,
})

-- whichkey
vim.o.timeout = true
vim.o.timeoutlen = 500
local wk = require('which-key')
wk.setup {
  window = {
    border = "single",
    position = "bottom",
  },
}
local wkOpts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}
wk.register({
  d = {
    name = "Debug",
  },
  f = {
    name = "Telescope",
  },
  g = {
    name = "LSP (goto)",
  },
  m = {
    name = "Harpoon",
  },
  q = {
    name = "Session",
  },
  r = {
    name = "Refactoring",
  },
  s = {
    name = "Git"
  },
  x = {
    name = "Trouble",
  }
}, wkOpts)

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require('nvim-tree').setup {
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = true,
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filesystem_watchers = {
    enable = true,
  },
  diagnostics = {
    enable = true,
  },
  actions = {
    change_dir = {
      restrict_above_cwd = true,
    }
  }
}
vim.keymap.set('n', '<C-n>', [[:NvimTreeToggle<CR>]], { desc = 'Toggle Tree' })
vim.keymap.set('n', '<leader>n', [[:NvimTreeFocus<CR>]], { desc = 'Focus Tree' })

local function open_nvim_tree(data)
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd('VimEnter', {
  callback = open_nvim_tree
})
