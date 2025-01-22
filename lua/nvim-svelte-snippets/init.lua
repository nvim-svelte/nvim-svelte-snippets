local M = {}

function M.setup()
  require("nvim-svelte-snippets.client").setup()
  require("nvim-svelte-snippets.server").setup()
  require("nvim-svelte-snippets.svelte").setup()
end

return M
