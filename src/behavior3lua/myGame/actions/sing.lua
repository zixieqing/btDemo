-- Sing

local bret = require "behavior3.behavior_ret"

local M = {
    name = "Sing",
    type = "Action",
    desc = "唱歌",
    args = {
        {
            name = 'time',
            type = 'int?',
            desc = '唱歌持续时间'
        }
    }
}

function M.run(node, env)
    if not env.ctx.startTime then
        env.ctx.startTime = env.ctx.time
    end
    if env.ctx.time - env.ctx.startTime > node.args.time then
        env.ctx.startTime = nil
        return bret.SUCCESS
    end
    env.owner:sing()
    return node:yield(env)
end

return M