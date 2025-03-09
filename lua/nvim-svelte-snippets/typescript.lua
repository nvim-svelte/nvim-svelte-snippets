local ls = require("luasnip")
local utils = require("nvim-svelte-snippets.utils")
local M = {}

M.snippets_loaded = false

-- Function to determine load type based on file name
local function get_load_type_node()
	local filename = vim.fn.expand("%:t")

	-- Create choice options based on file type
	if filename:match("^%+page%.server%.ts$") then
		return ls.text_node("PageServerLoad")
	elseif filename:match("^%+page%.ts$") then
		return ls.text_node("PageLoad")
	elseif filename:match("^%+layout%.server%.ts$") then
		return ls.text_node("LayoutServerLoad")
	elseif filename:match("^%+layout%.ts$") then
		return ls.text_node("LayoutLoad")
	else
		-- If we can't determine file type, give choices
		return ls.choice_node(1, {
			ls.text_node("PageLoad"),
			ls.text_node("PageServerLoad"),
			ls.text_node("LayoutLoad"),
			ls.text_node("LayoutServerLoad"),
		})
	end
end

-- Define TypeScript snippets in a clean table format
local function get_typescript_snippets()
	return {
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
			nodes = function()
				return {
					get_load_type_node(),
					ls.insert_node(2, "{ params, fetch }"),
					ls.insert_node(3, "// Fetch your data"),
					ls.insert_node(4, "prop: 'value'"),
				}
			end,
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
end

function M.setup(config)
	if M.snippets_loaded then
		return
	end

	local prefix = config and config.prefix or ""
	local processed_snippets = {}

	for _, snippet_def in ipairs(get_typescript_snippets()) do
		local trigger = prefix and prefix ~= "" and (prefix .. "-" .. snippet_def.trigger) or snippet_def.trigger

		-- Create the snippet using different approaches depending on node type
		local snippet
		if type(snippet_def.nodes) == "function" then
			-- For dynamic nodes (like load function)
			local nodes = snippet_def.nodes()
			snippet =
				ls.snippet({ trig = trigger, desc = snippet_def.description }, utils.fmt(snippet_def.format, nodes))
		else
			-- For static nodes
			snippet = ls.snippet(
				{ trig = trigger, desc = snippet_def.description },
				utils.fmt(snippet_def.format, snippet_def.nodes)
			)
		end

		table.insert(processed_snippets, snippet)
	end

	ls.add_snippets("typescript", processed_snippets)
	M.snippets_loaded = true
end

return M
