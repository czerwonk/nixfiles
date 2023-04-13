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
