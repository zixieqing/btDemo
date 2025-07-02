-- 【圆形进度条】
local DemoScene = require("fairyGUI.views.DemoScene")

local CooldownScene = class("CooldownScene", DemoScene)

function CooldownScene:ctor()
    CooldownScene.super.ctor(self)
end

function CooldownScene:initVars()
    
end

function CooldownScene:continueInit()
    fgui.UIPackage:addPackage("fairyGUIDemo/Cooldown")
    local _view = fgui.UIPackage:createObject("Cooldown", "Main")
    self._groot:addChild(_view)

    local btn0 = _view:getChild("b0");
    local btn1 = _view:getChild("b1");
    btn0:getChild("icon"):setIcon("icons/k0.png");
    btn1:getChild("icon"):setIcon("icons/k1.png");

    fgui.GTween:to(0, 100, 5):setTarget(btn0, fgui.TweenPropType.Progress):setRepeat(-1);
    fgui.GTween:to(10, 0, 10):setTarget(btn1, fgui.TweenPropType.Progress):setRepeat(-1);
end

function CooldownScene:onExit()
    print("CooldownScene:onExit()")
    fgui.UIPackage:removePackage("fairyGUIDemo/Cooldown")
    CooldownScene.super.onExit(self)
end

function CooldownScene:onEnter()
    print("CooldownScene:onEnter()")
end

function CooldownScene:onClear()
    print("CooldownScene:onClear()")
end

return CooldownScene