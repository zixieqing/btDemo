local GameScene = class("GameScene", function()
    return display.newScene()
end)
local MapNode = import(".MapNode")
local Player = import(".Player")
-- import(".FindPath")
local AStar = import(".AStar")
local OrderMap = import(".third.OrderMap")

function GameScene:ctor()
    self:enableNodeEvents()
    performWithDelay(self, function()
        self:initVars()
        self:loadMap()
        self:loadPlayer()
        self:loadOtherUI()
    end,0.5)
    
end

function GameScene:initVars()
    self.mapNode = nil
    self.player = nil
    self.numCollected = 0
    self.scoreText = nil
    --test
    local orderMap = OrderMap:new()
    orderMap:set("9-3",cc.p(8,8))
    orderMap:set("9-4",cc.p(8,81))
    orderMap:set("9-3",cc.p(81,81))

    local a = orderMap:pairs()
    for k, v in orderMap:pairs() do
        print(k, v.x)
    end
end

----------------------------load UI ------------------------------

function GameScene:loadMap()
    self.mapNode = MapNode.new()
    self:addChild(self.mapNode, -1)
end

function GameScene:loadPlayer()
    self.player = Player.new()
    self:addChild(self.player)
    local spawnPoint = self.mapNode:getSpawnPoint()
    self.player:setPosition(spawnPoint)
end

function GameScene:loadOtherUI()
    self.scoreText = ccui.Text:create()
    self.scoreText:setFontSize(20)
    self.scoreText:setPosition(cc.p(display.cx, display.cy))
    self.scoreText:setString("分数：0")
    self:addChild(self.scoreText)

    self.goDestBtn = ccui.Button:create("quanxinMap/images/Common_Btn_02.png")
    self.goDestBtn:setTitleText("到目标点")
    self.goDestBtn:addClickEventListener(function()
        self:findPath()
    end)
    self.goDestBtn:setPosition(cc.p(display.width - 100, display.height - 100))
    self:addChild(self.goDestBtn)
end

function GameScene:onEnter()
    self._touchListener = cc.EventListenerTouchOneByOne:create()
    self._touchListener:setEnabled(true)
    self._touchListener:setSwallowTouches(true)
    self._touchListener:registerScriptHandler(function(touch, event)
        return true
    end, cc.Handler.EVENT_TOUCH_BEGAN)
    self._touchListener:registerScriptHandler(function()
    end, cc.Handler.EVENT_TOUCH_MOVED)
    self._touchListener:registerScriptHandler(handler(self, self.onTouchEnded), cc.Handler.EVENT_TOUCH_ENDED)
    cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(self._touchListener, self)
end

function GameScene:onUpdate()
   
end

function GameScene:onTouchEnded(touch, event)
    local touchLocation = touch:getLocation()
    touchLocation = self:convertToNodeSpace(touchLocation)

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
    self:setViewpointCenter(cc.p(self.player:getPosition()))
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
    local tiledPos = self.mapNode:tileCoordForPosition(position)
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

-- function GameScene:startFindPath()
--     local startX, startY = 2, 2
--     local endX, endY = 10, 10
--     local tileSize = self.mapNode:getTiledSize()
--     local grid = self.mapNode:getGrids()
--     -- 绘制寻路路径的函数
--     local function drawPath(map, path, tileSize)
--         local linePath = {}
--         for i, node in ipairs(path) do
--             local x = (node[1] - 1) * tileSize.width + tileSize.width / 2
--             local y = (node[2] - 1) * tileSize.height + tileSize.height / 2
--             table.insert(linePath, cc.p(x, y))
--         end

--         local drawNode = cc.DrawNode:create()
--         drawNode:drawSegments(linePath, 2, cc.c4f(1, 0, 0, 1)) -- 红色线条
--         map:addChild(drawNode)
--     end
--         -- 使用示例
--     local path = findPath(startX, startY, endX, endY, grid)
--     if path then
--         drawPath(self.mapNode, path, tileSize)
--     else
--         print("无法找到路径")
--     end
-- end

function GameScene:findPath()
 

    -- 创建一个节点用于绘制线条
    local lineNode = cc.Node:create()
    lineNode:addTo(self)

    -- 添加cc.DrawNode组件到lineNode节点上
    local drawNode = cc.DrawNode:create()
    lineNode:addChild(drawNode)

    -- -- 绘制一条线条
    -- local function drawLine()
    --     drawNode:clear()
    --     drawNode:drawLine(cc.p(100, 100), cc.p(300, 300), cc.c4f(1, 0, 0, 1)) -- 红色线条
    -- end

    -- -- 调用drawLine函数来绘制线条
    -- drawLine()


    local function drawPath(path)
        drawNode:clear()
    
        if #path <= 1 then
            return
        end
    
        for i = 1, #path - 1 do
            local start = path[i]
            local goal = path[i + 1]
            drawNode:drawLine(cc.p(start.x, start.y), cc.p(goal.x, goal.y), cc.c4f(1, 0, 0, 1)) -- 红色线条
        end
    end

    local cameFromPath = AStar:findPath(self.mapNode, cc.p(9, 3), cc.p(11,8))
    for k, v in pairs(cameFromPath) do
        local printkv = string.format("next:x-y:%s-%s pre:x:%s, y:%s",k.x, k.y,v.x,v.y)
        print(printkv)
    end
    drawPath(cameFromPath)

end

return GameScene