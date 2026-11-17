-- fzf-lua 4a602e1 replaced opts(ui_opts, items) with normalize_opts(opts), which
-- calls the factory with zero args — breaking LazyVim's two-arg ui_select callback.
-- Nil it out: setup() skips registration (falsy), LazyVim's init registers once
-- with nil, falling back to fzf-lua's built-in defaults. No crash, no duplicate warning.
return {
  "ibhagwan/fzf-lua",
  opts = function(_, opts)
    opts.ui_select = nil
  end,
}
