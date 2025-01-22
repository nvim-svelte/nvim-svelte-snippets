local ls = require("luasnip")
local utils = require("nvim-svelte-snippets.utils")
local M = {}

-- Keep track of whether snippets have been loaded
M.snippets_loaded = false

local snippets = {
	-- Server-side load function
	utils.s(
		{ trig = "sload", desc = "SvelteKit server load function" },
		utils.fmt(
			[[
export const load = satisfies PageServerLoad(async ({}) => {{
    {}
    return {{
        {}
    }};
}});
            ]],
			{
				utils.i(1, "params, fetch"),
				utils.i(2, "// fetch your data here"),
				utils.i(3, "prop: value"),
			}
		)
	),

	-- Client-side load function
	utils.s(
		{ trig = "cload", desc = "SvelteKit client load function" },
		utils.fmt(
			[[
export const load = satisfies PageLoad(async ({}) => {{
    {}
    return {{
        {}
    }};
}});
            ]],
			{
				utils.i(1, "params, fetch"),
				utils.i(2, "// fetch your data here"),
				utils.i(3, "prop: value"),
			}
		)
	),

	-- Form actions
	utils.s(
		{ trig = "actions", desc = "SvelteKit form actions" },
		utils.fmt(
			[[
export const actions = {{
    default: async ({{ request }}) => {{
        {}
        return {{
            {}
        }};
    }}
}};
            ]],
			{
				utils.i(1, "const data = await request.formData();"),
				utils.i(2, "success: true"),
			}
		)
	),
}

function M.setup(config)
	-- Prevent multiple loads
	if M.snippets_loaded then
		return
	end

	local prefix = config and config.prefix or ""
	local processed_snippets = {}

	-- Process each snippet
	for _, snippet in ipairs(snippets) do
		if snippet then
			local new_trigger = prefix and prefix ~= "" and (prefix .. "-" .. snippet.trigger) or snippet.trigger
			local new_snippet = vim.deepcopy(snippet)
			new_snippet.trigger = new_trigger
			table.insert(processed_snippets, new_snippet)
		end
	end

	-- Add the processed snippets
	ls.add_snippets("typescript", processed_snippets)

	-- Mark as loaded
	M.snippets_loaded = true
end

return M
