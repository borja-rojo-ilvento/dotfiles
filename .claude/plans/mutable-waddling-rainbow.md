# Fix treesitter `range` nil crash in Neovim 0.12.2

## Context

Two distinct but related error traces appear on buffer render:

**Trace 1 — decoration provider** (pure Neovim runtime, no snacks):  
`highlighter._on_start` → `languagetree:parse` → `languagetree:_parse` → `get_node_ranges` → `get_range(node, ...)` where `node` is nil → crash at `languagetree.lua:854`: `region[i] = { range:range(true) }`.  
This is the treesitter highlighter computing injection regions (e.g. code blocks inside markdown). A query capture comes back nil and the runtime doesn't guard against it.

**Trace 2 — vim.schedule callback** (snacks image):  
`snacks.image.inline:update` → `snacks.image.doc.find_visible` → `snacks.util.parse` → same injection crash path as Trace 1.  
snacks.image scans markdown buffers for image nodes using treesitter, triggering the same nil-node issue.

Both hit `vim/treesitter.lua:196`: `return { node:range(true) }` with nil `node`.

**Root cause**: An injection query capture produces a nil node. Neovim 0.12.2's `get_node_ranges()` does not guard before passing it to `get_range()`. Most likely culprit: `markdown` or `markdown_inline` parser/query is stale or has a mismatched ABI.

## Plan

### Step 1 — Disable snacks image (config change, eliminates Trace 2)

In `lua/plugins/snacks.lua`, change:
```lua
image = { enabled = true },
```
to:
```lua
image = { enabled = false },
```

This removes the scheduled snacks image scan, which is the only thing triggering Trace 2. The image inline feature is non-essential.

### Step 2 — Recompile parsers (user action in Neovim)

Run `:TSUpdate` inside Neovim. This recompiles all parser `.so` files against the current treesitter ABI and pulls updated query files (including injection queries). This is the primary fix for Trace 1.

### Step 3 — Fallback if Trace 1 persists

If `:TSUpdate` does not fix Trace 1, the injection issue is specific to a query pattern. Since the user already added `markdown` to `additional_vim_regex_highlighting` and `indent.disable`, the next step would be to also add it to `highlight.disable` in `lua/plugins/nvim_treesitter.lua`:
```lua
highlight = {
  enable = true,
  disable = { 'markdown' },
  additional_vim_regex_highlighting = { 'ruby', 'markdown' },
},
```
This stops treesitter from running injection parsing on markdown entirely, falling back to Vim regex highlighting (which is already enabled for markdown anyway).

## Verification

- Open a markdown file with a fenced code block
- Check that no errors appear in `:messages`
- Confirm syntax highlighting still works (via regex fallback if Step 3 was needed)
- Run `:checkhealth nvim-treesitter` to confirm parser ABI health
