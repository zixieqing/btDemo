-- Idle
--

local bret = require "behavior3.behavior_ret"

local M = {
    name = "FindFood",
    type = "Action",
    desc = "找食物",
    output = {"{目标食物}"},
}

function M.run(node, env)
    print "FindFood"
    return bret.SUCCESS
end

return M