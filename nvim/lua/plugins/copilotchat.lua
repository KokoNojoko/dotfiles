-- Copilot configuration
-- Note: LazyVim extras already provide copilot.lua and copilot-chat
-- This file adds customizations on top of those

return {
  -- Override copilot.lua settings from LazyVim extra
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<Tab>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        yaml = true,
        markdown = true,
        help = false,
        gitcommit = true,
        gitrebase = false,
        ["."] = false,
      },
    },
  },

  -- Override CopilotChat settings from LazyVim extra
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      model = "gpt-4o", -- or "claude-3.5-sonnet" if available
      temperature = 0.1,

      prompts = {
        Commit = {
          prompt = "Write a commit message for the staged changes following conventional commits format.",
        },
        Explain = {
          prompt = "Explain how this code works.",
        },
        Review = {
          prompt = "Review this code for bugs and improvements.",
        },
        Fix = {
          prompt = "Fix the problem in this code.",
        },
        Optimize = {
          prompt = "Optimize this code for performance and readability.",
        },
        Docs = {
          prompt = "Add documentation comments to this code.",
        },
        Tests = {
          prompt = "Generate tests for this code.",
        },
      },

      window = {
        layout = "vertical",
        width = 0.4,
        border = "rounded",
      },

      mappings = {
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-r>",
          insert = "<C-r>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
      },
    },

    config = function(_, opts)
      local chat = require("CopilotChat")
      chat.setup(opts)

      -- Custom command for commit messages
      vim.api.nvim_create_user_command("CopilotChatCommit", function()
        local diff = vim.fn.system("git diff --staged")
        if vim.v.shell_error ~= 0 or diff == "" then
          vim.notify("No staged changes to commit", vim.log.levels.WARN)
          return
        end
        chat.ask("Write a commit message for these changes:\n\n" .. diff)
      end, {})
    end,
  },
}
