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
          { "n", "<leader>co", actions.conflict_choose("ours"),   desc = "Choose Ours" },
          { "n", "<leader>ct", actions.conflict_choose("theirs"), desc = "Choose Theirs" },
          { "n", "<leader>cb", actions.conflict_choose("base"),   desc = "Choose Base" },
          { "n", "<leader>cA", actions.conflict_choose("all"),    desc = "Choose All" },
          { "n", "<leader>cx", actions.conflict_choose("none"),   desc = "Delete Conflict" },
          { "n", "]x",         actions.next_conflict,             desc = "Next Conflict" },
          { "n", "[x",         actions.prev_conflict,             desc = "Prev Conflict" },
        },
      },
    }
  end,
}
