
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"
local shaderScene = require("app.scenes.MainScene")
-- local shaderScene = require("fairyGUI.views.MenuScene").new()

local function main()
    local initScene = shaderScene.new()
    display.runScene(initScene)
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end


