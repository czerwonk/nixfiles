local harpoon = require('harpoon')
harpoon:setup {
  settings = {
    save_on_toggle = true,
    sync_on_ui_close = true,
  },
}

local telescope_conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = telescope_conf.file_previewer({}),
        sorter = telescope_conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>ma", function() harpoon:list():append() end, { desc = 'Add File' })
vim.keymap.set("n", "<leader>mm", function() toggle_telescope(harpoon:list()) end, { desc = 'Toggle' })
vim.keymap.set("n", "<leader>mn", function() harpoon:list():next() end, { desc = 'Next File' })
vim.keymap.set("n", "<leader>mp", function() harpoon:list():prev() end, { desc = 'Previous File' })
vim.keymap.set("n", "<leader>m1", function() harpoon:list():select(1) end, { desc = 'File 1' })
vim.keymap.set("n", "<leader>m2", function() harpoon:list():select(2) end, { desc = 'File 2' })
vim.keymap.set("n", "<leader>m3", function() harpoon:list():select(3) end, { desc = 'File 3' })
vim.keymap.set("n", "<leader>m4", function() harpoon:list():select(4) end, { desc = 'File 4' })
