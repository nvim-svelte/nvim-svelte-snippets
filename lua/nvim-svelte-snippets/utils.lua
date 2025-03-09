local ls = require("luasnip")
local M = {}

-- Basic node types
M.s = ls.snippet
M.t = ls.text_node
M.i = ls.insert_node
M.f = ls.function_node
M.c = ls.choice_node
M.d = ls.dynamic_node
M.sn = ls.snippet_node
M.fmt = require("luasnip.extras.fmt").fmt

-- Create a snippet with proper node formatting
function M.create_snippet(trigger, nodes, description)
	return M.s({ trig = trigger, desc = description }, nodes)
end

-- Update snippet triggers with a prefix
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
