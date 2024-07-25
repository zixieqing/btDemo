--- Greedy Best First Search 贪心最佳优先算法
---@class GreedyBestFirstSearch
local GreedyBestFirstSearch = class("GreedyBestFirstSearch")
--[[
【缺点】路径不是最短路径，只能是较优；不同代价的，如水，泥泞路，得到的路径代价可能会很大，不如A*
【优点】优势
计算速度快：贪心算法通常比A*算法更快，因为它只考虑当前节点到目标的直线距离，减少了计算量。(到（20，2）明显步数少了许多：A Star:134 GBFS:84)
适用于实时应用：在需要即时反馈的场景中，贪心算法能够迅速给出路径，适合动态环境。
]]

local OrderedMap = import('..third.OrderMap')
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

function GreedyBestFirstSearch:findPath(graph, start, goal)
    local frontier = {}
    table.insert(frontier, {node = start, priority = 0})

    local came_from = OrderedMap:new()
    came_from:set(t2s(start), 0)

    while table.nums(frontier) > 0 do
        local current = frontier[1].node
        table.remove(frontier, 1)

        if current.x == goal.x and current.y == goal.y then
            break
        end

        for _, next in ipairs(graph:neighbors(current)) do
            if not graph:isBlock(next) then
                if not came_from:get(t2s(next)) then
                    local priority = heuristic(next, goal)
                    table.insert(frontier, {node = next, priority = priority})
                    table.sort(frontier, function (a , b)
                        return a.priority < b.priority
                    end)
                    came_from:set(t2s(next), current)
                end
            end
        end
    end
    local new_came_from = s2t(came_from)

    -- --做进一步处理（过滤掉多余探索路径,最终得到一条唯一路径）
    -- local uniqueRoute = OrderedMap.new()
    -- local function filterRoute(goal)
    --     if goal.x == start.x and goal.y == start.y then
    --         return  
    --     end
    --     for next, pre in new_came_from:pairs() do
    --         if next.x == goal.x and next.y == goal.y then
    --             uniqueRoute:set(next, pre)
    --             filterRoute(pre)
    --             return 
    --         end
    --     end
    -- end

    -- filterRoute(goal)

    return new_came_from
end


return GreedyBestFirstSearch