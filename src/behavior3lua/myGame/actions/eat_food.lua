-- Idle
--

local bret = require "behavior3.behavior_ret"

local M = {
    name = "EatFood",
    type = "Action",
    desc = "吃食物",
    input = {"{目标食物}"},
}

function M.run(node, env)
    print "EatFood"
    return bret.SUCCESS
end

return M