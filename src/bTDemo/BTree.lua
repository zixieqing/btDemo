--- 行为树管理
---@class BTree 
local BTree = class("BTree")
package.path = package.path .. ';behavior3lua/?.lua;behavior3lua/;lualib/?.lua'
require "adaptLua51"
local behavior_tree = require "behavior3.behavior_tree"
local behavior_node = require "behavior3.behavior_node"
local process = require "behavior3lua.myGame.process"


function BTree:ctor(param)
    self.hero = param.hero
    self.monsters = param.monsters
    self.context = nil
    self.monstersTree = {}
    self:loadBehaviorNode()
    self:loadTrees()
end

function BTree:loadTrees()
    local ctx = self:genContext()
    self.playerTree = behavior_tree.new("hero", self:loadTree("workspace/trees/hero.json"), {
        ctx   = ctx,
        owner = ctx.avatars[1],
    })
    for index, monster in pairs(self.monsters) do
        local monsterTree = behavior_tree.new("monster", self:loadTree("workspace/trees/monster.json"), {
            ctx   = ctx,
            owner = ctx.avatars[1 + index],
        })
        table.insert(self.monstersTree, monsterTree)
    end
end

function BTree:loadBehaviorNode()
    process.Listen = {
        run = function()
            print("Listen not defined")
            return "success"
        end
    }
    behavior_node.process(process)
end

function BTree:loadTree(confPath)
    local path = getBTDir()..confPath
    local file, err = io.open(path, 'r')
    assert(file, err)
    local str = file:read('*a')
    file:close()
    return json.decode(str)
end

---行为树上下文
---@return table
function BTree:genContext()
    local avatars = {}
    table.insert(avatars, self.hero)
    for _, monster in pairs(self.monsters) do
        table.insert(avatars, monster)
    end
    local ctx = {
        time = 0,
        avatars = avatars,
    }
    function ctx:find(func) -- 根据func 条件对 【对象】进行筛选
        local list = {}
        for _, v in pairs(ctx.avatars) do
            if func(v) then
                list[#list+1] = v
            end
        end
        return list
    end
    function ctx:remove(target) --移除
        for index, avatar in pairs(ctx.avatars) do
            if target == avatar then
                table.remove(ctx.avatars, index)
            end
        end
    end
    self.context = ctx
    return self.context
end

function BTree:setCtxTime(time)
    self.context.time = time
end
function BTree:getCtxTime()
    return self.context.time
end

-------------------get/set--------------------------
function BTree:getHeroTree()
    return self.playerTree
end
function BTree:getMonstersTree()
    return self.monstersTree
end

return BTree