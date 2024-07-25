local Monster = class("Monster", function()
    return display.newNode()
end)
local HPNode = import(".HPNode")

function Monster:ctor()
    self.monster = cc.Sprite:create("quanxinMap/images/monster.png")
    -- self.player:setPosition(spawnPos)
    self:addChild(self.monster)
    self.x = 0
    self.y = 0
    self.hp = 100

    self:createHPNode()
end

function Monster:createHPNode()
    local hpNode = HPNode.new()
    self.monster:addChild(hpNode)
    local size = self.monster:getContentSize()
    hpNode:setPosition(cc.p(size.width/2, size.height))
    self.hpNode = hpNode
end

function Monster:setPosition(pos)
    self.x = pos.x
    self.y = pos.y
    print("Monster Pos", self.x, self.y)
    self.monster:setPosition(pos)
end

function Monster:getPosition()
    return self.monster:getPosition()
end

function Monster:takeDamage(damage)
    self.hp = self.hp - damage
    self.hpNode:reduceHP(self.hp)
end

function Monster:dead()
    self:removeFromParent()
end

return Monster