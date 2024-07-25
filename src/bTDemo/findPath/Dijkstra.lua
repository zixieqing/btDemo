--- 戴克斯特拉算法、迪杰斯特拉算法、Dijkstra’s Algorithm
---@class Dijkstra
--[[
- **有权图支持**：可以处理有权图，但要求边的权重为非负值。
- **全局最优**：确保找到从起点到所有节点的最短路径。
- **较高时间复杂度**：在大型图中，计算复杂度较高，可能影响性能。
- **适合静态环境**：在地图变化不频繁的情况下效果较好。

优势：保证找到从起点到所有节点的最短路径。
劣势：在大规模图中可能会比较慢，因为【它会探索所有可能路径。】
适用场景：网络路由、地图导航等。


只会计算当前块到下个块之间的代价
--]]

--[[
应用场景：
- **复杂地图导航**：在大规模开放世界游戏中，计算从一个地点到多个目标地点的最短路径。
- **动态环境**：当地图上的障碍物或路径变化时，实时更新路径。
- **资源管理**：在策略游戏中，单位需要在资源点之间优化移动路径。
]]

local Dijkstra = class("Dijkstra")
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

function Dijkstra:findPath(graph, start, goal)
   
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
                    local priority = new_cost --比A Star 少了预估代价
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

    return new_came_from, cost_so_far
end

return Dijkstra