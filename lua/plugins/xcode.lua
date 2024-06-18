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
        sourcekit = {},
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
}
