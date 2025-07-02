-- 物品管理器
---@class MItemManager
local MItemManager = class("MItemManager")
MItemManager.m_mapItem = {}

function MItemManager:ctor()
  
end

function MItemManager:Destroy()
    self:Release()
end

-- 释放所有物品
function MItemManager:Release()
    for id, pItem in pairs(self.m_mapItem) do
        pItem:Destroy()  -- 假设 MItem 有 Destroy 方法
        self.m_mapItem[id] = nil
    end
    self.m_mapItem = {}
end

-- 添加物品
function MItemManager:AddItem(pItem)
    local id = pItem:GetID()
    
    if self.m_mapItem[id] == nil then
        self.m_mapItem[id] = pItem
        self:CheckAffectStatus(pItem)
        return true
    end
    
    return false
end

-- 获取可修改的物品
function MItemManager:GetItemToModify(id)
    return self.m_mapItem[id] or nil
end

-- 获取物品
function MItemManager:GetItem(id)
    return self.m_mapItem[id] or nil
end

-- 移除物品
function MItemManager:RemoveItem(id)
    local pItem = self.m_mapItem[id]
    
    if pItem == nil then
        return nil
    end
    
    self.m_mapItem[id] = nil
    self:CheckAffectStatusAll()
    
    return pItem
end

-- 检查所有物品的状态
function MItemManager:CheckAffectStatusAll()
    for id, pItem in pairs(self.m_mapItem) do
        self:CheckAffectStatus(pItem)
    end
end

-- 检查单个物品的状态
function MItemManager:CheckAffectStatus(pItem)
    -- 具体逻辑待实现
end

-- 查找物品
function MItemManager:FindItem(itemFinder)
    for id, pItem in pairs(self.m_mapItem) do
        if itemFinder(pItem) then
            return pItem
        end
    end
    return nil
end

-- 查找所有物品
function MItemManager:FindItemAll(itemFinder, pSubInventoryItem)
    for id, pItem in pairs(self.m_mapItem) do
        if itemFinder(pItem) then
            return pItem
        elseif pItem:GetItemClass() == ITEM_CLASS_SUB_INVENTORY then
            local pTempItem = pItem:FindItem(itemFinder)  -- 假设 MSubInventory 有 FindItem 方法
            if pTempItem then
                pSubInventoryItem = pItem
                return pTempItem
            end
        end
    end
    return nil
end

return MItemManager
  