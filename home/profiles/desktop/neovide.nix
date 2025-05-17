{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    neovide
  ];

  programs.neovim = {
    extraLuaConfig = lib.mkAfter ''
      if vim.g.neovide then
        vim.opt.mouse = 'a'

        vim.g.neovide_scale_factor = 2.0
        vim.g.neovide_opacity = 0.9

        vim.g.neovide_position_animation_length = 0
        vim.g.neovide_cursor_animation_length = 0.00
        vim.g.neovide_cursor_trail_size = 0
        vim.g.neovide_cursor_animate_in_insert_mode = false
        vim.g.neovide_cursor_animate_command_line = false
        vim.g.neovide_scroll_animation_far_lines = 0
        vim.g.neovide_scroll_animation_length = 0.00

        vim.api.nvim_set_keymap("v", "<sc-c>", '"+y', { noremap = true })
        vim.api.nvim_set_keymap("i", "<sc-v>", '<ESC>"+p', { noremap = true })
        vim.api.nvim_set_keymap("n", "<sc-v>", '"+p', { noremap = true })
      end
    '';
  };
}
