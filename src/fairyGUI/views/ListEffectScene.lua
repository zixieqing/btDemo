-- 【列表效果】
local DemoScene = require("fairyGUI.views.DemoScene")

local ListEffectScene = class("ListEffectScene", DemoScene)
local MailItem = require("fairyGUI.views.component.MailItem")

function ListEffectScene:ctor()
    ListEffectScene.super.ctor(self)
end

function ListEffectScene:initVars()
    
end

function ListEffectScene:continueInit()
    fgui.UIPackage:addPackage("fairyGUIDemo/Extension")
    fgui.UIConfig.horizontalScrollBar = "";
    fgui.UIConfig.verticalScrollBar = "";
    fgui.UIObjectFactory:setPackageItemExtension("ui://Extension/mailItem", function()
        return MailItem.new() 
    end);   
    local _view = fgui.UIPackage:createObject("Extension", "Main")
    self._groot:addChild(_view)

    local _list = _view:getChild("mailList");

    for i = 0, 10 do
        local item = _list:addItemFromPool();
        item:onConstruct()
        item:setFetched(i % 3 == 0);
        item:setRead(i % 2 == 0);
        item:setTime("5 Nov 2015 16:24:33");
        item:setTitle("Mail title here");
    end

    _list:ensureBoundsCorrect();
    local delay = 1.0;
    for i = 0, 10 do
        local item = _list:getChildAt(i);
        if (_list:isChildInView(item)) then
            item:playEffect(delay);
            delay = delay + 0.2;
        else
            break;
        end
    end

end

function ListEffectScene:onExit()
    print("ListEffectScene:onExit()")
    fgui.UIPackage:removePackage("fairyGUIDemo/Extension")
    ListEffectScene.super.onExit(self)
end

function ListEffectScene:onEnter()
    print("ListEffectScene:onEnter()")
end

function ListEffectScene:onClear()
    print("ListEffectScene:onClear()")
end

return ListEffectScene