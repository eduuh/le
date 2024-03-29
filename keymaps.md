# Keymaps

## Custom mapping: Two fingers, Same finger: Same finger sequence

### Nvim-Tree

1. [n, v] <leader>e (explorer)

### Harpoon2

1. [n, v] <leader>am (add mark)
2. [n, v] <leader>mm (my marks)
3. [n, v] <leader>pm (previous mark)
4. [n, v] <leader>fm (forward mark)

### Rest

1. [n, v] <leader> rr (Run request)
2. [n, v] <leader> sp (show preview)
3. [n, v] <leader> lr (last request)

### Trouble

1. [n] <leader> xx (trouble trouble)
2. [n] <leader> xw (trouble workspace)
3. [n] <leader> xd (trouble document)
3. [n] <leader> xq (trouble document)
3. [n] <leader> gR (trouble References)

### DAP: (Debugging)

1. [n, v] <leader> ab (add breakpoint)
2. [n, v] <leader> rd (run debugger)
3. [n, v] <leader> si (step into)
4. [n, v] <leader> so (step over)
5. [n, v] <leader> or (open repl)
6. [n, v] <leader> cb (coditional breakpoint)

### TElescope File

[config](https://github.com/nvim-telescope/telescope-file-browser.nvim/blob/master/lua/telescope/_extensions/file_browser/config.lua)

#### Normal Mode
      ["c"] = fb_actions.create,
      ["r"] = fb_actions.rename,
      ["m"] = fb_actions.move,
      ["y"] = fb_actions.copy,
      ["d"] = fb_actions.remove,
      ["o"] = fb_actions.open,
      ["g"] = fb_actions.goto_parent_dir,
      ["e"] = fb_actions.goto_home_dir,
      ["w"] = fb_actions.goto_cwd,
      ["t"] = fb_actions.change_cwd,
      ["f"] = fb_actions.toggle_browser,
      ["h"] = fb_actions.toggle_hidden,
      ["s"] = fb_actions.toggle_all,




