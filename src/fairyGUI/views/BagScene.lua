--【背包场景】
local DemoScene = require("fairyGUI.views.DemoScene")

local BagScene = class("BagScene",  DemoScene)
local BagWindow = require("src.fairyGUI.views.window.BagWindow")
function BagScene:ctor()
    BagScene.super.ctor(self)
end

function BagScene:initVars()
    self._bagWindow = nil 
end

function BagScene:continueInit()
    fgui.UIPackage:addPackage("fairyGUIDemo/Bag")
    local _view = fgui.UIPackage:createObject("Bag", "Main")
    self._groot:addChild(_view)
    self._bagWindow = BagWindow:create();
    self._bagWindow:retain();
    _view:getChild("bagBtn"):addClickListener(function ()
        self._bagWindow:show()
    end);
end

function BagScene:onExit()
    print("BagScene:onExit()")
    CC_SAFE_RELEASE(self._bagWindow)
    fgui.UIPackage:removePackage("fairyGUIDemo/Bag")  -- 看项目需求，如果不经常使用的建议退出的时候移除包，避免内存长期占用问题
    BagScene.super.onExit(self)  --如果子类有实现onExit 请调用super.onExit(self) ；如果没有实现可以不添加onExit该方法
end

function BagScene:onEnter()
    print("BagScene:onEnter()")
end

function BagScene:onClear()
    print("BagScene:onClear()")
end

return BagScene