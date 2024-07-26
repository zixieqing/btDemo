--- 用于测试一颗子弹穿过一万只怪物，使用四叉树来做处理,子弹穿过怪物，怪物销毁
---@class BulletScene 
local BulletScene = class("BulletScene",function()
    return display.newScene()
end)

local Monster = import('.Monster')
local Bullet = import('.Bullet')
local QuadTree = import(".spacePartition.QuadTree")

local MONSTER_CNT = 50

function BulletScene:ctor()
    self:enableNodeEvents()
    self.bullets = {}
    self.monsters = {}
    self.quadTree = QuadTree:new(0, 0, display.width, display.height)
    self:createMonser()
    self.drawNode = cc.DrawNode:create()
    self:addChild(self.drawNode)

    local sendBullect = ccui.Button:create("quanxinMap/images/Common_Btn_02.png")
    sendBullect:setTitleText("发射子弹")
    sendBullect:addClickEventListener(function()
        self:spawnBullet()
    end)
    sendBullect:setPosition(cc.p(display.width - 100, display.height - 100))
    self:addChild(sendBullect)
end

function BulletScene:onEnter()
    self:scheduleUpdateWithPriorityLua(handler(self, self.onUpdate), 0)
end

function BulletScene:createMonser()
    math.randomseed(os.time())
    for i = 1, MONSTER_CNT do
        local x, y = math.random(0, display.width), math.random(0, display.height)
        local monster = Monster.new(x,y)
        self:addChild(monster)
        monster:addTag(i)
        table.insert(self.monsters, monster)
    end
end

local timeSinceLastBullet = 0
function BulletScene:onUpdate(dt)
    timeSinceLastBullet = timeSinceLastBullet + dt
    if timeSinceLastBullet > 1 then
        -- self:spawnBullet()
        self:check(dt)
        timeSinceLastBullet = 0
    end
    -- self:check(dt)

end


function BulletScene:check(dt)
    -- 清空四叉树中的对象
    self.quadTree = QuadTree:new(0, 0, display.width, display.height)
    -- 插入怪物到四叉树
    for _, monster in ipairs(self.monsters) do
        if monster.isAlive then
            self.quadTree:insert(monster)
        end
    end
    self.quadTree:draw(self.drawNode)

    -- 更新子弹
    for i = #self.bullets, 1, -1 do
        local bullet = self.bullets[i]
        bullet:update(dt)

        -- 检查是否超出视野
        if bullet.x < 0 or bullet.x > display.width or bullet.y < 0 or bullet.y > display.height then
            table.remove(self.bullets, i)
            bullet:clear()
        else
            -- 检测碰撞
            local potentialTargets = {}
            self.quadTree:retrieve(potentialTargets, bullet) --四叉树的作用，就是帮忙，从1000个里筛选出区域里的
            print("筛选出",#potentialTargets)
            local filter = {}
            for _, monster in ipairs(potentialTargets) do
                table.insert(filter,monster.tag)
            end 
            print("筛选的怪物名单：",table.concat(filter,"-"))
            for _, monster in ipairs(potentialTargets) do
                -- if monster.isAlive and bullet.x < monster.x + monster.width and
                --     bullet.x + bullet.width > monster.x and
                --     bullet.y < monster.y + monster.height and
                --     bullet.y + bullet.height > monster.y then
                local isCollision = cc.rectIntersectsRect(cc.rect(monster.x, monster.y, monster.width, monster.height), cc.rect(bullet.x, bullet.y, bullet.width, bullet.height))

                if monster.isAlive and isCollision then

                    monster.isAlive = false -- 杀死怪物
                    monster:clear()
                    -- table.remove(self.bullets, i) -- 子弹销毁
                    -- bullet:clear()
                    break
                end
            end
        end
    end
end

function BulletScene:spawnBullet()
    local angle = math.random() * 2 * math.pi
    local bullet = Bullet.new(400, 300, angle)
    self:addChild(bullet)
    table.insert(self.bullets, bullet)
end


return BulletScene