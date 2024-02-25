local map = vim.keymap.set

map({ "n", "v" }, "<BS>", "<C-^>", { desc = "Alternate File" })
map({ "n", "v" }, "<Up>", "<Nop>", { desc = "" })
map({ "n", "v" }, "<Down>", "<Nop>", { desc = "" })
map({ "n", "v" }, "<Left>", "<Nop>", { desc = "" })
map({ "n", "v" }, "<Right>", "<Nop>", { desc = "" })

map({ "n", "v" }, "<leader>a", "<nop>", { desc = "Add" })
