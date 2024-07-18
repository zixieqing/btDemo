local Player = class("Player", function()
    return display.newNode()
end)

function Player:ctor()
    self.player = cc.Sprite:create("quanxinMap/images/Player.png")
    -- self.player:setPosition(spawnPos)
    self:addChild(self.player)
end

function Player:setPosition(pos)
    self.player:setPosition(pos)
end
function Player:getPosition()
    return self.player:getPosition()
end

return Player