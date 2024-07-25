---B Star 算法
---@class BStar 
------------------------------
--[[
A*：一旦找到目标，立即返回。适合静态环境。
B*：可能会继续探索其他路径，适合动态或复杂环境。可以在实现中加入更多的边界管理和动态调整逻辑。
--]]
local BStar = class("BStar")
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
local function heuristic(a, b)
    return math.abs(a.x - b.x) + math.abs(a.y - b.y)
end
function BStar:findPath(graph, start, goal)
    local frontier = {}
    table.insert(frontier, {node = start , priority = 0})
    local came_from = OrderedMap.new()
    came_from:set(t2s(start), 0)

    local cost_so_far = {}
    cost_so_far[t2s(start)] = 0

    --B Star add
    local total_cost = {}
    total_cost[t2s(start)] = heuristic(goal, start)

    while table.nums(frontier) > 0 do
        local current = table.remove(frontier, 1).node
        if current.x == goal.x and current.y == goal.y then
            break            
        end
        for _, next in pairs(graph:neighbors(current)) do
            if not graph:isBlock(next) then
                local next_cost = cost_so_far[t2s(current)] + graph:cost(current, next)
                if not cost_so_far[t2s(next)] or cost_so_far[t2s(next)] > next_cost then
                    cost_so_far[t2s(next)] = next_cost
                    local priority = next_cost + heuristic(next, goal)

                    --B Star add
                    if not total_cost[t2s(next)] or priority < total_cost[t2s(next)] then
                        total_cost[t2s(next)] = priority

                        table.insert(frontier, {node = next, priority = priority})
                        table.sort(frontier, function(a, b)
                            return a.priority < b.priority
                        end)
                        came_from:set(t2s(next), current)
                    end
                end
            end
        end
    end
    local new_came_from = s2t(came_from)

    return new_came_from
end

return BStar