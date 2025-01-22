local ls = require("luasnip")
local utils = require("nvim-svelte-snippets.utils")
local M = {}

local snippets = {
  -- Client-side load function
  utils.create_snippet(
    "load",
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

function M.setup()
  ls.add_snippets("typescript", snippets)
end

return M
