-- lua/sveltekit-snippets/utils.lua
local ls = require("luasnip")
local M = {}

M.s = ls.snippet
M.t = ls.text_node
M.i = ls.insert_node
M.f = ls.function_node
M.c = ls.choice_node
M.fmt = require("luasnip.extras.fmt").fmt

function M.create_snippet(trigger, nodes, description)
	return M.s({ trig = trigger, desc = description }, nodes)
end

-- Add the update_snippet_triggers function here
function M.update_snippet_triggers(snippets, prefix)
	if not snippets then
		return {}
	end
	if not prefix or prefix == "" then
		return snippets
	end

	local updated = {}
	for _, snippet in ipairs(snippets) do
		if snippet then
			local new_snippet = vim.deepcopy(snippet)
			new_snippet.trigger = prefix .. "-" .. snippet.trigger
			table.insert(updated, new_snippet)
		end
	end
	return updated
end

return M
