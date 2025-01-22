if vim.g.loaded_sveltekit_snippets then
	return
end
vim.g.loaded_sveltekit_snippets = true

require("nvim-svelte-snippets").setup()
