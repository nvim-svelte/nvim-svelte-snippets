local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

local M = {}

-- Helper function to create a snippet with a description
local function create_snippet(trigger, nodes, description)
  return s({ trig = trigger, desc = description }, nodes)
end

-- SvelteKit specific snippets
local snippets = {
  -- Page component
  create_snippet(
    "page",
    fmt(
      [[
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
      {
        i(1, "// your script here"),
        i(2, "Page Title"),
        i(3, "<!-- your content here -->"),
        i(4, "/* your styles here */"),
      }
    ),
    "SvelteKit page component"
  ),

  -- Page data loading
  create_snippet(
    "load",
    fmt(
      [[

export const load = {}(async ({}) => {{
    {}

    return {{
        {}
    }};
}});
    ]],
      {
        c(1, {
          t(""),
          t("satisfies PageLoad "),
          t("satisfies PageServerLoad "),
        }),
        i(2, "params, fetch"),
        i(3, "// fetch your data here"),
        i(4, "prop: value"),
      }
    ),
    "SvelteKit load function"
  ),

  -- Form actions
  create_snippet(
    "actions",
    fmt(
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
        i(1, "const data = await request.formData();"),
        i(2, "success: true"),
      }
    ),
    "SvelteKit form actions"
  ),

  -- Each block
  create_snippet(
    "each",
    fmt(
      [[
{{#each {} as {}}}
    {}
{{/each}}
    ]],
      {
        i(1, "items"),
        i(2, "item"),
        i(3, "{item}"),
      }
    ),
    "Svelte each block"
  ),
}

function M.setup()
  -- Add snippets to LuaSnip
  ls.add_snippets("svelte", snippets)
end

return M
