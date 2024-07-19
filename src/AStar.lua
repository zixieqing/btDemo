---A Star 寻路算法 (借鉴：https://www.redblobgames.com/pathfinding/a-star/implementation.html)
---@class AStar

local AStar = class("AStar")
local OrderedMap = import('.third.OrderMap')
local function heuristic(a, b)
    return math.abs(a.x - b.x) + math.abs(a.y - b.y)
end
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

function AStar:findPath(graph, start, goal)
   
    local frontier = {}
    table.insert(frontier, {node = start, priority = 0})

    -- local came_from = {}   --下个节点-上个节点 映射表
    local came_from = OrderedMap:new()
    local cost_so_far = {} --节点-实际代价 映射表
    -- came_from[t2s(start)] = nil 
    came_from:set(t2s(start), 0)
    cost_so_far[t2s(start)] = 0

    while table.nums(frontier) > 0 do
        local current = frontier[1].node
        table.remove(frontier, 1)

        if current.x == goal.x and current.y == goal.y then
            break
        end

        for _, next in ipairs(graph:neighbors(current)) do
            if not graph:isBlock(next) then
                local new_cost = cost_so_far[t2s(current)] + graph:cost(current, next)
                if not cost_so_far[t2s(next)] or new_cost < cost_so_far[t2s(next)] then
                    cost_so_far[t2s(next)] = new_cost
                    local priority = new_cost + heuristic(next, goal)
                    table.insert(frontier, {node = next, priority = priority})
                    table.sort(frontier, function (a , b)
                        return a.priority < b.priority
                    end)
                    -- came_from[t2s(next)] = current
                    came_from:set(t2s(next), current)
                end
            end
        end
    end
    local new_came_from = s2t(came_from)

    --做进一步处理（过滤掉多余探索路径,最终得到一条唯一路径）
    local uniqueRoute = OrderedMap.new()
    local function filterRoute(goal)
        if goal.x == start.x and goal.y == start.y then
            return  
        end
        for next, pre in new_came_from:pairs() do
            if next.x == goal.x and next.y == goal.y then
                uniqueRoute:set(next, pre)
                filterRoute(pre)
                return 
            end
        end
    end

    filterRoute(goal)

    return uniqueRoute, cost_so_far
end

return AStar