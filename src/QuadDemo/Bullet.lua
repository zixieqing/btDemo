---子弹
---@class Bullet
local Bullet = class("Bullet",function()
    return display.newNode()
end)
table.merge(Bullet,{
    x = 0, 
    y = 0, 
    width = 0, 
    height = 0,
    isAlive = false,
})

function Bullet:ctor(x, y, angle)
    local bullet = cc.Sprite:create("quanxinMap/images/bullet.png")
    bullet:setAnchorPoint(cc.p(0,0))
    local size = bullet:getContentSize()
    self:addChild(bullet)
    self:setPosition(cc.p(x,y))
    self:drawCocosRect(bullet)

    self.width = size.width 
    self.height = size.height
    self.x = x
    self.y = y
    self.angle = angle
    self.isAlive = true

end

function Bullet:clear()
    self:setVisible(false)
    self:removeFromParent()
end

function Bullet:update(dt)
    self.x = self.x + math.cos(self.angle) * 10 
    self.y = self.y + math.sin(self.angle) * 10
    self:setPosition(cc.p(self.x, self.y))
end


--cocos 添加矩形
function Bullet:drawCocosRect(obj, pos, size)
    if not pos then pos = cc.p(0, 0) end
    if not size then size = obj:getContentSize() end
    local drawNode = cc.DrawNode:create()
    drawNode:drawRect(pos, cc.p(size.width, size.height), cc.c4b(0x30/255, 0xCC/255, 0x00/255, 1))
    obj:addChild(drawNode)
end



return Bullet