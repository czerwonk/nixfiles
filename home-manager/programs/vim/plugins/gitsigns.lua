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
