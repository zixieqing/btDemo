-- FindEnemy

local bret = require "behavior3.behavior_ret"

local M = {
    name = "CheckHP",
    type = "Condition",
    desc = "比较对象HP、参数值HP",
    args = {
        {
            name = 'hp',
            type = 'int?',
            desc = 'hp'
        },
        {
            name = 'condition',
            type = 'string?',
            desc = '条件：输入 > ; < ; ='
        },
    },
    doc = [[
       当输入>时；即参数hp大于对象,返回success,否则就fail
    ]]
}

local function ret(r)
    return r and bret.SUCCESS or bret.FAIL
end

function M.run(node, env)
    if node.args.condition == "<" then
        return ret(env.owner.hp < node.args.hp)
    elseif node.args.condition == ">" then
        return ret(env.owner.hp > node.args.hp)
    elseif node.args.condition == "=" then
        return ret(env.owner.hp == node.args.hp)
    else
        print("args condition is error")
    end
end

return M