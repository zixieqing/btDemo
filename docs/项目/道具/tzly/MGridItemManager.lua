-- 背包格子管理器
---@class MGridItemManager
local MGridItemManager = class("MGridItemManager")
MGridItemManager.m_Width = 0
MGridItemManager.m_Height = 0
MGridItemManager.m_ItemGrid = nil

function MGridItemManager:ctor()

end

function MGridItemManager:Release()
    if self.m_ItemGrid ~= nil then
        for i = 1, self.m_Height do
            self.m_ItemGrid[i] = nil
        end
        self.m_ItemGrid = nil
        self.m_Width = 0
        self.m_Height = 0
    end
end

function MGridItemManager:Init(width, height)
    self:Release()

    if width ~= 0 and height ~= 0 then
        self.m_Width = width
        self.m_Height = height

        self.m_ItemGrid = {}
        for i = 1, self.m_Height do
            self.m_ItemGrid[i] = {}
            for j = 1, self.m_Width do
                self.m_ItemGrid[i][j] = nil
            end
        end
    end
end

function MGridItemManager:GetFitPosition(pItem, point)
    local width = pItem:GetGridWidth()
    local height = pItem:GetGridHeight()

    local yLimit = self.m_Height - height
    local xLimit = self.m_Width - width

    for x = 0, xLimit do
        for y = 0, yLimit do
            local bPlace = true

            for i = y, y + height - 1 do
                for j = x, x + width - 1 do
                    if self.m_ItemGrid[i + 1][j + 1] ~= nil then
                        bPlace = false
                        break
                    end
                end
            end
            
            if bPlace then
                point.x = x
                point.y = y
                return true
            end
        end
    end

    return false
end

function MGridItemManager:CanReplaceItem(pItem, x, y, pOldItem)
    pOldItem[1] = nil

    if x >= self.m_Width or y >= self.m_Height then
        return false
    end

    local width = pItem:GetGridWidth()
    local height = pItem:GetGridHeight()

    if x + width > self.m_Width or y + height > self.m_Height then
        return false
    end

    local pCheckItem = nil

    for i = y, y + height - 1 do
        for j = x, x + width - 1 do
            local pCurrentCheckItem = self.m_ItemGrid[i + 1][j + 1]
            if pCurrentCheckItem ~= nil then
                if pCheckItem == nil then
                    pCheckItem = pCurrentCheckItem
                else
                    if pCheckItem:GetID() ~= pCurrentCheckItem:GetID() then
                        return false
                    end
                end
            end
        end
    end

    pOldItem[1] = pCheckItem
    return true
end

function MGridItemManager:AddItem(pItem)
    local width = pItem:GetGridWidth()
    local height = pItem:GetGridHeight()

    local yLimit = self.m_Height - height
    local xLimit = self.m_Width - width

    for x = 0, xLimit do
        for y = 0, yLimit do
            local bPlace = true

            for i = y, y + height - 1 do
                for j = x, x + width - 1 do
                    if self.m_ItemGrid[i + 1][j + 1] ~= nil then
                        bPlace = false
                        y = i + height - 1
                        break
                    end
                end
            end
            
            if bPlace then
                if MItemManager:AddItem(pItem) then
                    pItem:SetGridXY(x, y)

                    for i = y, y + height - 1 do
                        for j = x, x + width - 1 do
                            self.m_ItemGrid[i + 1][j + 1] = pItem
                        end
                    end

                    return true
                end
            end
        end
    end

    return false
end

function MGridItemManager:AddItemAt(pItem, x, y)
    if x >= self.m_Width or y >= self.m_Height then
        return false
    end

    local width = pItem:GetGridWidth()
    local height = pItem:GetGridHeight()

    if x + width > self.m_Width or y + height > self.m_Height then
        return false
    end

    for i = y, y + height - 1 do
        for j = x, x + width - 1 do
            if self.m_ItemGrid[i + 1][j + 1] ~= nil then
                return false
            end
        end
    end

    if MItemManager:AddItem(pItem) then
        pItem:SetGridXY(x, y)

        for i = y, y + height - 1 do
            for j = x, x + width - 1 do
                self.m_ItemGrid[i + 1][j + 1] = pItem
            end
        end

        return true
    end

    return false
