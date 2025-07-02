```lua
function UIWndInventory:createTiled(gridX, gridY)
    if self.tiledMap and self.tiledMap[gridX .. "_" .. gridY] then
        self.tiledMap[gridX .. "_" .. gridY]:setVisible(true)
    else
        local tiled = fgui.UIPackage:createObject("Inventory", "inventoryslayer_2")
        local centerPos = self.gridManger:getTiledCenterXY(gridX, gridY, 1, 1)
        
        tiled:setPivot(0.5, 0.5, true)
        -- tiled:setSortingOrder(TITLED_ZOERDER)
        self:addChild(tiled)
        tiled:setPosition(centerPos.x, centerPos.y)
    
        if not self.tiledMap then
            self.tiledMap = {} 
        end
        self.tiledMap[gridX .. "_" .. gridY] = tiled
    end
end

function UIWndInventory:removeTiled(gridX, gridY)
    if self.tiledMap and self.tiledMap[gridX .. "_" .. gridY] then
        local tiled = self.tiledMap[gridX .. "_" .. gridY]
        tiled:setVisible(false) 
        tiled:removeFromParent()
        -- self.tiledMap[gridX .. "_" .. gridY] = nil
    end
end
```