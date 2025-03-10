local ls = require("luasnip")
local utils = require("nvim-svelte-snippets.utils")
local M = {}

M.snippets_loaded = false

-- Function node to determine the load type based on filename
local function detect_load_type(_, _)
	local filename = vim.fn.expand("%:t")

	-- Map of file patterns to load types
	local file_types = {
		["+page.server.ts"] = "PageServerLoad",
		["+page.ts"] = "PageLoad",
		["+layout.server.ts"] = "LayoutServerLoad",
		["+layout.ts"] = "LayoutLoad",
	}

	-- Find the matching type
	for pattern, type_name in pairs(file_types) do
		if filename == pattern then
			return type_name
		end
	end

	-- Default type if we can't determine
	return "PageServerLoad"
end

-- Define TypeScript snippets in a clean table format
local function get_typescript_snippets()
	return {
		{
			trigger = "load",
			description = "SvelteKit load function (auto-detects type from filename)",
			format = [[
import type {{ {} }} from './$types';

export const load: {} = async ({}) => {{
    {}

    return {{
        {}
    }};
}};
            ]],
			nodes = {
				utils.f(detect_load_type, {}), -- Function node for import type
				utils.f(detect_load_type, {}), -- Function node for load type
				utils.i(1, "{ params, fetch }"),
				utils.i(2, "// Fetch your data"),
				utils.i(3, "prop: 'value'"),
			},
		},
		{
			trigger = "actions",
			description = "SvelteKit form actions",
			format = [[
import type {{ Actions }} from './$types';

export const actions: Actions = {{
    default: async ({{ request }}) => {{
        {}
        return {{
            {}
        }};
    }}
}};
            ]],
			nodes = {
				utils.i(1, "/* form data */"),
				utils.i(2, "/* return values */"),
			},
		},
		{
			trigger = "get",
			description = "SvelteKit GET endpoint handler",
			format = [[
import type {{ RequestHandler }} from './$types';

export const GET: RequestHandler = async ({}) => {{
    {}
    return new Response();
}};
            ]],
			nodes = {
				utils.i(1, "{ params, request, url }"),
				utils.i(2, "// Handle GET request"),
			},
		},
		{
			trigger = "post",
			description = "SvelteKit POST endpoint handler",
			format = [[
import type {{ RequestHandler }} from './$types';

export const POST: RequestHandler = async ({}) => {{
    {}
    return new Response();
}};
            ]],
			nodes = {
				utils.i(1, "{ params, request }"),
				utils.i(2, "// Handle POST request"),
			},
		},
		{
			trigger = "put",
			description = "SvelteKit PUT endpoint handler",
			format = [[
import type {{ RequestHandler }} from './$types';

export const PUT: RequestHandler = async ({}) => {{
    {}
    return new Response();
}};
            ]],
			nodes = {
				utils.i(1, "{ params, request }"),
				utils.i(2, "// Handle PUT request"),
			},
		},
		{
			trigger = "patch",
			description = "SvelteKit PATCH endpoint handler",
			format = [[
import type {{ RequestHandler }} from './$types';

export const PATCH: RequestHandler = async ({}) => {{
    {}
    return new Response();
}};
            ]],
			nodes = {
				utils.i(1, "{ params, request }"),
				utils.i(2, "// Handle PATCH request"),
			},
		},
		{
			trigger = "delete",
			description = "SvelteKit DELETE endpoint handler",
			format = [[
import type {{ RequestHandler }} from './$types';

export const DELETE: RequestHandler = async ({}) => {{
    {}
    return new Response();
}};
            ]],
			nodes = {
				utils.i(1, "{ params, request }"),
				utils.i(2, "// Handle DELETE request"),
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
				utils.i(1, "param.length > 0"),
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

		-- Create the snippet with proper formatting
		local snippet =
			utils.create_snippet(trigger, utils.fmt(snippet_def.format, snippet_def.nodes), snippet_def.description)

		table.insert(processed_snippets, snippet)
	end

	ls.add_snippets("typescript", processed_snippets)
	M.snippets_loaded = true
end

return M
