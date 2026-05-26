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
          env = { DOTNET_ROOT = "/usr/lib/dotnet" },
        },
      },
    },
  },
}
