--【模板场景】 用于快速生成模板
local DemoScene = require("fairyGUI.views.DemoScene")
local TemplateScene = class("TemplateScene",  DemoScene)

function TemplateScene:ctor()
    TemplateScene.super.ctor(self)
end

function TemplateScene:initVars()
    
end

function TemplateScene:continueInit()
    fgui.UIPackage:addPackage("fairyGUIDemo/Bag")
    local _view = fgui.UIPackage:createObject("Bag", "Main")
    self._groot:addChild(_view)
    
end

function TemplateScene:onExit()
    print("TemplateScene:onExit()")
    fgui.UIPackage:removePackage("fairyGUIDemo/Bag") 
    TemplateScene.super.onExit(self)  
end

function TemplateScene:onEnter()
    print("TemplateScene:onEnter()")
end

function TemplateScene:onClear()
    print("TemplateScene:onClear()")
end

return TemplateScene