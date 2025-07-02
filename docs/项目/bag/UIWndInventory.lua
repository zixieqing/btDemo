--- 背包
---@class UIWndInventory:UIWindowBase
local INVENTORY_WIDTH	= 10
local INVENTORY_HEIGHT = 6

local CELL_WIDTH = 30  -- 每个格子的宽度
local CELL_HEIGHT = 30 -- 每个格子的高度
local INVENTORY_START_X = 12  -- 背包在屏幕上的起始X坐标
local INVENTORY_START_Y = 25  -- 背包在屏幕上的起始Y坐标


local UIWndInventory = class("UIWndInventory", lt.UIWindowBase)
function UIWndInventory:ctor(param)
    UIWndInventory.super.ctor(self, param)
end

function UIWndInventory:onInit()
    UIWndInventory.super.onInit(self, "ui://Inventory/Inventory")
    self.isBGOpacity = false
    self.selectedItem = nil  -- 当前选中的物品

    self:initUI()
    self:initData()
end

function UIWndInventory:onShown()
    self:loadTipsNode()
    self:loadItems()
    self:touchArea()

end

function UIWndInventory:initUI()
    self.bg = self:getChild("bg")
    self.btnOpacity = self:getChild("btnOpacity")
    self.touchCheck = self:getChild("touchCheck")
    
    self.btnOpacity:addClickListener(handler(self, self.btnOpacityClick));
end

function UIWndInventory:btnOpacityClick()
    self.isBGOpacity = not self.isBGOpacity
    local url = self.isBGOpacity == false and "ui://Inventory/inventoryslayer_0" or "ui://Inventory/inventoryslayer_1"
    self.bg:setURL(url)
end

--- 装备镂空效果
--- 坑点：fairygui 无法使用cocos shader
function UIWndInventory:createEmptyEffect(pt, moPt)
    local row, col = self:calcGridPosByMouse(self.selectedItem, pt.x, pt.y)
    if row == nil or col == nil then return end

    local shaderColor = self:canPlaceItem(self.selectedItem, row, col) and cc.vec3(0,0,1) or cc.vec3(1,0,0)

    local texPath = self.selectedItem:getTexturePath()
    if not self.effectSp then
        self.effectSp = display.newSprite(texPath)
        self:displayObject():addChild(self.effectSp)
    else
        self.effectSp:setTexture(texPath)
    end
    local vSize = self:getSize()
    local offset = vSize.height - pt.y
    self.effectSp:setPosition(cc.p(pt.x, offset))
    lt.BorderEmptyEffect:render(self.effectSp, shaderColor)
end


function UIWndInventory:removeEmptyEffect()
    self.effectSp:removeFromParent()
    self.effectSp = nil
end

------------------------------- drag--------------------------
--[[
    1. 点击按下-进入选中状态-可以移动物品-再次点击按下（处理替换放置逻辑）
    2. 按住不放移动-鼠标放掉（没有逻辑处理）-再次按下（处理替换放置逻辑）
]]
function UIWndInventory:touchArea()
    if device.platform == "windows" then
        local function createMouseListener()
            local listener = cc.EventListenerMouse:create()
        
            -- 鼠标移动事件
            listener:registerScriptHandler(function(event) 
                if self.selectedItem then
                    self.isMouseMove = true
                    self:removeItem(self.selectedItem)
                    local pt = self:globalToLocal(event:getLocation()); 
                    self.selectedItem:setPosition(pt.x, pt.y)
                    self:createEmptyEffect(pt,event:getLocation())
                end
            end, cc.Handler.EVENT_MOUSE_MOVE)
        
            -- 鼠标按下事件
            listener:registerScriptHandler(function(event)
                print("Mouse button pressed")
                local pt = self:globalToLocal(event:getLocation()); 
                if self.selectedItem then
                    --处理能不能放下的问题
                    if self:mousePlaceItem(pt.x, pt.y) then
                        print("放下")
                        self:removeEmptyEffect()
                        self.selectedItem = nil
                    else
                        print("未放下")
                    end
                else
                    lt.FGUIUtil:drawPoint(self, pt)

                    self.selectedItem = self:isMouseOverItem(pt.x, pt.y)
                end
               
            end, cc.Handler.EVENT_MOUSE_DOWN)
        
            -- -- 鼠标释放事件（没有任何作用）
            -- listener:registerScriptHandler(function(event)
            --     print("Mouse button released")

            --     -- if self.selectedItem and self.isMouseMove then
            --     --     self.isMouseMove = false
            --     --     local pt = self:globalToLocal(event:getLocation()); 
            --     --     self:onMouseUp(pt.x, pt.y)
            --     --     -- self.selectedItem = nil
            --     -- end
            -- end, cc.Handler.EVENT_MOUSE_UP)
        
            return listener
        end
        
        local mouseListener = createMouseListener()
        cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(mouseListener, self.touchCheck:displayObject())
    end


    self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self.onTouchBegin));
    self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self.onTouchMove));
    self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self.onTouchEnd));
