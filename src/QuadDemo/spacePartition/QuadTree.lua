---四叉树
---@class QuadTree
--[[
插入逻辑：
 1.开始就一个大的格子，不断插入
 2.存储超过了格子存储容量，
 3.开始拆分为4个小格子，并把原来这个格子里的所有对象，按照分好的4个格子，继续插入到分好的4个小格子（边插边从原来大格子的对象慢慢移除）
 4.小格子插的超过了最大容量-继续递归3
查找逻辑：
 1.先按对象位置，查找属于哪个大格子；
 2.如果大格子下还有小格子，
 3.继续进去查找属于哪个小格子，- 不断递归
 
--]]

local QuadTree = {}
QuadTree.__index = QuadTree

function QuadTree:new(x, y, width, height, level)
    local obj = {
        bounds = {x = x, y = y, width = width, height = height},
        objects = {},
        nodes = {},
        level = level or 0,
        maxObjects = 10, -- 每个节点最多存储的对象数量
        maxLevels = 5    -- 最大递归层数
    }
    setmetatable(obj, QuadTree)
    return obj
end

function QuadTree:split()
    local halfWidth = self.bounds.width / 2
    local halfHeight = self.bounds.height / 2

    -- 创建四个子节点，调整y坐标以适应Cocos坐标系统
    self.nodes[1] = QuadTree:new(self.bounds.x, self.bounds.y, halfWidth, halfHeight, self.level + 1) -- 左下象限
    self.nodes[2] = QuadTree:new(self.bounds.x + halfWidth, self.bounds.y, halfWidth, halfHeight, self.level + 1) -- 右下象限
    self.nodes[3] = QuadTree:new(self.bounds.x, self.bounds.y + halfHeight, halfWidth, halfHeight, self.level + 1) -- 左上象限
    self.nodes[4] = QuadTree:new(self.bounds.x + halfWidth, self.bounds.y + halfHeight, halfWidth, halfHeight, self.level + 1) -- 右上象限
    --[[
        3--4
        |  |
        1--2
    --]]
end

function QuadTree:insert(object)
    if #self.nodes > 0 then
        -- local index = self:getIndex(object)
        -- if index ~= -1 then
        --     self.nodes[index]:insert(object)
        --     return
        -- end
        local indices = self:getIndices(object)
        for _, index in ipairs(indices) do
            if index ~= -1 then
                self.nodes[index]:insert(object)
            end
        end
        return
    end

    table.insert(self.objects, object)

    if #self.objects > self.maxObjects and self.level < self.maxLevels then
        if #self.nodes == 0 then
            self:split()
        end

        local i = 1
        while i <= #self.objects do
            local indices = self:getIndices(self.objects[i])
            if #indices > 0 then
                local removeObj = table.remove(self.objects, i)
                for _, index in ipairs(indices) do
                    self.nodes[index]:insert(removeObj)
                end
    
            -- local index = self:getIndex(self.objects[i])
            -- if index ~= -1 then
            --     self.nodes[index]:insert(table.remove(self.objects, i))
            else
                i = i + 1
            end
        end
    end
end

--未考虑边界问题
function QuadTree:getIndex(object)
  --[[
        3--4
        |  |
        1--2
  --]]

    local index = -1
    local verticalMidpoint = self.bounds.x + (self.bounds.width / 2)
    local horizontalMidpoint = self.bounds.y + (self.bounds.height / 2)


    local topQuadrant = object.y > horizontalMidpoint
    local bottomQuadrant = object.y + object.height < horizontalMidpoint


    if object.x < verticalMidpoint and object.x + object.width < verticalMidpoint then
        if topQuadrant then
            index = 3 -- 左上象限
        elseif bottomQuadrant then
            index = 1 -- 左下象限
        end
    elseif object.x > verticalMidpoint then
        if topQuadrant then
            index = 4 -- 右上象限
        elseif bottomQuadrant then
            index = 2 -- 右下象限
        end
    end

    return index
end

--- 处理对象处于交叉部分的问题
function QuadTree:getIndices(object)
    local indices = {}
    local verticalMidpoint = self.bounds.x + (self.bounds.width / 2)
    local horizontalMidpoint = self.bounds.y + (self.bounds.height / 2)

    local topQuadrant = object.y + object.height > horizontalMidpoint
    local bottomQuadrant = object.y < horizontalMidpoint
    local function _insert(ele)
        if not table.indexof(indices, ele) then
            table.insert(indices, ele)
        end
    end


    if object.x + object.width < verticalMidpoint then
        if topQuadrant then
            _insert(3) -- 左上象限
        end
        if bottomQuadrant then
            _insert(1) -- 左下象限
        end
    elseif object.x > verticalMidpoint then
        if topQuadrant then
            _insert(4) -- 右上象限
        end
        if bottomQuadrant then
            _insert(2) -- 右下象限
        end
    elseif object.x < verticalMidpoint and object.x + object.width > verticalMidpoint then --左右交叉
        if topQuadrant then
            _insert(3) --上面
            _insert(4) 
        end
        if bottomQuadrant then
            _insert(1) --下面
            _insert(2)
        end
    end
    
    local rightQuadrant = object.x > verticalMidpoint
    local leftQuadrant = object.x + object.width < verticalMidpoint

    if object.y < horizontalMidpoint and object.y + object.height > horizontalMidpoint then  --上下交叉
        
        if rightQuadrant then
            _insert( 4) --右侧
            _insert( 2) 
        end
        if leftQuadrant then
            _insert( 3) --左侧
            _insert( 1) 
        end
    end
    -- if #indices > 1 then
    --     print("object", object.tag)
    -- end
--[[
        3--4
        |  |
        1--2
  --]]
    return indices
end

function QuadTree:retrieve(returnObjects, object)
    -- local index = self:getIndex(object)
    -- if index ~= -1 and #self.nodes > 0 then
    --     self.nodes[index]:retrieve(returnObjects, object)
    -- end
    local indices = self:getIndices(object)
    for _, index in ipairs(indices) do
        if index ~= -1 and #self.nodes > 0 then
            self.nodes[index]:retrieve(returnObjects, object)
        end
    end

    for _, obj in ipairs(self.objects) do
        if not table.indexof(returnObjects, obj) then
            table.insert(returnObjects, obj)
        end
    end

    return returnObjects
end


function QuadTree:draw(drawNode)
    -- 绘制当前节点的边界
    drawNode:drawRect(cc.p(self.bounds.x, self.bounds.y), 
                      cc.p(self.bounds.x + self.bounds.width, self.bounds.y + self.bounds.height), 
                      cc.c4f(1, 0, 0, 1)) -- 红色边框

    -- 如果有子节点，递归绘制
    for _, node in ipairs(self.nodes) do
        if node then
            node:draw(drawNode)
        end
    end
end

return QuadTree
