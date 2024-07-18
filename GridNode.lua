--- 地图网格绘制
---@class GridNode 
local GridNode = class("GridNode", cc.Node)

function GridNode:ctor(tiledMap)
    self.tiledMap = tiledMap
    self:drawGrid()
end

function GridNode:drawGrid()
    local mapSize = self.tiledMap:getMapSize()
    local tileSize = self.tiledMap:getTileSize()

    -- 绘制垂直线
    for x = 0, mapSize.width do
        cc.DrawNode:create():drawLine(
            cc.p(x * tileSize.width, 0),
            cc.p(x * tileSize.width, mapSize.height * tileSize.height),
            cc.c4f(1, 1, 1, 1)
        ):addTo(self)
    end

    -- 绘制水平线
    for y = 0, mapSize.height do
        cc.DrawNode:create():drawLine(
            cc.p(0, y * tileSize.height),
            cc.p(mapSize.width * tileSize.width, y * tileSize.height),
            cc.c4f(1, 1, 1, 1)
        ):addTo(self)
    end
end

function GridNode:clear()
    self:removeAllChildren()
end

return GridNode
