local bret = require "behavior3.behavior_ret"
local butil = require "behavior3.behavior_util"

---@type BehaviorNodeDefine
local M = {
    name = "Let",
    type = "Action",
    desc = "定义新的变量名",
    input = { "已存在变量名?" },
    args = {
        {
            name= "expr",
            type= "json?",
            desc= "表达式",
            oneof= "已存在变量名",
        }
    },
    output = { "新变量名" },
    doc = [[
        + 如果有输入变量，则给已有变量重新定义一个名字
        + 如果有表达式，则使用表达式
        + 如果表达式为 \`null\`，则清除变量
    ]],
    run = function(node, env, value)
        local args = node.args
        value = butil.check_oneof(node, 1, value, args.expr, butil.NIL)
        return bret.SUCCESS, value
    end
}

return M