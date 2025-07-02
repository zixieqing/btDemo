-- 【双向滚动】
local DemoScene = require("fairyGUI.views.DemoScene")

local ScrollPaneScene = class("ScrollPaneScene", DemoScene)

function ScrollPaneScene:ctor()
    ScrollPaneScene.super.ctor(self)
end

function ScrollPaneScene:initVars()
    self._list = nil
    self._view = nil
end

function ScrollPaneScene:continueInit()
    fgui.UIPackage:addPackage("fairyGUIDemo/ScrollPane")
    fgui.UIConfig.horizontalScrollBar = "";
    fgui.UIConfig.verticalScrollBar = "";
    self._view = fgui.UIPackage:createObject("ScrollPane", "Main")
    self._groot:addChild(self._view)

    self._list = self._view:getChild("list");
    self._list:setItemRenderer(handler(self, self.renderListItem));
    self._list:setVirtual();
    self._list:setNumItems(1000);
    self._list:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self.onClickList));
end

function ScrollPaneScene:renderListItem(index, obj)
    local item = obj;
    item:setTitle("Item " .. index);
    item:getScrollPane():setPosX(0); --reset scroll pos

    --Be carefull, RenderListItem is calling repeatedly, add tag to afunction adding duplicately.
    item:getChild("b0"):addClickListener(handler(self, self.onClickStick));
    item:getChild("b1"):addClickListener(handler(self, self.onClickDelete));
end

function ScrollPaneScene:onClickStick(context)

    self._view:getChild("txt"):setText("Stick " .. ((context:getSender()):getParent()):getText());
end

function ScrollPaneScene:onClickDelete(context)

    self._view:getChild("txt"):setText("Delete " .. ((context:getSender()):getParent()):getText());
end

function ScrollPaneScene:onClickList(context)

    --find out if there is an item in edit status
    local cnt = self._list:numChildren();
    for i = 0, cnt-1 do
    
        local item = self._list:getChildAt(i)
        if (item:getScrollPane():getPosX() ~= 0) then
        
            --Check if clicked on the button
            if (item:getChild("b0"):isAncestorOf(self._groot:getTouchTarget()) or item:getChild("b1"):isAncestorOf(self._groot:getTouchTarget())) then
                return;
            end
            item:getScrollPane():setPosX(0, true);
            --afunction scroll pane default behavior。
            item:getScrollPane():cancelDragging();
            self._list:getScrollPane():cancelDragging();
            break;
        end
    end
end


function ScrollPaneScene:onExit()
    print("ScrollPaneScene:onExit()")
    fgui.UIPackage:removePackage("fairyGUIDemo/ScrollPane")
    ScrollPaneScene.super.onExit(self)
end

function ScrollPaneScene:onEnter()
    print("ScrollPaneScene:onEnter()")
end

function ScrollPaneScene:onClear()
    print("ScrollPaneScene:onClear()")
end

return ScrollPaneScene