local ls = require("luasnip")
local utils = require("nvim-svelte-snippets.utils")
local M = {}

local snippets = {
	-- Server-side load function
	utils.create_snippet(
		"sk-load",
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
		),
		"SvelteKit server load function"
	),
	-- Form actions
	utils.create_snippet(
		"sk-actions",
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
		),
		"SvelteKit form actions"
	),
}

function M.setup()
	ls.add_snippets("typescript", snippets)
end

return M
