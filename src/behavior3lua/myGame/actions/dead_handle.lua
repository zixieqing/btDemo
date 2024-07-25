-- FindEnemy

local bret = require "behavior3.behavior_ret"

local M = {
    name = "DeadHandle",
    type = "Action",
    desc = "死亡处理",
    doc = [[
        终止行为树，移除怪物
    ]]
}

function M.run(node, env)
    local owner = env.owner
    print "Do Dead"
    env.ctx:remove(owner)
    owner:dead()
    return bret.ABORT
end

return M