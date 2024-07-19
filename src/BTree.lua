--- 行为树管理
---@class BTree 
local BTree = class("BTree")
package.path = package.path .. ';behavior3lua/?.lua;behavior3lua/;lualib/?.lua'
package.path = package.path .. ';bTDemo/?.lua;bTDemo/;'
require "adaptLua51"
local behavior_tree = require "behavior3.behavior_tree"
local behavior_node = require "behavior3.behavior_node"

function BTree:ctor(param)
    self.hero = param.hero
    self.monster = param.monster
    self.context = nil
    self:loadBehaviorNode()
    self:loadTrees()
end

function BTree:loadTrees()
    local ctx = self:genContext()
    self.playerTree = behavior_tree.new("hero", self:loadTree("workspace/trees/hero.json"), {
        ctx   = ctx,
        owner = self.hero,
    })
    self.monsterTree = behavior_tree.new("monster", self:loadTree("workspace/trees/monster.json"), {
        ctx   = ctx,
        owner = self.monster,
    })
end

function BTree:loadBehaviorNode()
    local process = require "behaviorTree.process"
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
    local ctx = {
        time = 0,
        avatars = {self.monster, self.hero},
    }
    function ctx:find(func)
        local list = {}
        for _, v in pairs(ctx.avatars) do
            if func(v) then
                list[#list+1] = v
            end
        end
        return list
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
function BTree:getMonsterTree()
    return self.monsterTree
end

return BTree