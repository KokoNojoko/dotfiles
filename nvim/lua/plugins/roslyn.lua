return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "c_sharp" })
    end,
    init = function()
      vim.treesitter.language.register("c_sharp", "cs")
    end,
  },
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      filewatching = false,
      broad_search = false,
      lock_target = true,
      silent = false,
    },
    init = function()
      vim.env.DOTNET_ROOT = os.getenv("DOTNET_ROOT") or "/usr/lib/dotnet"
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client or client.name ~= "roslyn" then return end
          local buf = args.buf
          vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = buf, desc = "Code Action" })
          vim.keymap.set("n", "<leader>cA", function()
            vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
          end, { buffer = buf, desc = "Source Action" })
          client:notify("workspace/didChangeConfiguration", {
            settings = {
              ["csharp|inlay_hints"] = {
                csharp_enable_inlay_hints_for_implicit_object_creation = false,
                csharp_enable_inlay_hints_for_implicit_variable_types = false,
              },
              ["csharp|code_lens"] = {
                dotnet_enable_references_code_lens = false,
              },
              ["csharp|background_analysis"] = {
                dotnet_analyzer_diagnostics_scope = "openFiles",
                dotnet_compiler_diagnostics_scope = "openFiles",
              },
              ["csharp|completion"] = {
                dotnet_show_completion_items_from_unimported_namespaces = false,
              },
              ["csharp|symbol_search"] = {
                dotnet_search_reference_assemblies = false,
              },
            },
          })
        end,
      })
    end,
    config = function(_, opts)
      require("roslyn").setup(opts)
    end,
  },
}
