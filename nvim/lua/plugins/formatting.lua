return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
        ["_"] = { "trim_whitespace" },
      },
      formatters = {
        csharpier = {
          command = "dotnet-csharpier",
          args = { "--write-stdout" },
          stdin = true,
          timeout_ms = 45000,
          env = { DOTNET_ROOT = os.getenv("DOTNET_ROOT") or "/usr/lib/dotnet" },
        },
      },
    },
  },
}
