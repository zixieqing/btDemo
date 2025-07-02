--【循环列表场景】
local DemoScene = require("fairyGUI.views.DemoScene")

local LoopListScene = class("LoopListScene",  DemoScene)

function LoopListScene:ctor()
    LoopListScene.super.ctor(self)
end

function LoopListScene:initVars()
    self._list = nil
    self._view = nil
end

function LoopListScene:continueInit()

    fgui.UIPackage:addPackage("fairyGUIDemo/LoopList")

    fgui.UIConfig.horizontalScrollBar = "";  
    fgui.UIConfig.verticalScrollBar = "";
   
    self._view = fgui.UIPackage:createObject("LoopList", "Main");
    self._groot:addChild(self._view);
   
    self._list = self._view:getChild("list")
    self._list:setItemRenderer(handler(self, self.renderListItem))
    self._list:setVirtualAndLoop();
    self._list:setNumItems(5);
    self._list:addEventListener(fgui.UIEventType.Scroll, handler(self, self.doSpecialEffect));
end

function LoopListScene:renderListItem(index, obj)
    obj:setPivot(0.5, 0.5);
    local iconUrl = string.format("ui://LoopList/n%s",index + 1)
    obj:setIcon(iconUrl);
end

function LoopListScene:doSpecialEffect()

    local midX = self._list:getScrollPane():getPosX() + self._list:getViewWidth() / 2;
    local cnt = self._list:numChildren();
    for i = 0, cnt - 1 do
        local obj = self._list:getChildAt(i);
        local dist = math.abs(midX - obj:getX() - obj:getWidth() / 2);
        if (dist > obj:getWidth()) then --no intersection
            obj:setScale(1, 1);
        else
            local ss = 1 + (1 - dist / obj:getWidth()) * 0.24;
            obj:setScale(ss, ss);
        end
    end
    local curIndex = (self._list:getFirstChildInView() + 1) % self._list:getNumItems()
    self._view:getChild("n3"):setText(tostring(curIndex + 1));
end

function LoopListScene:onExit()
    print("LoopListScene:onExit()")
    fgui.UIPackage:removePackage("fairyGUIDemo/LoopList")  -- 看项目需求，如果不经常使用的建议退出的时候移除包，避免内存长期占用问题
    LoopListScene.super.onExit(self)  --如果子类有实现onExit 请调用super.onExit(self) ；如果没有实现可以不添加onExit该方法
end

function LoopListScene:onEnter()
    print("LoopListScene:onEnter()")
end

function LoopListScene:onClear()
    print("LoopListScene:onClear()")
end

return LoopListScene