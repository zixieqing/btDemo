-- 【像素点击测试场景】
local DemoScene = require("fairyGUI.views.DemoScene")

local HitTestScene = class("HitTestScene", DemoScene)

function HitTestScene:ctor()
    HitTestScene.super.ctor(self)
end

function HitTestScene:initVars()
    
end

function HitTestScene:continueInit()
    fgui.UIPackage:addPackage("fairyGUIDemo/HitTest")
    local _view = fgui.UIPackage:createObject("HitTest", "Main")
    self._groot:addChild(_view)
end

function HitTestScene:onExit()
    print("HitTestScene:onExit()")
    fgui.UIPackage:removePackage("fairyGUIDemo/HitTest")
    HitTestScene.super.onExit(self)
end

function HitTestScene:onEnter()
    print("HitTestScene:onEnter()")
end

function HitTestScene:onClear()
    print("HitTestScene:onClear()")
end

return HitTestScene