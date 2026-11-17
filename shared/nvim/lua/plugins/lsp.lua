return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- csharp-ls is installed via Mason but conflicts with roslyn.nvim
      csharp_ls = { enabled = false },
    },
  },
}