end

function UIWndInventory:onTouchBegin(context)
    print("UIWndInventory:onTouchBegin(context)")
    local evt = context:getInput()
    local globalPos = evt:getPosition()  -- 获取全局坐标
    local localPos = fgui.GRoot:getInstance():globalToLocal(globalPos)  -- 转换为局部坐标

    -- -- 检测是否触摸到某个物品
    -- for _, item in ipairs(self.items) do
    --     if self:containItem(cc.p(localPos.x, localPos.y)) then
    --         self.selectedItem = item
    --         self._offsetX = localPos.x - item.x
    --         self._offsetY = localPos.y - item.y
    --         break
    --     end
    -- end
end


function UIWndInventory:containItem(point)
    -- local function isContain(item, point)
    --     local bounds = item:getSize()
    --     local offset = display.cy - point.y
    --     local calcY = display.cy + offset
    --     local fguiTouchPoint = cc.p(point.x, calcY)
    --     local pos = item:getPosition()
    --     local rect = {
    --         x = pos.x,
    --         y = pos.y,
    --         width = bounds.width,
    --         height = bounds.height
    --     }
    --     local isContain = cc.rectContainsPoint(rect, fguiTouchPoint)
    --     return isContain
    -- end

    -- for _, item in ipairs(self.items) do
    --     if isContain(item, point) then
    --        return item
    --     end
    -- end
end

function UIWndInventory:onTouchMove(context)
    if self.selectedItem then
        local mouseX = context:GetInput().x
        local mouseY = context:GetInput().y
        
        -- 更新物品位置
        self.selectedItem:setPosition(mouseX - self._offsetX, mouseY - self._offsetY)
    end
end

function UIWndInventory:onTouchEnd()
    -- self.selectedItem = nil  -- 释放物品
end



--------------------- item data------------------------------
---初始化已经有的
function UIWndInventory:initItems()
    local testItems = {
        [1] = {index = 28, num = 0, startRow = 1, startCol =1},
        [2] = {index = 68, num = 0, startRow = 1, startCol =3},
        [3] = {index = 81, num = 0, startRow = 1, startCol =5},
        [4] = {index = 97, num = 0, startRow = 1, startCol =6},
    }
    for k, v in pairs(testItems) do
        self:addItemUI(v)
    end
end

function UIWndInventory:loadItems()

end

function UIWndInventory:setItemCenterPosition(item, startRows, startCols)
    local cellPos = self:getCellPosition(startRows, startCols, item.gridWidth, item.gridHeight)
    item:setPosition(cellPos.x, cellPos.y)
end

function UIWndInventory:addItemUI(itemInfo)
   
    local item = fgui.UIPackage:createObject("Item", "Item");
    item:setPivot(0.5,0.5, true)
    item:setItemInfo(itemInfo)

    local emptyPos = self:findEmptyPosition(item)


    ---TODO 后面这里要分为：初始化的和新增的，初始化的需要带初始格子坐标，新增的发送协议
    print("物品起始格子坐标[1], emptyPos[2]",emptyPos[1], emptyPos[2])
    self:addItem(item, emptyPos[1], emptyPos[2])
    self:setItemCenterPosition(item, emptyPos[1], emptyPos[2])
    item:setSortingOrder(100)

    self:addChild(item)

    ---tips
    local tipsPos = self:getTipsPosition(emptyPos[1], emptyPos[2])
    item:setTipNode(self.itemTips, tipsPos)
