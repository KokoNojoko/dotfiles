return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView Open" },
    { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "DiffView Close" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffView File History" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "DiffView Branch History" },
  },
  opts = function()
    local actions = require("diffview.actions")
    return {
      view = {
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
        },
      },
      keymaps = {
        merge_tool = {
          { "n", "<leader>mo", actions.conflict_choose("ours"),   { desc = "Merge: choose ours" } },
          { "n", "<leader>mt", actions.conflict_choose("theirs"), { desc = "Merge: choose theirs" } },
          { "n", "<leader>mb", actions.conflict_choose("base"),   { desc = "Merge: choose base" } },
          { "n", "<leader>ma", actions.conflict_choose("all"),    { desc = "Merge: choose all" } },
          { "n", "<leader>mx", actions.conflict_choose("none"),   { desc = "Merge: delete conflict" } },
          { "n", "]x",         actions.next_conflict,             { desc = "Next conflict" } },
          { "n", "[x",         actions.prev_conflict,             { desc = "Prev conflict" } },
        },
      },
    }
  end,
}
