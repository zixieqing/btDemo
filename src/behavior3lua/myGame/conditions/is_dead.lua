-- FindEnemy

local bret = require "behavior3.behavior_ret"

local M = {
    name = "IsDead",
    type = "Condition",
    desc = "是否死亡",
    doc = [[
        + 死亡，HandleDeath
        - 没死，走下一步即可
    ]]
}

function M.run(node, env)
    return env.owner.hp < 0 and bret.SUCCESS or bret.FAIL
end

return M