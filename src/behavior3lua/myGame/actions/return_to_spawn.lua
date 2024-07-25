local bret = require 'behavior3.behavior_ret'

local M = {
    name = 'ReturnToSpawn',
    type = 'Action',
    desc = '移动到出生点',
}

function M.run(node, env)
    local owner = env.owner
    owner:setPosition(owner:getSpawnPoint())
    return bret.SUCCESS
end

return M
