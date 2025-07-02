--【入口面板】
local DemoScene = require("fairyGUI.views.DemoScene")

local MenuScene = class("MenuScene",  DemoScene)
local MappingScene = {
    ["n1"] = {sceneName = "BasicsScene", isOpen = true},
    ["n2"] = {sceneName = "TransitionDemoScene", isOpen = true},
    ["n4"] = {sceneName = "VirtualListScene", isOpen = true},
    ["n5"] = {sceneName = "LoopListScene", isOpen = true},
    ["n6"] = {sceneName = "HitTestScene", isOpen = true},
    ["n7"] = {sceneName = "PullToRefreshScene", isOpen = true},
    ["n8"] = {sceneName = "ModalWaitingScene", isOpen = true},
    ["n9"] = {sceneName = "JoystickScene", isOpen = true},
    ["n10"] = {sceneName = "BagScene", isOpen = true},
    ["n11"] = {sceneName = "ChatScene", isOpen = true},
    ["n12"] = {sceneName = "ListEffectScene", isOpen = true},
    ["n13"] = {sceneName = "ScrollPaneScene", isOpen = true},
    ["n14"] = {sceneName = "TreeViewScene", isOpen = true},
    ["n15"] = {sceneName = "GuideScene", isOpen = true},
    ["n16"] = {sceneName = "CooldownScene", isOpen = true},
}
function MenuScene:ctor() 
    MenuScene.super.ctor(self)
end

function MenuScene:continueInit()
    fgui.UIPackage:addPackage("fairyGUIDemo/MainMenu")
    local _view = fgui.UIPackage:createObject("MainMenu", "Main")
    _view:makeFullScreen()  -- 全屏界面适配
    self._groot:addChild(_view)
    self:initBtnsGroup(_view)
end

function MenuScene:initBtnsGroup(_view)
    local scene = nil
    -- local btnsGroup = _view:getChild("btns")  --TODO: 这里btns 是高级组为什么无法访问
    for nodeTag, t in pairs(MappingScene) do
        local node  = _view:getChild(nodeTag)
        if t.isOpen then
            node:addClickListener(function(context)
                local nodeName = context:getSender().name
                print("MenuScene sender name:",  nodeName)
                local sceneName = MappingScene[nodeName].sceneName
                scene = require("fairyGUI.views."..sceneName).new()
                cc.Director:getInstance():replaceScene(scene);
            end)
        else
            node:setText(node:getText().."暂未开发")
            node:setTitleColor(cc.c3b(232,188,50))
        end
    end
end

function MenuScene:onExit()
    print("MenuScene:onExit()")
    MenuScene.super.onExit(self)  --如果子类有实现onExit 请调用super.onExit(self) ；如果没有实现可以不添加onExit该方法
end

function MenuScene:onEnter()
    print("MenuScene:onEnter()")
end

function MenuScene:onClear()
    print("MenuScene:onClear()")
end

return MenuScene