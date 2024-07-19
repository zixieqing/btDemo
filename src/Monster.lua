local Monster = class("Monster", function()
    return display.newNode()
end)

function Monster:ctor()
    self.monster = cc.Sprite:create("quanxinMap/images/monster.png")
    -- self.player:setPosition(spawnPos)
    self:addChild(self.monster)
    self.x = 0
    self.y = 0
    self.hp = 100
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



return Monster