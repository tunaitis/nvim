return {
  {
    "wojciech-kulik/xcodebuild.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("xcodebuild").setup({
        -- put some options here or leave it empty to use default settings
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        sourcekit = {
          keys = {
            { "<leader>xr", "<cmd>XcodebuildBuildRun<CR>", desc = "Xcode Run" },
            { "<leader>xd", "<cmd>XcodebuildDebug<CR>", desc = "Xcode Debug" },
            { "<leader>xD", "<cmd>XcodebuildDebugTerminate<CR>", desc = "Xcode Stop Debug" },
          },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        swift = { "swiftlint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" }, {
        group = lint_augroup,
        callback = function()
          require("lint").try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>ml", function()
        require("lint").try_lint()
      end, { desc = "Lint file" })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        swift = { "swiftformat" },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "wojciech-kulik/xcodebuild.nvim",
    },
    config = function()
      local xcodebuild = require("xcodebuild.integrations.dap")
      -- SAMPLE PATH, change it to your local codelldb path
      local codelldbPath = os.getenv("HOME") .. "/tools/codelldb/adapter/codelldb"

      xcodebuild.setup(codelldbPath)

      vim.api.nvim_create_user_command("XcodebuildDebug", function()
        require("dap").disconnect()
        -- require("dapui").close()
        require("xcodebuild.integrations.dap").build_and_debug()
      end, {})

      vim.api.nvim_create_user_command("XcodebuildDebugTerminate", function()
        require("dap").disconnect()
      end, {})

      --lvim.keys.normal_mode["xr"] = {":XcodebuildBuildRun <cr>", {desc = "Xcode Build & Debug" }}

      --vim.keymap.set("n", "xr", xcodebuild.build_and_debug, { desc = "Xcode Build & Debug" })
      --vim.keymap.set("n", "<leader>dd", xcodebuild.build_and_debug, { desc = "Build & Debug" })
      --vim.keymap.set("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug Without Building" })
      --vim.keymap.set("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug Tests" })
      --vim.keymap.set("n", "<leader>dT", xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
      --vim.keymap.set("n", "<leader>b", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      --vim.keymap.set("n", "<leader>B", xcodebuild.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })
      --vim.keymap.set("n", "<leader>dx", xcodebuild.terminate_session, { desc = "Terminate Debugger" })
    end,
  },
}