end


function UIWndInventory:loadTipsNode()
    local itemTips = fgui.UIPackage:createObject("CommonTL", "ItemTips");
    self:addChild(itemTips)
    self.itemTips = itemTips
    self.itemTips:setVisible(false)
end


-------------------------tiled------------------------------
function UIWndInventory:createTiled(row, col)
    local tiled = fgui.UIPackage:createObject("Inventory", "inventoryslayer_2")
    local cellPos = self:getCellPosition(row, col, 1, 1)
    
    tiled:setPivot(0.5, 0.5, true)
    tiled:setSortingOrder(99)
    self:addChild(tiled)
    tiled:setPosition(cellPos.x, cellPos.y)

    if not self.tiledMap then
        self.tiledMap = {} 
    end

  
    self.tiledMap[row .. "_" .. col] = tiled
end

function UIWndInventory:removeTiled(row, col)
    if self.tiledMap and self.tiledMap[row .. "_" .. col] then
        local tiled = self.tiledMap[row .. "_" .. col]
        tiled:removeFromParent() 
        self.tiledMap[row .. "_" .. col] = nil
    end
end
-------------------------tiled------------------------------

-------------------------data -------------------------------

function UIWndInventory:initData()
    self.grid = {}
    for i = 1, INVENTORY_WIDTH do
        self.grid[i] = {}
        for j = 1, INVENTORY_HEIGHT do
            self.grid[i][j] = nil -- 初始化为nil，表示格子为空
        end
    end
end

function UIWndInventory:addItem(item, startRow, startCol)
    if self:canPlaceItem(item, startRow, startCol) then
        for i = startRow, startRow + item.gridWidth - 1 do
            for j = startCol, startCol + item.gridHeight - 1 do
                self.grid[i][j] = item
                self:createTiled(i, j)
            end
        end
        return true
    end
    return false
end

function UIWndInventory:removeItem(item)
    local startRow, startCol = self:findItemPosition(item)

    if startRow and startCol then
        -- 遍历物品占用的格子并清空
        for i = startRow, startRow + item.gridWidth - 1 do
            for j = startCol, startCol + item.gridHeight - 1 do
                self.grid[i][j] = nil -- 清空格子
                self:removeTiled(i, j) -- 假设有一个移除图块的函数
            end
        end
        return true
    end
    return false -- 如果没有找到物品，返回 false
end


function UIWndInventory:canPlaceItem(item, startRow, startCol)
    if startRow + item.gridWidth - 1 > INVENTORY_HEIGHT or startCol + item.gridHeight - 1 > INVENTORY_WIDTH then
        return false
    end
    for i = startRow, startRow + item.gridWidth - 1 do
        for j = startCol, startCol + item.gridHeight - 1 do
            if self.grid[i][j] ~= nil then
                return false -- 已经有物品占用
            end
        end
    end
    return true
end

function UIWndInventory:findEmptyPosition(item)
    for i = 1, INVENTORY_HEIGHT do
        for j = 1, INVENTORY_WIDTH do
            if self:canPlaceItem(item, i, j) then
                return {i, j} -- 返回找到的空位置
            end
        end
    end
    print("not find empty pos")
    return nil -- 没有找到空位置
end

function UIWndInventory:getCellPosition(row, col, itemRows, itemCols)
    local x = INVENTORY_START_X + (col - 1) * CELL_WIDTH + (itemCols * CELL_WIDTH) / 2
    local y = INVENTORY_START_Y + (row - 1) * CELL_HEIGHT + (itemRows * CELL_HEIGHT) / 2
    return cc.p(x, y)
end
function UIWndInventory:getTipsPosition(row, col)
    local x = INVENTORY_START_X + (col - 1) * CELL_WIDTH 
    local y = INVENTORY_START_Y + (row - 1) * CELL_HEIGHT - self.itemTips:getSize().height
    return cc.p(x, y)
