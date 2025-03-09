-- lua/nvim-svelte-snippets/typescript.lua
local ls = require("luasnip")
local utils = require("nvim-svelte-snippets.utils")
local M = {}

M.snippets_loaded = false

-- Define TypeScript snippets in a clean table format
local typescript_snippets = {
	{
		trigger = "load",
		description = "SvelteKit load function",
		format = [[
export const load: {} = async ({}) => {{
    {}

    return {{
        {}
    }};
}};
    ]],
		nodes = {
			ls.choice_node(1, {
				ls.text_node("PageLoad"),
				ls.text_node("PageServerLoad"),
				ls.text_node("LayoutLoad"),
				ls.text_node("LayoutServerLoad"),
			}),
			ls.insert_node(2, "{ params, fetch }"),
			ls.insert_node(3, "// Fetch your data"),
			ls.insert_node(4, "prop: 'value'"),
		},
	},
	{
		trigger = "actions",
		description = "SvelteKit form actions",
		format = [[
export const actions = {{
    default: async ({{ request }}) => {{
        {}
        return {{
            {}
        }};
    }}
}};
    ]],
		nodes = {
			ls.insert_node(1, "/* form data */"),
			ls.insert_node(2, "/* return values */"),
		},
	},
	{
		trigger = "endpoint",
		description = "SvelteKit endpoint handler",
		format = [[
export const {}: RequestHandler = async ({}) => {{
    {}
    return new Response();
}};
    ]],
		nodes = {
			ls.choice_node(1, {
				ls.text_node("GET"),
				ls.text_node("POST"),
				ls.text_node("PUT"),
				ls.text_node("PATCH"),
				ls.text_node("DELETE"),
			}),
			ls.insert_node(2, "{ params, request }"),
			ls.insert_node(3, "// Handle request"),
		},
	},
	{
		trigger = "param-matcher",
		description = "SvelteKit param matcher",
		format = [[
import type {{ ParamMatcher }} from '@sveltejs/kit';

export const match: ParamMatcher = (param) => {{
    return {};
}};
    ]],
		nodes = {
			ls.insert_node(1, "param.length > 0"),
		},
	},
}

function M.setup(config)
	if M.snippets_loaded then
		return
	end

	local prefix = config and config.prefix or ""
	local processed_snippets = {}

	for _, snippet_def in ipairs(typescript_snippets) do
		local trigger = prefix and prefix ~= "" and (prefix .. "-" .. snippet_def.trigger) or snippet_def.trigger

		table.insert(
			processed_snippets,
			ls.snippet(
				{ trig = trigger, desc = snippet_def.description },
				utils.fmt(snippet_def.format, snippet_def.nodes)
			)
		)
	end

	ls.add_snippets("typescript", processed_snippets)
	M.snippets_loaded = true
end

return M