end

function MGridItemManager:GetItem(x, y)
    if x >= self.m_Width or y >= self.m_Height then
        return nil
    end
    return self.m_ItemGrid[y + 1][x + 1]
end

function MGridItemManager:RemoveItem(x, y)
    if x >= self.m_Width or y >= self.m_Height then
        return nil
    end

    local pItem = self.m_ItemGrid[y + 1][x + 1]

    if pItem == nil then
        return nil
    end

    pItem = MItemManager:RemoveItem(pItem:GetID())

    if pItem == nil then
        return nil
    end

    local x = pItem:GetGridX()
    local y = pItem:GetGridY()
    local width = pItem:GetGridWidth()
    local height = pItem:GetGridHeight()

    for i = y, y + height - 1 do
        for j = x, x + width - 1 do
            self.m_ItemGrid[i + 1][j + 1] = nil
        end
    end

    return pItem
end

function MGridItemManager:RemoveItemById(id)
    local pItem = MItemManager:RemoveItem(id)

    if pItem == nil then
        return nil
    end

    local x = pItem:GetGridX()
    local y = pItem:GetGridY()
    local width = pItem:GetGridWidth()
    local height = pItem:GetGridHeight()

    for i = y, y + height - 1 do
        for j = x, x + width - 1 do
            self.m_ItemGrid[i + 1][j + 1] = nil
        end
    end

    return pItem
end

function MGridItemManager:ReplaceItem(pItem, x, y, pOldItem)
    pOldItem[1] = nil

    if x >= self.m_Width or y >= self.m_Height then
        return false
    end

    local width = pItem:GetGridWidth()
    local height = pItem:GetGridHeight()

    if x + width > self.m_Width or y + height > self.m_Height then
        return false
    end

    local pCheckItem = nil

    for i = y, y + height - 1 do
        for j = x, x + width - 1 do
            local pCurrentCheckItem = self.m_ItemGrid[i + 1][j + 1]
            if pCurrentCheckItem ~= nil then
                if pCheckItem == nil then
                    pCheckItem = pCurrentCheckItem
                else
                    if pCheckItem:GetID() ~= pCurrentCheckItem:GetID() then
                        return false
                    end
                end
            end
        end
    end

    if pCheckItem ~= nil then
        if MItemManager:RemoveItem(pCheckItem:GetID()) == nil then
            return false
        end

        local ox = pCheckItem:GetGridX()
        local oy = pCheckItem:GetGridY()
        local owidth = pCheckItem:GetGridWidth()
        local oheight = pCheckItem:GetGridHeight()

        for i = oy, oy + oheight - 1 do
            for j = ox, ox + owidth - 1 do
                self.m_ItemGrid[i + 1][j + 1] = nil
            end
        end

        pOldItem[1] = pCheckItem
    end

    if MItemManager:AddItem(pItem) then
        pItem:SetGridXY(x, y)

        for i = y, y + height - 1 do
            for j = x, x + width - 1 do
                self.m_ItemGrid[i + 1][j + 1] = pItem
            end
        end
    end

    return true
end

function MGridItemManager:FindItemGridOrder(itemFinder)
    local bCheck = {}
    for i = 1, self.m_Height do
        bCheck[i] = {}
        for j = 1, self.m_Width do
            bCheck[i][j] = false
        end
    end

    for y = 0, self.m_Height - 1 do
        for x = 0, self.m_Width - 1 do
            if bCheck[y + 1][x + 1] then
                goto continue
            end

            local pItem = self.m_ItemGrid[y + 1][x + 1]
            if pItem ~= nil then
                if itemFinder(pItem) then
                    return pItem
                end

                local maxY = y + pItem:GetGridHeight()
                local maxX = x + pItem:GetGridWidth()

                for i = y, maxY - 1 do
                    for j = x, maxX - 1 do
                        bCheck[i + 1][j + 1] = true
                    end
                end
            end
            ::continue::
        end
    end

    return nil
end

return MGridItemManager