end

---------------------------------------------mouse logic------------------------------------------------
--根据鼠标的位置计算格子
function UIWndInventory:mouseToGridPos(mouseX, mouseY)
    -- 计算相对于背包的坐标
    local relativeX = mouseX - INVENTORY_START_X
    local relativeY = mouseY - INVENTORY_START_Y

    -- 计算行和列
    local row = math.ceil(relativeY / CELL_HEIGHT)
    local col = math.ceil(relativeX / CELL_WIDTH)
    return row, col
end

--- 根据鼠标位置计算装备格子起始位置
function UIWndInventory:calcGridPosByMouse(item, mouseX, mouseY)
    -- 计算相对于背包的坐标
    local relativeX = mouseX - INVENTORY_START_X
    local relativeY = mouseY - INVENTORY_START_Y

    -- 计算行和列
    local row = math.ceil(relativeY / CELL_HEIGHT)
    local col = math.ceil(relativeX / CELL_WIDTH)

    if row < 1 or row > INVENTORY_HEIGHT or col < 1 or col > INVENTORY_WIDTH then
        print("超过范围1")
        return
    end

    -- 计算实际的行列，调整为格子的左上角
    local adjustedRow = row - math.floor((item.gridWidth - 1) / 2)
    local adjustedCol = col - math.floor((item.gridHeight - 1) / 2)

    if adjustedRow < 1 or adjustedRow + item.gridWidth - 1 > INVENTORY_HEIGHT or 
       adjustedCol < 1 or adjustedCol + item.gridHeight - 1 > INVENTORY_WIDTH then
        print("超过范围2")
        return 
    end

    return adjustedRow, adjustedCol
end

function UIWndInventory:isMouseOverItem(mouseX, mouseY)
    local row, col = self:mouseToGridPos(mouseX, mouseY)
    if row < 1 or row > INVENTORY_HEIGHT or col < 1 or col > INVENTORY_WIDTH then
        return nil 
    end

    local item = self.grid[row][col]
    if item then
        for i = row, row + item.gridWidth - 1 do
            for j = col, col + item.gridHeight - 1 do
                if self.grid[i][j] == item then
                    return item 
                end
            end
        end
    end

    return nil
end

---鼠标放置物品
function UIWndInventory:mousePlaceItem(mouseX, mouseY)
    local item = self.selectedItem
    local row, col = self:calcGridPosByMouse(item, mouseX, mouseY)
    if self:canPlaceItem(item, row, col) then
        -- self:removeItem(item) --移动的时候就移除了
        self:addItem(item, row, col)
        self:setItemCenterPosition(item, row, col)
        return true
    else
        ---TODO 替换逻辑
        -- 目标格子有物品，判断是否可以替换
        -- if self:canReplaceItem(item, targetItem) then
        --     self:replaceItem(item, targetItem) -- 替换物品
        -- end
        return false
    end
end

--- 不能放，但是可以替换
function UIWndInventory:canReplaceByMousePos()
    return false
end

--------------replace
function UIWndInventory:canReplaceItem(newItem, existingItem)
    -- 在这里实现替换逻辑，比如检查新物品和旧物品的类型、大小等
    -- return newItem.type == existingItem.type -- 示例：根据类型判断是否可以替换
    return false
end

function UIWndInventory:replaceItem(newItem, existingItem)
    -- 在这里实现替换逻辑
    -- 例如，先移除现有物品，再放置新物品
    local row, col = self:findItemPosition(existingItem)
    self:removeItem(existingItem) -- 假设有一个移除物品的函数
    self:addItem(newItem, row, col) -- 放置新物品
end

function UIWndInventory:findItemPosition(item)
    -- 找到物品的位置并返回行和列
    for i = 1, INVENTORY_HEIGHT do
        for j = 1, INVENTORY_WIDTH do
            if self.grid[i][j] == item then
                return i, j
            end
        end
    end
    return nil, nil -- 如果没有找到
end

return UIWndInventory