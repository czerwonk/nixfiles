vim.loader.enable()

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.colorcolumn = '120'

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

vim.opt.list = true
vim.opt.listchars:append({
  trail = '⋅',
  tab = '⇢ ',
})

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.opt.autoread = true
vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'CursorHoldI', 'FocusGained' }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { '*' },
})

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.local/state/nvim/undodir'
vim.opt.undofile = true

-- convenience key mappings
vim.keymap.set('n', 'Y', 'Y', { desc = 'Yank line' }) -- restore yank behavior of VIM
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' }) -- reposition after scrolling down
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up' }) -- reposition after scrolling up
vim.keymap.set('n', 'n', 'nzzzv') -- reposition after junp to match
vim.keymap.set('n', 'N', 'Nzzzv') -- reposition after junp to match
vim.keymap.set('n', 'Q', '@qj', { desc = 'Apply Macro' })
vim.keymap.set('x', 'Q', ':norm @q<CR>', { desc = 'Apply Macro' })
vim.keymap.set({'n', 'v'}, '<leader>y', [["+y]], { desc = 'Yank to Clipbaord' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Yank to Clipbaord' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move up'})
vim.keymap.set('n', '<c-b>', '<cmd>bnext<CR>', { desc = 'Switch to next buffer' })
vim.keymap.set('n', '<leader>H', function()
  vim.cmd('%!xxd')
  vim.bo[0].ft = 'xxd'
end, { desc = 'Hex view' })

vim.keymap.set("n", "<leader>co", ":diffget LOCAL<CR>", { desc = "Get OUR changes" })
vim.keymap.set("n", "<leader>ct", ":diffget REMOTE<CR>", { desc = "Get THEIR changes" })
vim.keymap.set("n", "<leader>cb", ":diffget BASE<CR>", { desc = "Get BASE changes" })

vim.diagnostic.config {
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
    },
  },
  severity_sort = true,
}

-- editorfile
require('editorconfig').properties.file_type = function(bufnr, val, _)
  vim.bo[bufnr].ft = val
end
