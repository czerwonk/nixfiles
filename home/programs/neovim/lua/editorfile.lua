require('editorconfig').properties.file_type = function(bufnr, val, _)
  vim.bo[bufnr].ft = val
end
