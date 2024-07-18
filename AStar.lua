---A Star 寻路算法 (借鉴：https://www.redblobgames.com/pathfinding/a-star/implementation.html)
---@class AStar

local AStar = class("AStar")
local function heuristic(a, b)
    return math.abs(a.x - b.x) + math.abs(a.y - b.y)
end
--cc.p 作为key值时不唯一，需要转成string
local function t2s(pos)
    return string.format("%s-%s",pos.x, pos.y)
end
--string 转cc.p()
local function s2t(tbl)
    local newTbl = {}
    for key, v in pairs(tbl) do
        local keyData = string.split(key)
        local newKey = cc.p(keyData[1], keyData[2])
        newTbl[newKey] = v
    end
    return newTbl
end

---发现新的问题（没有按顺序排）

function AStar:findPath(graph, start, goal)
    local frontier = {}
    table.insert(frontier, {node = start, priority = 0})

    local came_from = {}   --下个节点-上个节点 映射表
    local cost_so_far = {} --节点-实际代价 映射表
    came_from[t2s(start)] = nil 
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
                    print("current",current.x, current.y)
                    came_from[t2s(next)] = current
                end
            end
        end
    end
    local new_came_from = s2t(came_from)

    return new_came_from, cost_so_far
end

return AStar