local GameScene = class("GameScene", function()
    return display.newScene()
end)
local MapNode = import(".MapNode")
local Player = import(".Player")
local Monster = import(".Monster")
local AStar = import(".AStar")
local BTree = import(".BTree")

function GameScene:ctor()
    self:enableNodeEvents()
    -- performWithDelay(self, function()
        self:initVars()
        self:loadMap()
        self:loadPlayer()
        self:loadMonster()
        self:loadOtherUI()
        self:loadTree()
    -- end,0.5)
    _g_scene = self
end

function GameScene:initVars()
    self.mapNode = nil
    self.player = nil
    self.numCollected = 0
    self.scoreText = nil
    self.monsters = {}
    self.isOpenAI = false
end

----------------------------load UI ------------------------------

function GameScene:loadMap()
    self.mapNode = MapNode.new()
    self:addChild(self.mapNode, -1)
end

function GameScene:loadPlayer()
    self.player = Player.new(self)
    self:addChild(self.player)
    local spawnPoint = self.mapNode:getSpawnPoint()
    self.player:setPosition(spawnPoint)
end

function GameScene:loadMonster()
    local monsterCnt = 1
    for i = 1, monsterCnt do
        local monster = Monster.new()
        self:addChild(monster)
        monster:setPosition(cc.p(math.random(0,600),math.random(0,600)))
        table.insert(self.monsters,monster)
    end
end

function GameScene:loadOtherUI()
    self.scoreText = ccui.Text:create()
    self.scoreText:setFontSize(20)
    self.scoreText:setPosition(cc.p(display.cx, display.cy))
    self.scoreText:setString("分数：0")
    self:addChild(self.scoreText)

    self.touchLayer = cc.Layer:create()
    self:addChild(self.touchLayer)

    self.curPosText = ccui.Text:create()
    self.curPosText:setFontSize(20)
    self.curPosText:setPosition(cc.p(display.cx, display.height - 30))
    self.curPosText:setString("当前坐标：9,3")
    self:addChild(self.curPosText)

    self.destInput = ccui.EditBox:create(cc.size(100, 32), "quanxinMap/images/bg_black_gold.png",ccui.TextureResType.localType)
    self.destInput:setReturnType(cc.KEYBOARD_RETURNTYPE_SEND)
    self.destInput:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
    self.destInput:setPosition(cc.p(display.width - 100, display.height - 50))
    self:addChild(self.destInput)

    local goBtn = ccui.Button:create("quanxinMap/images/Common_Btn_02.png")
    goBtn:setTitleText("到目标点")
    goBtn:addClickEventListener(function()
        local playerPos = self.mapNode:cp2tp(cc.p(self.player:getPosition()))
        local goalPos = self:getGoalPos()
        local start = playerPos or cc.p(9, 3)
        local goal = goalPos or cc.p(11,8)
        self:findPath(start, goal)
    end)
    goBtn:setPosition(cc.p(display.width - 100, display.height - 100))
    self:addChild(goBtn)

    local heroAI = ccui.Button:create("quanxinMap/images/Common_Btn_02.png")
    heroAI:setTitleText("开启角色AI")
    heroAI:addClickEventListener(function()
        self.tree:setCtxTime(0)
        self.isOpenAI = not self.isOpenAI
        local title = self.isOpenAI == true and "关闭角色AI" or "开启角色AI"
        heroAI:setTitleText(title)
    end)
    heroAI:setPosition(cc.p(display.width - 100, display.height - 300))
    self:addChild(heroAI)


    ---line node
    local lineNode = cc.Node:create()
    lineNode:addTo(self)

    local drawNode = cc.DrawNode:create()
    lineNode:addChild(drawNode)

    self.lineNode = lineNode
    self.drawNode = drawNode
   
end

function GameScene:loadTree(...)
    local avatars = {hero = self.player, monster = self.monsters[1]}
    self.tree = BTree.new(avatars)
end

function GameScene:onEnter()
    self._touchListener = cc.EventListenerTouchOneByOne:create()
    self._touchListener:setEnabled(true)
    self._touchListener:setSwallowTouches(false)
    self._touchListener:registerScriptHandler(function(touch, event)
        return true
    end, cc.Handler.EVENT_TOUCH_BEGAN)
    self._touchListener:registerScriptHandler(function()
    end, cc.Handler.EVENT_TOUCH_MOVED)
    self._touchListener:registerScriptHandler(handler(self, self.onTouchEnded), cc.Handler.EVENT_TOUCH_ENDED)
    cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(self._touchListener, self.touchLayer)

    self:scheduleUpdateWithPriorityLua(handler(self, self.onUpdate), 0)

