local mapScene = class("mapScene", function()
    return display.newScene()
end)

function mapScene:ctor()

    self.numCollected = 0
    self:enableNodeEvents()
    self.isTouchEnabled = true
    self.scoreText = ccui.Text:create()
    self.scoreText:setFontSize(20)
    self.scoreText:setPosition(cc.p(display.cx, display.cy))
    self.scoreText:setString("分数：0")


    self:addChild(self.scoreText)
    print("enterMapScene")
    performWithDelay(self, function()
        self:initMap()
    end,0.5)
end

function mapScene:initMap()

    self.tileMap = cc.TMXTiledMap:create("quanxinMap/quanxin.tmx")
    self:addChild(self.tileMap, -1)

    local objects = self.tileMap:getObjectGroup("Objects")
    local spawnPoints = objects:getObject("spawnPoint")
    local spawnPos = cc.p(spawnPoints["x"], spawnPoints["y"])
    self.player = cc.Sprite:create("quanxinMap/images/Player.png")
    self.player:setPosition(spawnPos)
    self:addChild(self.player)

    self.foods = self.tileMap:getLayer("food")
    self.blocks = self.tileMap:getLayer("block")

   
    self:setViewpointCenter(spawnPos)
end

function mapScene:setViewpointCenter(position)
    local winSize = cc.Director:getInstance():getWinSize()
    local x = math.max(position.x, winSize.width / 2)
    local y = math.max(position.y, winSize.height / 2)
    x = math.min(x, (self.tileMap:getMapSize().width * self.tileMap:getTileSize().width) - winSize.width / 2)
    y = math.min(y, (self.tileMap:getMapSize().height * self.tileMap:getTileSize().height) - winSize.height / 2)
    local actualPosition = cc.p(x, y)
    local centerOfView = cc.p(winSize.width / 2, winSize.height / 2)
    local viewPoint = cc.pSub(centerOfView, actualPosition)
    self:setPosition(viewPoint)
end

function mapScene:onEnter()
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

function mapScene:onTouchEnded(touch, event)
    local touchLocation = touch:getLocation()
    touchLocation = self:convertToNodeSpace(touchLocation)

    local playerPos = cc.p(self.player:getPosition())
    local diff = cc.pSub(touchLocation, playerPos)
    if math.abs(diff.x) > math.abs(diff.y) then
        if diff.x > 0 then
            playerPos.x = playerPos.x + self.tileMap:getTileSize().width
        else
            playerPos.x = playerPos.x - self.tileMap:getTileSize().width
        end
    else
        if diff.y > 0 then
            playerPos.y = playerPos.y + self.tileMap:getTileSize().height
        else
            playerPos.y = playerPos.y - self.tileMap:getTileSize().height
        end
    end

    if playerPos.x <= (self.tileMap:getMapSize().width * self.tileMap:getTileSize().width) and
       playerPos.y <= (self.tileMap:getMapSize().height * self.tileMap:getTileSize().height) and
       playerPos.y >= 0 and
       playerPos.x >= 0 then
        self:setPlayerPosition(playerPos)
    end

    self:setViewpointCenter(cc.p(self.player:getPosition()))
end

function mapScene:setPlayerPosition(position)
    local tileCoord = self:tileCoordForPosition(position)
    local tileGid = self.blocks:getTileGIDAt(tileCoord)
    if tileGid > 0 then
        -- local properties = self.tileMap:getPropertiesForGID(tileGid) -- 这个获取不到信息
        local properties = self.blocks:getProperties()
        if properties then
            local collision = properties["isBlock"]
            if collision and collision == "true" then
                print("遇到了阻挡")
                return
            end
        end
    end
    local foodGid = self.foods:getTileGIDAt(tileCoord)
    if foodGid > 0 then
        -- local properties = self.tileMap:getPropertiesForGID(foodGid)-- 这个获取不到信息
        local properties = self.foods:getProperties()
        local collectable = properties["isFood"]
        if collectable and collectable == "true" then
            self.foods:removeTileAt(tileCoord)
            self.numCollected = self.numCollected + 1
            self.scoreText:setString("分数："..self.numCollected)
        end     
    end
    self.player:setPosition(position)
end

function mapScene:tileCoordForPosition(position)
    local x = math.floor(position.x / self.tileMap:getTileSize().width)
    local y = math.floor((self.tileMap:getMapSize().height * self.tileMap:getTileSize().height - position.y) / self.tileMap:getTileSize().height)
    return cc.p(x, y)
end

return mapScene