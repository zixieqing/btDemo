MItem = {}
MItem.__index = MItem

-- 创建新物品的函数
function MItem.NewItem(itemClass)
    return s_NewItemClassTable[itemClass]()
end

-- 构造函数
function MItem:New()
    local instance = setmetatable({}, MItem)
    instance.m_ObjectType = TYPE_ITEM
    instance.m_Number = 1
    instance.m_ItemType = 0
    instance.m_bDropping = false
    instance.m_DropCount = 0
    instance.m_bIdentified = true
    instance.m_pName = nil
    instance.m_bAffectStatus = true
    instance.m_Silver = 0
    instance.m_Grade = -1
    instance.m_EnchantLevel = 0
    instance.m_Speed = 0
    instance.m_Quest = 0
    instance.m_ItemColorSet = 0xFFFF
    instance.m_persnal_price = -1
    instance.m_persnal = false
    return instance
end

-- 析构函数
function MItem:Destroy()
    if self.m_pName ~= nil then
        self.m_pName = nil
    end
end

-- 检查是否可以插入到另一个物品中
function MItem:IsInsertToItem(pItem)
    if pItem == nil then 
        return false 
    end

    if pItem:IsPileItem() and self:GetItemClass() == pItem:GetItemClass() and self:GetItemType() == pItem:GetItemType() then
        return true
    end

    return false
end

-- 获取物品名称
function MItem:GetName()
    if self.m_pName == nil then
        if g_pUserInformation.GoreLevel == false and self:GetItemClass() == ITEM_CLASS_SKULL then
            self.m_pName = string.format("%s %s", (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].HName, (*g_pGameStringTable)[STRING_MESSAGE_SOUL_STONE]:GetString())
            return self.m_pName
        end
        return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].HName
    end
    return self.m_pName
end

-- 获取英文名称
function MItem:GetEName()
    if g_pUserInformation.GoreLevel == false and self:GetItemClass() == ITEM_CLASS_SKULL then
        local sz_temp = (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].EName
        if string.find(sz_temp, "Head") or string.find(sz_temp, "Skull") then
            sz_temp = string.gsub(sz_temp, "Head", (*g_pGameStringTable)[STRING_MESSAGE_SOUL_STONE]:GetString())
            sz_temp = string.gsub(sz_temp, "Skull", (*g_pGameStringTable)[STRING_MESSAGE_SOUL_STONE]:GetString())
            return sz_temp
        end
    end
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].EName
end

-- 设置物品名称
function MItem:SetName(pName)
    if self.m_pName ~= nil then
        self.m_pName = nil
    end

    if pName == nil then
        return
    end

    self.m_pName = pName
end

-- 获取描述
function MItem:GetDescription()
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].Description
end

-- 获取重量
function MItem:GetWeight()
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].Weight
end

-- 获取价格
function MItem:GetPrice()
    local price
    if self:GetGrade() > 0 and self:GetGrade() <= 10 and self:IsGearItem() then
        price = (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].Price * (100 + (self:GetGrade() - 4) * 5) / 100
    else
        price = (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].Price
    end
    return price
end

-- 获取网格宽度
function MItem:GetGridWidth()
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].GridWidth
end

-- 获取网格高度
function MItem:GetGridHeight()
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].GridHeight
end

-- 获取瓷砖帧ID
function MItem:GetTileFrameID()
    if g_pUserInformation.GoreLevel == false and self:GetItemClass() == ITEM_CLASS_SKULL then
        return 271
    end
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].TileFrameID
end

-- 获取库存帧ID
function MItem:GetInventoryFrameID()
    if g_pUserInformation.GoreLevel == false and self:GetItemClass() == ITEM_CLASS_SKULL then
        return 285
    end
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].InventoryFrameID
end

-- 获取装备帧ID
function MItem:GetGearFrameID()
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].GearFrameID
end

-- 获取掉落帧ID
function MItem:GetDropFrameID()
    if self:GetItemClass() == ITEM_CLASS_EVENT_GIFT_BOX and self:GetItemType() == 2 then
        return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].DropFrameID
    end
    if g_pUserInformation.GoreLevel == false and self:GetItemClass() == ITEM_CLASS_SKULL then
        return 271
    end
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].DropFrameID
end

-- 获取男性附加帧ID
function MItem:GetAddonMaleFrameID()
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].AddonMaleFrameID
end

-- 获取女性附加帧ID
function MItem:GetAddonFemaleFrameID()
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].AddonFemaleFrameID
end

-- 获取使用音效ID
function MItem:GetUseSoundID()
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].UseSoundID
end

-- 获取瓷砖音效ID
function MItem:GetTileSoundID()
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].TileSoundID
end

-- 获取库存音效ID
function MItem:GetInventorySoundID()
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].InventorySoundID
end

-- 获取装备音效ID
function MItem:GetGearSoundID()
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].GearSoundID
end

-- 检查是否为男性
function MItem:IsGenderForMale()
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].IsGenderForMale()
end

-- 检查是否为女性
function MItem:IsGenderForFemale()
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].IsGenderForFemale()
end

-- 检查是否适用于所有性别
function MItem:IsGenderForAll()
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].IsGenderForAll()
end

-- 检查是否为任务物品
function MItem:IsQuestItem()
    if g_pTimeItemManager ~= nil and (g_pTimeItemManager:IsExist(self:GetID()) or self.m_Quest) then
        return 1
    end
    return 0
end

-- 检查是否为特殊颜色物品
function MItem:IsSpecialColorItem()
    return self:IsUniqueItem() or self:IsQuestItem()
end

return MItem
