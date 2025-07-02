-- MItem.lua

MItem = {}
MItem.__index = MItem

-- 最大数量定义
MAX_FIRE_CRACKER_PILE_NUMBER = 9
MAX_POTION_PILE_NUMBER = 30
MAX_MAGAZINE_PILE_NUMBER = 20
MAX_EVENT_STAR_PILE_NUMBER = 50
MAX_MONEY_NUMBER = 100000000
MAX_SKULL_NUMBER = 9
MAX_WATER_NUMBER = 50
MAX_HOLY_WATER_NUMBER = 50
MAX_BOMB_MATERIAL_NUMBER = 20
MAX_BOMB_NUMBER = 20
MAX_MINE_NUMBER = 20
MAX_EFFECT_ITEM_NUMBER = 20
MAX_VAMPIRE_ETC_NUMBER = 20
MAX_SERUM_NUMBER = 30
MAX_RESURRECT_SCROLL_NUMBER = 9
MAX_MIXING_ITEM_NUMBER = 9
MAX_OUSTERS_GEM_NUMBER = 50
MAX_OUSTERS_LARVA_NUMBER = 30
MAX_MOON_CARD_NUMBER = 99
MAX_LUCKY_BAG_NUMBER = 50

-- 静态成员
MItem.s_bUseKorean = true
MItem.s_DropHeight = {36, 49, 64, 36, 16, 4}

-- 创建新物品的函数表
MItem.s_NewItemClassTable = {
    MMotorcycle.NewItem,
    MPotion.NewItem,
    MWater.NewItem,
    MHolyWater.NewItem,
    MMagazine.NewItem,
    MBombMaterial.NewItem,
    MItemETC.NewItem,
    MKey.NewItem,
    MRing.NewItem,
    MBracelet.NewItem,
    MNecklace.NewItem,
    MCoat.NewItem,
    MTrouser.NewItem,
    MShoes.NewItem,
    MSword.NewItem,
    MBlade.NewItem,
    MShield.NewItem,
    MCross.NewItem,
    MGlove.NewItem,
    MHelm.NewItem,
    MGunSG.NewItem,
    MGunSMG.NewItem,
    MGunAR.NewItem,
    MGunTR.NewItem,
    MBomb.NewItem,
    MMine.NewItem,
    MBelt.NewItem,
    MLearningItem.NewItem,
    MMoney.NewItem,
    MCorpse.NewItem,
    MVampireRing.NewItem,
    MVampireBracelet.NewItem,
    MVampireNecklace.NewItem,
    MVampireCoat.NewItem,
    MSkull.NewItem,
    MMace.NewItem,
    MSerum.NewItem,
    MVampireETC.NewItem,
    MSlayerPortalItem.NewItem,
    MVampirePortalItem.NewItem,
    MEventGiftBoxItem.NewItem,
    MEventStarItem.NewItem,
    MVampireEarRing.NewItem,
    MRelic.NewItem,
    MVampireWeapon.NewItem,
    MVampireAmulet.NewItem,
    MQuestItem.NewItem,
    MEventTreeItem.NewItem,
    MEventEtcItem.NewItem,
    MBloodBible.NewItem,
    MCastleSymbol.NewItem,
    MCoupleRing.NewItem,
    MVampireCoupleRing.NewItem,
    MEventItem.NewItem,
    MDyePotionItem.NewItem,
    MResurrectItem.NewItem,
    MMixingItem.NewItem,
    MOustersArmsBand.NewItem,
    MOustersBoots.NewItem,
    MOustersChakram.NewItem,
    MOustersCirclet.NewItem,
    MOustersCoat.NewItem,
    MOustersPendent.NewItem,
    MOustersRing.NewItem,
    MOustersStone.NewItem,
    MOustersWristlet.NewItem,
    MOustersLarva.NewItem,
    MOustersPupa.NewItem,
    MOustersComposMei.NewItem,
    MOustersSummonGem.NewItem,
    MEffectItem.NewItem,
    MCodeSheetItem.NewItem,
    MMoonCardItem.NewItem,
    MSweeperItem.NewItem,
    MPetItem.NewItem,
    MPetFood.NewItem,
    MPetEnchantItem.NewItem,
    MLuckyBag.NewItem,
    MSms_item.NewItem,
    MCoreZap.NewItem,
    MGQuestItem.NewItem,
    MTrapItem.NewItem,
    MBloodBibleSign.NewItem,
    MWarItem.NewItem,
    MCarryingReceiver.NewItem,
    MShoulderArmor.NewItem,
    MDermis.NewItem,
    MPersona.NewItem,
    MFascia.NewItem,
    MMitten.NewItem,
}

-- 创建新物品的函数
function MItem.NewItem(itemClass)
    return MItem.s_NewItemClassTable[itemClass]()
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
    if pItem == nil then return false end
    if pItem:IsPileItem() and self:GetItemClass() == pItem:GetItemClass() and self:GetItemType() == pItem:GetItemType() then
        return true
    end
    return false
end

-- 获取物品名称
function MItem:GetName()
    if self.m_pName == nil then
        return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].HName
    end
    return self.m_pName
end

-- 获取英文名称
function MItem:GetEName()
    if self.m_pName == nil then
        return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].EName
    end
    return self.m_pName
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

-- 获取掉落帧ID
function MItem:GetDropFrameID()
    if self:GetItemClass() == ITEM_CLASS_EVENT_GIFT_BOX and self:GetItemType() == 2 then
        return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].DropFrameID
    end
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].DropFrameID
end

-- 获取使用音效ID
function MItem:GetUseSoundID()
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].UseSoundID
end

-- 检查性别适用性
function MItem:IsGenderForMale()
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].IsGenderForMale()
end

function MItem:IsGenderForFemale()
    return (*g_pItemTable)[self:GetItemClass()][self.m_ItemType].IsGenderForFemale()
end

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

-- 获取最大数量（药水）
function MPotion:GetMaxNumber()
    return MAX_POTION_PILE_NUMBER
end

-- 获取最大数量（弹匣）
function MMagazine:GetMaxNumber()
    return MAX_MAGAZINE_PILE_NUMBER
end

-- 获取最大数量（钱）
function MMoney:GetMaxNumber()
    return MAX_MONEY_NUMBER
end

-- 使用物品
function MItem:UseInventory()
    -- 使用逻辑
end

-- 其他方法省略...

return MItem
