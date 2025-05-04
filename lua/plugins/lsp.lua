return {
  -- LSP Manager
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "lua_ls",       -- Lua
        "pyright",      -- Python
        "tsserver",     -- JavaScript/TypeScript
        "clangd",       -- C/C++
        "rust_analyzer" -- Rust
      }
    }
  },

  -- LSP Auto-config
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = { automatic_installation = true }
  },

  -- LSP Core
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Enable LSP autocompletion
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Auto-setup all installed LSPs
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities
          })
        end
      })

      -- Keybindings
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
      vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "References" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
      vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_document_symbols, { desc = "Document Symbols" })
      vim.keymap.set("n", "<leader>f", function() vim.sp.buf.format { async = true } end, { desc = "Format buffer" })

      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Quickfix Diagnostics" })

      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "signature help" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show docs" })
    end
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip"
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item()
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }
        })
      })
    end
  }
}
