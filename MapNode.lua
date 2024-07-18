local MapNode = class("MapNode", function()
    return display.newNode()
end)
local GridNode = import('.GridNode')

function MapNode:ctor()
    self:initMap()
    self:createGrid()
    -- self:renderGrid()
end

function MapNode:initMap()
    self.tileMap = cc.TMXTiledMap:create("quanxinMap/quanxin.tmx")
    self:addChild(self.tileMap, -1)

    local objects = self.tileMap:getObjectGroup("Objects")
    local spawnPoints = objects:getObject("spawnPoint")
    self.spawnPos = cc.p(spawnPoints["x"], spawnPoints["y"])

    self.foods = self.tileMap:getLayer("food")
    self.blocks = self.tileMap:getLayer("block")

    self.mapSize = self.tileMap:getMapSize()
    self.tileSize = self.tileMap:getTileSize()
end


-- 创建网格数据
function MapNode:createGrid()
    local mapWidth = self.tileMap:getMapSize().width
    local mapHeight = self.tileMap:getMapSize().height
    local grid = {}
    for y = 1, mapHeight do
        grid[y] = {}
        for x = 1, mapWidth do
            if self:isBlock(cc.p(x - 1, y - 1)) then
                grid[y][x] = 1 --不可通过
            else
                grid[y][x] = 0 -- 可通过
            end
        end
    end
    self.grid = grid
end

function MapNode:renderGrid()
    local gridNode = GridNode:create(self.tileMap)
    gridNode:setPosition(cc.p(0, 0))
    self.tileMap:addChild(gridNode)
end

------------------------get/set--------------------------------------
function MapNode:getSpawnPoint()
    return self.spawnPos
end

---@return cc.size 地图的宽度和高度（以瓦片为单位）
function MapNode:getMapSize()
    return self.mapSize
end
---@return cc.Size 每个瓦片的尺寸
function MapNode:getTiledSize()
   return self.tileSize
end

---@return table 网格数据用于寻路
function MapNode:getGrids()
    return self.grid
end

function MapNode:isBlock(tiledPos)
    if self:isBorder(tiledPos) then
        return true
    end
    local tileGid = self.blocks:getTileGIDAt(tiledPos)
    if tileGid > 0 then
        -- local properties = self.tileMap:getPropertiesForGID(tileGid) -- 这个获取不到信息
        local properties = self.blocks:getProperties()
        if properties then
            local collision = properties["isBlock"]
            if collision and collision == "true" then
                print("遇到了阻挡")
                return true
            end
        end
    end
    return false
end

function MapNode:isBorder(tiledPos)
    local mapSize = self:getMapSize()
    if tiledPos.x > mapSize.width  or tiledPos.y > mapSize.height or tiledPos.y < 0 or tiledPos.x < 0 then
        return true
    else
        return false
    end
end

function MapNode:isUseFood(tileCoord)
    local foodGid = self.foods:getTileGIDAt(tileCoord)
    if foodGid > 0 then
        local properties = self.foods:getProperties()
        local collectable = properties["isFood"]
        if collectable and collectable == "true" then
            return true
        end     
    end
    return false
end

function MapNode:useFood(tileCoord)
    self.foods:removeTileAt(tileCoord)
end

---@param position vec2_table cocos坐标
---@return tiledMap 地图块坐标
function MapNode:tileCoordForPosition(position)
    local x = math.floor(position.x / self.tileMap:getTileSize().width)
    local y = math.floor((self.tileMap:getMapSize().height * self.tileMap:getTileSize().height - position.y) / self.tileMap:getTileSize().height)
    return cc.p(x, y)
end

function MapNode:neighbors(node)
    local x, y = node.x, node.y
    local neighbors = {
    cc.p(x+1, y), 
    cc.p(x-1, y), 
    cc.p(x, y-1), 
    cc.p(x, y+1)}
    return neighbors
end

function MapNode:cost(current, next)
    --目前先设置为1
    return 1
end

--- 格子坐标转cocos2dx坐标
---@param vec2_table tiled格子坐标
---@return vec2_table cocos 坐标
function MapNode:tp2cp(gridPos)
    local tileSize = self:getTiledSize()
    local mapSize = self:getMapSize()
    local x = gridPos.x * tileSize.width + tileSize.width/2
    local y = (mapSize.height - gridPos.y) * tileSize.height - tileSize.height / 2
    return cc.p(x, y)
end

return MapNode