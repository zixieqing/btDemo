local bret = require 'behavior3.behavior_ret'

local M = {
    name = 'Patrol',
    type = 'Action',
    desc = '在一定范围内巡逻',
    args = {
        {
            name = 'w',
            type = 'int?',
            desc = '宽'
        },
        {
            name = 'h',
            type = 'int?',
            desc = '高'
        },
        {
            name = 'speed',
            type = 'int?',
            desc = '速度'
        }
    }
}
local direction = 1
function M.run(node, env)
    local owner = env.owner
    owner.x = owner.x + node.args.speed * direction * 0.016
    if owner.x < 0 then
        owner.x = 0
        direction = 1
    elseif owner.x > 900 then
        owner.x = 900
        direction = -1 
    end
    owner:setPosition(cc.p(owner.x, owner.y))
    return node:yield(env)
end

return M
