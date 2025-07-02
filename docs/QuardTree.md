```lua
-- 四叉树节点
local QuadTreeNode = {
    x = 0, -- 节点坐标x
    y = 0, -- 节点坐标y
    width = 0, -- 节点宽度
    height = 0, -- 节点高度
    northWest = nil, -- 西北子节点
    northEast = nil, -- 东北子节点
    southWest = nil, -- 西南子节点
    southEast = nil, -- 东南子节点
    data = nil -- 节点数据
}

-- 创建四叉树节点
function QuadTreeNode:new(x, y, width, height, data)
    local node = {
        x = x,
        y = y,
        width = width,
        height = height,
        data = data
    }
    setmetatable(node, self)
    self.__index = self
    return node
end

-- 插入数据到四叉树
function QuadTreeNode:insert(x, y, data)
    -- 如果当前节点没有子节点,则创建子节点
    if self.northWest == nil then
        local halfWidth = self.width / 2
        local halfHeight = self.height / 2
        self.northWest = QuadTreeNode:new(self.x, self.y, halfWidth, halfHeight, nil)
        self.northEast = QuadTreeNode:new(self.x + halfWidth, self.y, halfWidth, halfHeight, nil)
        self.southWest = QuadTreeNode:new(self.x, self.y + halfHeight, halfWidth, halfHeight, nil)
        self.southEast = QuadTreeNode:new(self.x + halfWidth, self.y + halfHeight, halfWidth, halfHeight, nil)
    end

    -- 判断数据应该插入到哪个子节点
    if x < self.x + self.width / 2 then
        if y < self.y + self.height / 2 then
            self.northWest:insert(x, y, data)
        else
            self.southWest:insert(x, y, data)
        end
    else
        if y < self.y + self.height / 2 then
            self.northEast:insert(x, y, data)
        else
            self.southEast:insert(x, y, data)
        end
    end

    -- 如果当前节点有数据,则合并数据
    if self.data == nil then
        self.data = data
    end
end

-- 查找四叉树中的数据
function QuadTreeNode:find(x, y)
    -- 如果当前节点包含数据,则返回数据
    if self.data ~= nil then
        return self.data
    end

    -- 判断数据应该在哪个子节点中
    if x < self.x + self.width / 2 then
        if y < self.y + self.height / 2 then
            return self.northWest:find(x, y)
        else
            return self.southWest:find(x, y)
        end
    else
        if y < self.y + self.height / 2 then
            return self.northEast:find(x, y)
        else
            return self.southEast:find(x, y)
        end
    end

    -- 如果没有找到数据,则返回nil
    return nil
end
```