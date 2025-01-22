local ls = require("luasnip")
local utils = require("nvim-svelte-snippets.utils")
local M = {}

local snippets = {
	-- Client-side load function
	utils.create_snippet(
		"sk-load",
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
		),
		"SvelteKit client load function"
	),
}

function M.setup(config)
	-- Use the utility function from utils
	local processed_snippets = utils.update_snippet_triggers(snippets, config and config.prefix)
	ls.add_snippets("typescript", processed_snippets)
end

return M
