-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.o.expandtab = true
vim.o.number = true
vim.o.relativenumber = true

-- The `:.lua<CR>` means
-- command (:)
-- select current line (.) which is like the '<,'> for selection
-- run lua interpreter on the selection
-- carriage return to execute
vim.keymap.set('n', '<space>rl', ':.lua<CR>', { desc = 'Run current line as Lua' })
