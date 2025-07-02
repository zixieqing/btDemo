-- MInventory.lua

local MInventory = {}
MInventory.__index = MInventory

-- 全局变量
g_pInventory = nil

-- 构造函数
function MInventory:new()
    local instance = setmetatable({}, MInventory)
    return instance
end

-- 析构函数
function MInventory:destroy()
    -- 这里可以添加清理逻辑
end

-- 检查物品状态
function MInventory:CheckAffectStatus(pItem)
    -- 在客户端环境中检查物品状态
    if __GAME_CLIENT__ then
        g_pPlayer:CheckAffectStatus(pItem)
    end
end

-- 添加物品 (pItem)
function MInventory:AddItem(pItem)
    if pItem:IsInventoryItem() then
        if MGridItemManager:AddItem(pItem) then
            -- 添加成功，播放音效
            if __GAME_CLIENT__ then
                PlaySound(pItem:GetInventorySoundID())
            end
            return true
        end
        return false
    end
    return false
end

-- 添加物品 (pItem, x, y)
function MInventory:AddItemAt(pItem, x, y)
    if pItem:IsInventoryItem() then
        if MGridItemManager:AddItem(pItem, x, y) then
            -- 添加成功，播放音效
            if __GAME_CLIENT__ then
                PlaySound(pItem:GetInventorySoundID())
            end
            return true
        end
        return false
    end
    return false
end

-- 替换物品 (pItem, x, y, pOldItem)
function MInventory:ReplaceItem(pItem, x, y, pOldItem)
    if pItem:IsInventoryItem() then
        if MGridItemManager:ReplaceItem(pItem, x, y, pOldItem) then
            -- 添加成功，播放音效
            if __GAME_CLIENT__ then
                PlaySound(pItem:GetInventorySoundID())
            end
            return true
        end
        return false
    end
    return false
end

-- 获取合适位置 (pItem, point)
function MInventory:GetFitPosition(pItem, point)
    -- 只检查可叠加的物品
    if pItem:IsPileItem() then
        for _, inventoryItem in pairs(m_mapItem) do
            -- 检查叠加条件
            if inventoryItem:GetItemClass() == pItem:GetItemClass() and
               inventoryItem:GetItemType() == pItem:GetItemType() and
               (inventoryItem:GetNumber() + pItem:GetNumber() <= pItem:GetMaxNumber()) and
               not inventoryItem:IsQuestItem() then
                point.x = inventoryItem:GetGridX()
                point.y = inventoryItem:GetGridY()
                return true
            end
        end
    end
    return MGridItemManager:GetFitPosition(pItem, point)
end

-- 查找物品 (itemClass, itemType)
function MInventory:FindItem(itemClass, itemType)
    for _, pItem in pairs(m_mapItem) do
        -- 如果未指定类型，只根据类别查找
        if itemType == ITEMTYPE_NULL then
            if pItem:GetItemClass() == itemClass then
                return pItem
            end
        else
            -- 根据类别和类型查找
            if pItem:GetItemClass() == itemClass and pItem:GetItemType() == itemType then
                return pItem
            end
        end
    end
    return nil
end

return MInventory
