local HPNode = class("HPNode", function()
    return display.newNode()
end)
function HPNode:ctor()
    -- 创建一个进度条背景
    local healthBarBackground = display.newSprite("quanxinMap/images/img_hp_bg.png")
    self:addChild(healthBarBackground)

    -- 创建一个进度条
    local healthBar = cc.ProgressTimer:create(display.newSprite("quanxinMap/images/img_hp_red.png"))
    healthBar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    healthBar:setMidpoint(cc.p(0, 0))
    healthBar:setBarChangeRate(cc.p(1, 0))
    healthBar:setPercentage(100)  -- 初始血量100%
    self:addChild(healthBar)
    self.healthBar = healthBar

end

function HPNode:reduceHP(currentPercentage)
    self.healthBar:setPercentage(currentPercentage)
end

return HPNode