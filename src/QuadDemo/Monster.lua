---怪物
---@class Monster
local Monster = class("Monster",function()
    return display.newNode()
end)
table.merge(Monster,{
    x = 0, 
    y = 0, 
    width = 0, 
    height = 0,
    isAlive = true,
    tag = nil
})

function Monster:ctor(x, y)
    local monster = cc.Sprite:create("quanxinMap/images/monster.png")
    local size = monster:getContentSize()
    self:drawCocosRect(monster)
    self:addChild(monster)
    monster:setAnchorPoint(cc.p(0,0))
    self:setPosition(cc.p(x,y))

    self.tagText = ccui.Text:create()
    self.tagText:setFontSize(20)
    self.tagText:setPosition(cc.p(0, 0))
    self.tagText:setString("0")
    self:addChild(self.tagText)
    
    self.width = size.width 
    self.height = size.height
    self.x = x
    self.y = y

end
function Monster:clear()
    self:setVisible(false)
end

function Monster:addTag(index)
    self.tagText:setString(index)
    self.tag = index
end

--cocos 添加矩形
function Monster:drawCocosRect(obj, pos, size)
    if not pos then pos = cc.p(0, 0) end
    if not size then size = obj:getContentSize() end
    local drawNode = cc.DrawNode:create()
    drawNode:drawRect(pos, cc.p(size.width, size.height), cc.c4b(0x30/255, 0xCC/255, 0x00/255, 1))
    obj:addChild(drawNode)
end

return Monster