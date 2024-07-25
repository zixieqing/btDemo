--- Breadth First Search 广度优先算法、宽度优先算法BFS
---@class BreadthFirstSearch

--[[
【特性】
- **无权图**：适用于无权图，所有边的移动代价相同。
- **适合小规模地图**：在节点较少的情况下效率较高。
--]]

--[[
【应用场景】
简单地图：在2D平台游戏中，角色需要在简单的网格或迷宫中找到目标。
NPC路径规划：用于非玩家角色（NPC）在固定路径或简单环境中寻找目标。
事件触发：在特定条件下，NPC寻找玩家或其他事件触发点。
--]]


local BreadthFirstSearch = class("BreadthFirstSearch")
local OrderedMap = import('..third.OrderMap')
--cc.p 作为key值时不唯一，需要转成string
local function t2s(pos)
    return string.format("%s-%s",pos.x, pos.y)
end
--string 转cc.p()
local function s2t(tbl)
    local newTbl = OrderedMap:new()
    for key, v in tbl:pairs() do
        local keyData = string.split(key,"-")
        local newKey = cc.p(tonumber(keyData[1]), tonumber(keyData[2]))
        newTbl:set(newKey, v)
    end
    return newTbl
end

function BreadthFirstSearch:isFind(graph, start, goal)
    local queue = {start}

    local reached = {}
    reached[t2s(start)] = true

    while table.nums(queue) > 0 do
        local current = table.remove(queue, 1)

        if current.x == goal.x and current.y == goal.y then
           return true
        end

        for _, next in ipairs(graph:neighbors(current)) do
            if not reached[t2s(next)] then
                print("visiting ", t2s(next))
                reached[t2s[next]] = true
                table.insert(queue, next)
            end
        end
    end
    return false
end


function BreadthFirstSearch:findPath(graph, start, goal)
    local queue = {start}

    local came_from = OrderedMap.new()
    came_from:set(t2s(start), 0 )

    while table.nums(queue) > 0 do
        local current = table.remove(queue, 1)

        if current.x == goal.x and current.y == goal.y then
           break
        end

        for _, next in ipairs(graph:neighbors(current)) do
            if not graph:isBlock(next) then
                if not came_from:get(t2s(next)) then
                    print("visiting", t2s(next))
                    came_from:set(t2s(next), current)
                    table.insert(queue, next)
                end
            end
        end
    end
    local new_came_from = s2t(came_from)
    return new_came_from
end

return BreadthFirstSearch