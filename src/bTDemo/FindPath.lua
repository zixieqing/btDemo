-- 定义节点类
local Node = class("Node")

function Node:ctor(x, y)
    self.x = x
    self.y = y
    self.parent = nil
    self.g = 0 -- 从起点到该节点的实际移动代价
    self.h = 0 -- 从该节点到终点的估计代价
    self.f = 0 -- 总代价(g + h)
end


-- 定义A*寻路函数
function findPath(startX, startY, endX, endY, grid)
    local openList = {}
    local closedList = {}

    -- 创建起点和终点节点
    local startNode = Node.new(startX, startY)
    local endNode = Node.new(endX, endY)

    -- 将起点加入开放列表
    table.insert(openList, startNode)

    while #openList > 0 do
        -- 从开放列表中选择F值最小的节点作为当前节点
        local currentNode = openList[1]
        for i = 2, #openList do
            if openList[i].f < currentNode.f then
                currentNode = openList[i]
            end
        end

        -- 将当前节点从开放列表移动到关闭列表
        table.remove(openList, table.index(openList, currentNode))
        table.insert(closedList, currentNode)

        -- 如果当前节点是终点,则找到路径
        if currentNode.x == endNode.x and currentNode.y == endNode.y then
            local path = {}
            local node = currentNode
            while node do
                table.insert(path, 1, {node.x, node.y})
                node = node.parent
            end
            return path
        end

        -- 检查当前节点的相邻节点
        for dx = -1, 1 do
            for dy = -1, 1 do
                local x = currentNode.x + dx
                local y = currentNode.y + dy

                -- 跳过当前节点自身
                if dx == 0 and dy == 0 then
                    goto continue
                end

                -- 跳过不可通过的格子
                if grid[y] and grid[y][x] and grid[y][x] == 1 then
                    goto continue
                end

                -- 创建相邻节点
                local neighborNode = Node(x, y)

                -- 如果相邻节点不在关闭列表中,则计算其G值、H值和F值
                if not table.contains(closedList, neighborNode) then
                    local g = currentNode.g + math.sqrt(dx * dx + dy * dy)
                    local h = math.sqrt((x - endNode.x) ^ 2 + (y - endNode.y) ^ 2)
                    neighborNode.g = g
                    neighborNode.h = h
                    neighborNode.f = g + h
                    neighborNode.parent = currentNode

                    -- 如果相邻节点不在开放列表中,则加入开放列表
                    if not table.contains(openList, neighborNode) then
                        table.insert(openList, neighborNode)
                    end
                end

                ::continue::
            end
        end
    end

    -- 如果无法找到路径,返回nil
    return nil
end

return Node
-- -- 示例用法
-- local grid = {
--     {0, 0, 0, 0, 0},
--     {0, 0, 1, 0, 0},
--     {0, 0, 0, 0, 0},
--     {0, 1, 0, 1, 0},
--     {0, 0, 0, 0, 0}
-- }

-- local path = findPath(0, 0, 4, 4, grid)
-- if path then
--     -- 绘制寻路路径
--     for i, node in ipairs(path) do
--         print("(" .. node[1] .. ", " .. node[2] .. ")")
--     end
-- else
--     print("无法找到路径")
-- end
