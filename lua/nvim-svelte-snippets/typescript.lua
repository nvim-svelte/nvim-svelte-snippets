local ls = require("luasnip")
local utils = require("nvim-svelte-snippets.utils")
local M = {}

M.snippets_loaded = false

-- Function to determine load type based on file name
local function get_load_data()
	local filename = vim.fn.expand("%:t")

	-- Map of file patterns to load types
	local file_types = {
		["+page.server.ts"] = "PageServerLoad",
		["+page.ts"] = "PageLoad",
		["+layout.server.ts"] = "LayoutServerLoad",
		["+layout.ts"] = "LayoutLoad",
	}

	-- Find the matching type
	local load_type = nil
	for pattern, type_name in pairs(file_types) do
		if filename == pattern then
			load_type = type_name
			break
		end
	end

	-- If we can't determine the type, return choice nodes properly
	if not load_type then
		return {
			type_node = utils.c(1, {
				utils.t("PageServerLoad"),
				utils.t("PageLoad"),
				utils.t("LayoutServerLoad"),
				utils.t("LayoutLoad"),
			}),
			import_type = utils.c(2, {
				utils.t("PageServerLoad"),
				utils.t("PageLoad"),
				utils.t("LayoutServerLoad"),
				utils.t("LayoutLoad"),
			}),
		}
	end

	-- Return both the type node and import type
	return {
		type_node = utils.t(load_type),
		import_type = utils.t(load_type),
	}
end

-- Define TypeScript snippets in a clean table format
local function get_typescript_snippets()
	return {
		{
			trigger = "load",
			description = "SvelteKit load function",
			format = [[
import type {{ {} }} from './$types';

export const load: {} = async ({}) => {{
    {}

    return {{
        {}
    }};
}};
      ]],
			nodes = function()
				local load_data = get_load_data()
				return {
					load_data.import_type,
					load_data.type_node,
					utils.i(3, "{ params, fetch }"),
					utils.i(4, "// Fetch your data"),
					utils.i(5, "prop: 'value'"),
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
				utils.i(1, "/* form data */"),
				utils.i(2, "/* return values */"),
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
				utils.c(1, {
					utils.t("GET"),
					utils.t("POST"),
					utils.t("PUT"),
					utils.t("PATCH"),
					utils.t("DELETE"),
				}),
				utils.i(2, "{ params, request }"),
				utils.i(3, "// Handle request"),
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

		-- Create the snippet using different approaches depending on node type
		local snippet
		if type(snippet_def.nodes) == "function" then
			-- For dynamic nodes (like load function)
			local nodes = snippet_def.nodes()
			snippet = utils.create_snippet(trigger, utils.fmt(snippet_def.format, nodes), snippet_def.description)
		else
			-- For static nodes
			snippet =
				utils.create_snippet(trigger, utils.fmt(snippet_def.format, snippet_def.nodes), snippet_def.description)
		end

		table.insert(processed_snippets, snippet)
	end

	ls.add_snippets("typescript", processed_snippets)
	M.snippets_loaded = true
end

return M
