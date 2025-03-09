local ls = require("luasnip")
local utils = require("nvim-svelte-snippets.utils")
local M = {}

-- Define all Svelte blocks in a clear table format for easy editing
local svelte_blocks = {
	{
		trigger = "if",
		description = "Svelte if block",
		format = [[
{{#if {}}}
    {}
{{/if}}
    ]],
		nodes = {
			utils.i(1, "condition"),
			utils.i(2, "content"),
		},
	},
	{
		trigger = "each",
		description = "Svelte each block",
		format = [[
{{#each {} as {}}}
    {}
{{/each}}
    ]],
		nodes = {
			utils.i(1, "items"),
			utils.i(2, "item"),
			utils.i(3, "{item}"),
		},
	},
	{
		trigger = "await",
		description = "Svelte await block",
		format = [[
{{#await {}}}
    {}
{{:then {}}}
    {}
{{:catch {}}}
    {}
{{/await}}
    ]],
		nodes = {
			utils.i(1, "promise"),
			utils.i(2, "pending"),
			utils.i(3, "value"),
			utils.i(4, "fulfilled"),
			utils.i(5, "error"),
			utils.i(6, "rejected"),
		},
	},
	{
		trigger = "await-then",
		description = "Svelte await block (then shorthand)",
		format = [[
{{#await {} then {}}}
    {}
{{/await}}
    ]],
		nodes = {
			utils.i(1, "promise"),
			utils.i(2, "value"),
			utils.i(3, "fulfilled"),
		},
	},
	{
		trigger = "key",
		description = "Svelte key block",
		format = [[
{{#key {}}}
    {}
{{/key}}
    ]],
		nodes = {
			utils.i(1, "key"),
			utils.i(2, "content"),
		},
	},
	{
		trigger = "snippet",
		description = "Svelte snippet block (Svelte 5)",
		format = [[
{{#snippet {}({})}}
    {}
{{/snippet}}
    ]],
		nodes = {
			utils.i(1, "name"),
			utils.i(2, "parameter"),
			utils.i(3, "content"),
		},
	},
	{
		trigger = "page",
		description = "SvelteKit page component",
		format = [[
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
		nodes = {
			utils.i(1, "// your script here"),
			utils.i(2, "Page Title"),
			utils.i(3, "<!-- your content here -->"),
			utils.i(4, "/* your styles here */"),
		},
	},
}

-- Convert the table of block definitions into LuaSnip snippets
function M.setup()
	local snippets = {}

	for _, block in ipairs(svelte_blocks) do
		local formatted_nodes = utils.fmt(block.format, block.nodes)
		local snippet = utils.create_snippet(block.trigger, formatted_nodes, block.description)
		table.insert(snippets, snippet)
	end

	ls.add_snippets("svelte", snippets)
end

return M
