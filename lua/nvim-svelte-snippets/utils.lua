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

return M
