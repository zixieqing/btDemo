--[[

[ 类别层级 ]

ITEM  // 所有物品的基类
  - BELT  // 腰带类物品
  - MOTORCYCLE  // 摩托车类物品
  - CORPSE  // 尸体类物品

  - PILE_ITEM  // 可堆叠物品类
    - POTION  // 药水类物品
    - MAGAZINE  // 弹药类物品

  - GEAR_ITEM  // 装备类物品
    - RING  // 戒指
    - BRACELET  // 手镯
    - NECKLACE  // 项链
    - SHOES  // 鞋子
    - SWORD  // 剑
    - BLADE  // 刀片
    - SHIELD  // 盾牌
    - CROSS  // 十字架
    - GLOVE  // 手套
    - HELM  // 头盔
    - GUN_SG  // 霰弹枪
    - GUN_SMG  // 冲锋枪
    - GUN_AR  // 突击步枪
    - GUN_TR  // 其他类型的枪

  - WATER  // 水类物品
  - HOLYWATER  // 圣水类物品
  - ETC  // 其他物品
  - MOTORCYCLE(-I)  // 摩托车(-I) 特殊标记
  - KEY(+V)  // 钥匙(+V) 特殊标记
  - BELT  // 腰带
  - BOMB_MATERIAL  // 炸弹材料
  - LEARNINGITEM  // 学习类物品
  - MONEY(+V)  // 钱(+V) 特殊标记
  - BOMB  // 炸弹
  - MINE  // 地雷

  - VAMPIRE_ITEM(+V)  // 吸血鬼类物品(+V) 特殊标记
    - VAMPIRE_GEAR_ITEM  // 吸血鬼装备类物品
      - VAMPIRE_EARRING  // 吸血鬼耳环
      - VAMPIRE_RING  // 吸血鬼戒指
      - VAMPIRE_BRACELET  // 吸血鬼手镯
      - VAMPIRE_NECKLACE  // 吸血鬼项链
      - VAMPIRE_COAT  // 吸血鬼外套
      - VAMPIRE_SHOES  // 吸血鬼鞋子
]]

-- MItem.lua
---@class MItem
local MItem = class("MItem")

-- 静态成员
MItem.s_bUseKorean = true
MItem.s_DropHeight = {36, 49, 64, 36, 16, 4}


-- 创建新物品的函数
function MItem.NewItem(itemClass)
    return MItem.s_NewItemClassTable[itemClass]()
end

-- 构造函数
function MItem:New()
    local instance = setmetatable({}, MItem)
    instance.m_ObjectType = TYPE_ITEM               -- 对象类型设为物品
    instance.m_Number = 1                           -- 初始数量为1
    instance.m_ItemType = 0                         -- 物品类型（默认为0，表示未设置）
    instance.m_bDropping = false                    -- 是否正在掉落中
    instance.m_DropCount = 0                        -- 当前掉落计数
    instance.m_bIdentified = true                   -- 是否已识别物品
    instance.m_pName = nil                          -- 物品名称（未设置）
    instance.m_bAffectStatus = true                 -- 是否影响状态
    instance.m_Silver = 0                           -- 银币数量（初始为0）
    instance.m_Grade = -1                           -- 物品等级（未设置，默认为-1）
    instance.m_EnchantLevel = 0                     -- 附魔等级（初始为0）
    instance.m_Speed = 0                            -- 速度（初始为0）
    instance.m_Quest = 0                            -- 任务标识（初始为0）
    instance.m_ItemColorSet = 0xFFFF                -- 物品颜色设置（初始为白色）
    instance.m_persnal_price = -1                   -- 个人价格（未设置，默认为-1）
    instance.m_persnal = false                      -- 是否为个人物品（默认为false）
    
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
