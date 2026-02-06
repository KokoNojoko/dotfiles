return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" }, -- Use csharpier for C# (install: dotnet tool install -g csharpier)
        -- Fallback to LSP if no formatter configured
        ["_"] = { "trim_whitespace" },
      },
      -- Format on save (optional - disable if you prefer manual)
      format_on_save = {
        timeout_ms = 3000,
        lsp_fallback = true,
      },
    },
  },
}
