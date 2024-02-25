local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local map = vim.keymap.set

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },
  {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("lazygit")
      map("n", "<leader>gg", "<cmd>LazyGit<cr>")
    end,
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "/" },
      })
    end,
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    branch = "harpoon2",
    event = "VeryLazy",
    config = function()
      local harpoon = require("harpoon")
      harpoon.setup({})

      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
            .new({}, {
              prompt_title = "Harpoon",
              finder = require("telescope.finders").new_table({
                results = file_paths,
              }),
              previewer = conf.file_previewer({}),
              sorter = conf.generic_sorter({}),
            })
            :find()
      end

      vim.keymap.set({ "n", "v" }, "<leader>mm", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Open harpoon window" })

      vim.keymap.set({ "n", "v" }, "<leader>am", function()
        harpoon:list():append()
      end)

      vim.keymap.set({ "n", "v" }, "<leader>fm", function()
        harpoon:list():next()
      end)

      vim.keymap.set({ "n", "v" }, "<leader>pm", function()
        harpoon:list():next()
      end)
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      local lint_autogroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufwritePost", "InsertLeave" }, {
        group = lint_autogroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>fl", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("tools.api_dev")
    end,
  },
  {
    "xeluxee/competitest.nvim",
    ft = { "cpp", "c", "cs", "typescript", "javascript" },
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("competitest").setup({
        testcases_use_single_file = true,
        compile_command = {
          c = { exec = "gcc", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" .. ".out" } },
          cpp = {
            exec = "clang++",
            args = { "-std=c++2a", "$(FNAME)", "-o", "$(FNOEXT)" .. ".out", "--debug" },
          },
          rust = { exec = "rustc", args = { "$(FNAME)" } },
          -- Todo add c# + js + ts
        },
        compile_directory = ".",
        running_directory = ".",
        run_command = {
          c = { exec = "./$(FNOEXT)" .. ".out" },
          cpp = { exec = "./$(FNOEXT)" .. ".out" },
          rust = { exec = "./$(FNOEXT)" },
          javascript = { exec = "node", "$(FNAME)" .. ".js" },
          typescript = { exec = "bun", "$(FNAME)" .. ".ts" },
        },
        runner_ui = {
          interface = "popup",
        },
      })

      vim.keymap.set("n", "<leader>rc", "<cmd>CompetiTest run<cr>", { silent = true })
      vim.keymap.set("n", "<leader>at", "<cmd>CompetiTest add_testcase<cr>", { silent = true })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    dependencies = "windwp/nvim-ts-autotag",
    config = function()
      require("tools.program_installed")
      require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt", "vim" },
      })
      require("nvim-treesitter.configs").setup({
        autotag = {
          enable = true,
        },
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    event = "VeryLazy",
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", { silent = true })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("editor.git_signs")
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    config = function()
      require("editor/devicons")
    end,
  },
  { "folke/neoconf.nvim", cmd = "Neoconf",   event = "VeryLazy" },

  { "folke/neodev.nvim",  event = "VeryLazy" },
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "neovim/nvim-lspconfig",
      "onsails/lspkind.nvim",
    },
    config = function()
      require("tools/mason_config")
      require("tools/lsp_config")
      require("tools/lsp_kind")
    end,
  },

  {
    "p00f/clangd_extensions.nvim",
    event = "VeryLazy",
  },
  {
    "rose-pine/neovim",
    lazy = false,
    name = "rose-pine",
    config = function()
      require("editor/theme")
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "clangd_extensions.nvim", "mason.nvim" },
    config = function()
      require("formatting")
    end,
  },
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({})
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
    },
    config = function()
      require("editor/telescope_config")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
      require("editor/treesitter_conf")
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
  },

  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
      "sar/cmp-lsp.nvim",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("tools/completion")
    end,
  },

  -- install without yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    event = "VeryLazy",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- install with yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
    lazy = false,
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function()
      vim.keymap.set("n", "<leader>xx", function()
        require("trouble").toggle()
      end)
      vim.keymap.set("n", "<leader>xw", function()
        require("trouble").toggle("workspace_diagnostics")
      end)
      vim.keymap.set("n", "<leader>xd", function()
        require("trouble").toggle("document_diagnostics")
      end)
      vim.keymap.set("n", "<leader>xq", function()
        require("trouble").toggle("quickfix")
      end)
      vim.keymap.set("n", "gR", function()
        require("trouble").toggle("lsp_references")
      end)
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = function()
      require("todo-comments").setup()

      vim.keymap.set("n", "]t", function()
        require("todo-comments").jump_next()
      end, { desc = "Next todo comment" })

      vim.keymap.set("n", "[t", function()
        require("todo-comments").jump_prev()
      end, { desc = "Previous todo comment" })

      -- You can also specify a list of valid jump keywords

      vim.keymap.set("n", "]t", function()
        require("todo-comments").jump_next({ keywords = { "ERROR", "WARNING" } })
      end, { desc = "Next error/warning todo comment" })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      -- configure debug symbols
      vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    ft = { "c", "js", "c++", "cpp", "ts", "cs", "rs" },
    event = "VeryLazy",
    config = function()
      require("tools.dapconfigs")

      vim.keymap.set({ "n", "v" }, "<leader>ab", function()
        require("dap").toggle_breakpoint()
      end)
      vim.keymap.set({ "n", "v" }, "<leader>rd", function()
        require("dap").continue()
      end)
      vim.keymap.set({ "n", "v" }, "<leader>si", function()
        require("dap").step_into()
      end)
      vim.keymap.set({ "n", "v" }, "<leader>so", function()
        require("dap").step_over()
      end)
      vim.keymap.set({ "n", "v" }, "<leader>or", function()
        require("dap").repl.open()
      end)
      vim.keymap.set({ "n", "v" }, "<leader>cb", function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end)
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup({
        commented = true,
      })
    end,
  },
})
