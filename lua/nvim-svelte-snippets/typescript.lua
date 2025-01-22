local ls = require("luasnip")
local utils = require("nvim-svelte-snippets.utils")
local M = {}

M.snippets_loaded = false

local snippets = {
  -- Layout load function
  utils.s(
    { trig = "lload", desc = "SvelteKit layout load function" },
    utils.fmt(
      [[
import type {{ LayoutServerLoad }} from './$types';

export const load: LayoutServerLoad = async ({{ {} }}) => {{
    return {{
        {}
    }};
}};
]],
      {
        ls.insert_node(1, "/* parameters */"),
        ls.insert_node(2, "/* return values */"),
      }
    )
  ),
  -- Server-side load function
  utils.s(
    { trig = "sload", desc = "SvelteKit server load function" },
    utils.fmt(
      [[
import type {{ PageServerLoad }} from './$types';

export const load: PageServerLoad = async ({{ {} }}) => {{
    return {{
        {}
    }};
}};
]],
      {
        ls.insert_node(1, "/* parameters */"),
        ls.insert_node(2, "/* return values */"),
      }
    )
  ),
  -- Client-side load function
  utils.s(
    { trig = "cload", desc = "SvelteKit client load function" },
    utils.fmt(
      [[
import type {{ PageLoad }} from './$types';

export const load: PageLoad = ({{ {} }}) => {{
    return {{
        {}
    }};
}};
]],
      {
        ls.insert_node(1, "/* parameters */"),
        ls.insert_node(2, "/* return values */"),
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
        ls.insert_node(1, "/* form data */"),
        ls.insert_node(2, "/* return values */"),
      }
    )
  ),
}

function M.setup(config)
  if M.snippets_loaded then
    return
  end

  local prefix = config and config.prefix or ""
  local processed_snippets = {}

  for _, snippet in ipairs(snippets) do
    if snippet then
      local new_trigger = prefix and prefix ~= "" and (prefix .. "-" .. snippet.trigger) or snippet.trigger
      local new_snippet = vim.deepcopy(snippet)
      new_snippet.trigger = new_trigger
      table.insert(processed_snippets, new_snippet)
    end
  end

  ls.add_snippets("typescript", processed_snippets)
  M.snippets_loaded = true
end

return M
