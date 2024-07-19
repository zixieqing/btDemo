-- Attack
--

local bret = require "behavior3.behavior_ret"
local M = {
    name = "Attack",
    type = "Action",
    desc = "攻击",
    input = {"{目标}"},
}

function M.run(node, env, enemy)
    if not enemy then
        return bret.FAIL
    end

    local owner = env.owner
    print "Do Attack"
    -- enemy.hp = enemy.hp - 100
    owner:attack()
    local damage = owner:getAckDamage() --伤害量
    enemy:takeDamage(damage)

    env.vars.ATTACKING = true
       
    return bret.SUCCESS
    -- return bret.ABORT
end

return M