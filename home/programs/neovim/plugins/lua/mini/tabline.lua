---@diagnostic disable: undefined-global
require('mini.tabline').setup {
  format = function(buf_id, label)
    return string.format('   %s   ', MiniTabline.default_format(buf_id, label))
  end,
}
