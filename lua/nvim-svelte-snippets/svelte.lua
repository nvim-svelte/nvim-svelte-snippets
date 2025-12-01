local ls = require("luasnip")
local utils = require("nvim-svelte-snippets.utils")
local M = {}

-- Define all Svelte blocks in a clear table format for easy editing
-- Returns a function that generates fresh nodes each time
local function get_svelte_blocks()
	return {
		{
			trigger = "if",
			description = "Svelte if block",
			format = [[
{{#if {}}}
    {}
{{/if}}
    ]],
			nodes = function()
				return {
					utils.i(1, "condition"),
					utils.i(2, "content"),
				}
			end,
		},
		{
			trigger = "each",
			description = "Svelte each block",
			format = [[
{{#each {} as {}}}
    {}
{{/each}}
    ]],
			nodes = function()
				return {
					utils.i(1, "items"),
					utils.i(2, "item"),
					utils.i(3, "{item}"),
				}
			end,
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
			nodes = function()
				return {
					utils.i(1, "promise"),
					utils.i(2, "pending"),
					utils.i(3, "value"),
					utils.i(4, "fulfilled"),
					utils.i(5, "error"),
					utils.i(6, "rejected"),
				}
			end,
		},
		{
			trigger = "await-then",
			description = "Svelte await block (then shorthand)",
			format = [[
{{#await {} then {}}}
    {}
{{/await}}
    ]],
			nodes = function()
				return {
					utils.i(1, "promise"),
					utils.i(2, "value"),
					utils.i(3, "fulfilled"),
				}
			end,
		},
		{
			trigger = "key",
			description = "Svelte key block",
			format = [[
{{#key {}}}
    {}
{{/key}}
    ]],
			nodes = function()
				return {
					utils.i(1, "key"),
					utils.i(2, "content"),
				}
			end,
		},
		{
			trigger = "snippet",
			description = "Svelte snippet block (Svelte 5)",
			format = [[
{{#snippet {}({})}}
    {}
{{/snippet}}
    ]],
			nodes = function()
				return {
					utils.i(1, "name"),
					utils.i(2, "parameter"),
					utils.i(3, "content"),
				}
			end,
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
			nodes = function()
				return {
					utils.i(1, "// your script here"),
					utils.i(2, "Page Title"),
					utils.i(3, "<!-- your content here -->"),
					utils.i(4, "/* your styles here */"),
				}
			end,
		},
	}
end

-- Convert the table of block definitions into LuaSnip snippets
function M.setup()
	local snippets = {}

	for _, block in ipairs(get_svelte_blocks()) do
		local formatted_nodes = utils.fmt(block.format, block.nodes())
		local snippet = utils.create_snippet(block.trigger, formatted_nodes, block.description)
		table.insert(snippets, snippet)
	end

	ls.add_snippets("svelte", snippets)
end

return M
