local Player = class("Player", function()
    return display.newNode()
end)

local AStar = import(".AStar")
function Player:ctor()
    self.player = cc.Sprite:create("quanxinMap/images/Player.png")

    self:addChild(self.player)
    self.baseDamge = 10
    self.hp = 100
    self.x = 0
    self.y = 0
end
function Player:initVars()
    self.cameFromPath = nil
end


--------------get/set------------------------
function Player:setPosition(pos)
    self.x = pos.x
    self.y = pos.y
    print("Player Pos", self.x, self.y)
    self.player:setPosition(pos)
end
function Player:getPosition()
    return self.player:getPosition()
end
function Player:getHP()
    return self.hp
end
function Player:setHP(hp)
    self.hp = hp
end
function Player:findPath(start, goal)
    if not self.cameFromPath then
        start = _g_scene.mapNode:cp2tp(start)
        goal = _g_scene.mapNode:cp2tp(goal)

        if _g_scene.mapNode:isBlock(goal) then 
            print("目标点为阻挡点，或已超过地图范围")
            return 
        end
        self.cameFromPath = AStar:findPath(_g_scene.mapNode, start, goal)
        self.curStep = start
    end
    print("下一步")
    for next, cur in self.cameFromPath:ripairs() do
        if cur.x == self.curStep.x and cur.y == self.curStep.y then
            self:setPosition(_g_scene.mapNode:tp2cp(next))
            self.curStep = next
            return 
        end
    end
end

function Player:attack()
    
end

function Player:getAckDamage()
    local criticalHit = math.random()
    return self.baseDamge * (1 + criticalHit)
end

return Player