end

local acc = 0
function GameScene:onUpdate(dt)
   if self.isOpenAI then
        acc = acc + dt 
        if acc > 1 then
            acc = 0
            self.tree:setCtxTime(self.tree:getCtxTime() + 1)
            local ret = self.tree:getHeroTree():run()
            if ret == "SUCCESS" then
                print("TREE is RUN AROUND")
            end
        end
   end
end

function GameScene:onTouchEnded(touch, event)
    local touchLocation = touch:getLocation()
    touchLocation = self:convertToNodeSpace(touchLocation)
    local gridPos = self.mapNode:cp2tp(touchLocation)
    self.curPosText:setString(string.format("当前坐标:%s,%s",gridPos.x, gridPos.y))
    local playerPos = cc.p(self.player:getPosition())
    local diff = cc.pSub(touchLocation, playerPos)
    local tiledSize = self.mapNode:getTiledSize()
    local mapSize = self.mapNode:getMapSize()
    if math.abs(diff.x) > math.abs(diff.y) then --只能按格子走，横着竖着走，按照偏移来判断横着还是竖着走
        if diff.x > 0 then
            playerPos.x = playerPos.x + tiledSize.width
        else
            playerPos.x = playerPos.x - tiledSize.width
        end
    else
        if diff.y > 0 then
            playerPos.y = playerPos.y + tiledSize.height
        else
            playerPos.y = playerPos.y - tiledSize.height
        end
    end

    if playerPos.x <= (mapSize.width * tiledSize.width) and
       playerPos.y <= (mapSize.height * tiledSize.height) and
       playerPos.y >= 0 and
       playerPos.x >= 0 then
        self:setPlayerPosition(playerPos)
    end
    -- self:setViewpointCenter(cc.p(self.player:getPosition()))
end

function GameScene:setViewpointCenter(position)
    local winSize = cc.Director:getInstance():getWinSize()
    local x = math.max(position.x, winSize.width / 2)
    local y = math.max(position.y, winSize.height / 2)
    x = math.min(x, (self.mapNode:getMapSize().width * self.mapNode:getTiledSize().width) - winSize.width / 2)
    y = math.min(y, (self.mapNode:getMapSize().height * self.mapNode:getTiledSize().height) - winSize.height / 2)
    local actualPosition = cc.p(x, y)
    local centerOfView = cc.p(winSize.width / 2, winSize.height / 2)
    local viewPoint = cc.pSub(centerOfView, actualPosition)
    self:setPosition(viewPoint)
end

function GameScene:setPlayerPosition(position)
    local tiledPos = self.mapNode:cp2tp(position)
    local isBlock = self.mapNode:isBlock(tiledPos)
    if isBlock then return end
    local isUseFood =  self.mapNode:isUseFood(tiledPos)
    if isUseFood then
        self.mapNode:useFood(tiledPos)
        self.numCollected = self.numCollected + 1
        self.scoreText:setString("分数："..self.numCollected)
    end
    self.player:setPosition(position)
end

function GameScene:findPath(start, goal)
    if self.mapNode:isBlock(goal) then 
        print("目标点为阻挡点，或已超过地图范围")
        return 
    end
    local cameFromPath = AStar:findPath(self.mapNode, start, goal)
    self:drawPath(cameFromPath)
end

---画路径
function GameScene:drawPath(path)
    if table.nums(path) <= 1 then
        return
    end
    self.drawNode:clear()
    local i = 0
    local count = 0
    for next, pre in path:ripairs() do
        i = i + 1
        local start = self.mapNode:tp2cp(pre)
        local goal =  self.mapNode:tp2cp(next)
        self.drawNode:runAction(cc.Sequence:create(
            cc.DelayTime:create(i * 0.5),
            cc.CallFunc:create(function()
                self.drawNode:drawLine(start, goal, cc.c4f(1, 0, 0, 1))
                self.player:setPosition(goal)
                count = count + 1
                if count == path:length() then
                    self.drawNode:clear()
                end
            end)
        ))
    end
end

function GameScene:getGoalPos()
    if self.destInput:getText() == '' then
       return nil 
    end
    local goalStr = string.gsub(self.destInput:getText(), "，", ",")
    local input = string.split(goalStr,",")
    local goalPos = cc.p(tonumber(input[1]), tonumber(input[2]))
    return goalPos
end

return GameScene