-- 获取文件工具实例
local fileUtils = cc.FileUtils:getInstance()

-- 添加资源搜索路径
fileUtils:addSearchPath("D:/forkGit/btDemo/res/shaderDemo/")

require "app.UiHelper"
local MainLayer = require "app.layer.MainLayer"

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    local layer = MainLayer.new()
    self:addChild(layer)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
