return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- Keymaps for LSP
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Show documentation"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
      end,
    })

    -- Enable autocompletion
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Configure clangd specifically for MSYS2

    lspconfig["clangd"].setup({
      capabilities = capabilities,
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--suggest-missing-includes",
      },
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
      },
      filetypes = { "c", "cpp", "objc", "objcpp" },
      flags = {
        debounce_text_changes = 150,
      },
      on_attach = function(client, bufnr)
        -- Pass include paths through the client's environment or as project-specific configuration
        client.config.settings = client.config.settings or {}
        vim.list_extend(client.config.settings, {
          clangd = {
            extraArgs = {
              "-isystem", "D:/Programs/MSYS2/mingw64/include/c++/14.1.0",
              "-isystem", "D:/Programs/MSYS2/mingw32/include/c++/14.1.0/i686-w64-mingw32",
              "-isystem", "D:/Programs/MSYS2/mingw64/include",
            },
          },
        })
      end,
    })
  end,
}
