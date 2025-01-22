local ls = require("luasnip")
local utils = require("nvim-svelte-snippets.utils")
local M = {}

local snippets = {
	-- Page component
	utils.create_snippet(
		"page",
		utils.fmt(
			[[
<script lang="ts">
    {}
</script>
<svelte:head>
    <title>{}</title>
</svelte:head>
    {}
<style>
    {}
</style>
            ]],
			{
				utils.i(1, "// your script here"),
				utils.i(2, "Page Title"),
				utils.i(3, "<!-- your content here -->"),
				utils.i(4, "/* your styles here */"),
			}
		),
		"SvelteKit page component"
	),
	-- Each block
	utils.create_snippet(
		"each",
		utils.fmt(
			[[
{{#each {} as {}}}
    {}
{{/each}}
            ]],
			{
				utils.i(1, "items"),
				utils.i(2, "item"),
				utils.i(3, "{item}"),
			}
		),
		"Svelte each block"
	),
}

function M.setup()
	ls.add_snippets("svelte", snippets)
end

return M
