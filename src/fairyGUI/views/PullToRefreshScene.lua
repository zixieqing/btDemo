-- 【下拉刷新场景】
local DemoScene = require("fairyGUI.views.DemoScene")
local ScrollPaneHeader = require("src.fairyGUI.views.component.ScrollPaneHeader")
local PullToRefreshScene = class("PullToRefreshScene", DemoScene)
local scheduler = require("src.cocos.framework.scheduler")
function PullToRefreshScene:ctor()
    PullToRefreshScene.super.ctor(self)
end

function PullToRefreshScene:initVars()
    self._list1 = nil
    self._list2 = nil
end

function PullToRefreshScene:continueInit()
    fgui.UIPackage:addPackage("fairyGUIDemo/PullToRefresh")
    fgui.UIObjectFactory:setPackageItemExtension("ui://PullToRefresh/Header", function()
        return ScrollPaneHeader.new()
    end);
    local _view = fgui.UIPackage:createObject("PullToRefresh", "Main")
    self._groot:addChild(_view)

    self._list1 = _view:getChild("list1");
    self._list1:setItemRenderer(handler(self, self.renderListItem1));
    self._list1:setVirtual();
    self._list1:setNumItems(1);
    self._list1:addEventListener(fgui.UIEventType.PullDownRelease, handler(self, self.onPullDownToRefresh));

    self._list2 = _view:getChild("list2");
    self._list2:setItemRenderer(handler(self, self.renderListItem2));
    self._list2:setVirtual();
    self._list2:setNumItems(1);
    self._list2:addEventListener(fgui.UIEventType.PullUpRelease, handler(self, self.onPullUpToRefresh));

end

function PullToRefreshScene:renderListItem1(index, obj)

    obj:setText("Item " .. tostring(self._list1:getNumItems() - index - 1));
end

function PullToRefreshScene:renderListItem2(index, obj)

    obj:setText("Item " .. tostring(index));
end

function PullToRefreshScene:onPullDownToRefresh()

    local header = self._list1:getScrollPane():getHeader();
    header:onConstruct();
    if (header:isReadyToRefresh()) then
    
        header:setRefreshStatus(2);
        self._list1:getScrollPane():lockHeader(header.sourceSize.height);

        --Simulate a async resquest
    
        scheduler.performWithDelayGlobal(function ()
            self._list1:setNumItems(self._list1:getNumItems() + 5);

            --Refresh completed
            header:setRefreshStatus(3);
            self._list1:getScrollPane():lockHeader(35);

            scheduler.performWithDelayGlobal(function()
            
                header:setRefreshStatus(0);
                self._list1:getScrollPane():lockHeader(0);
            end, 2);
        end, 2)
    end
end

function PullToRefreshScene:onPullUpToRefresh()

    local footer = self._list2:getScrollPane():getFooter();

    footer:getController("c1"):setSelectedIndex(1);
    self._list2:getScrollPane():lockFooter(footer.sourceSize.height);

    --Simulate a async resquest
    scheduler.performWithDelayGlobal(function ()
        self._list2:setNumItems(self._list2:getNumItems() + 5);
        --Refresh completed
        footer:getController("c1"):setSelectedIndex(0);
        self._list2:getScrollPane():lockFooter(0);
    end, 2)
end

function PullToRefreshScene:onExit()
    print("PullToRefreshScene:onExit()")
    fgui.UIPackage:removePackage("fairyGUIDemo/PullToRefresh")
    PullToRefreshScene.super.onExit(self)
end

function PullToRefreshScene:onEnter()
    print("PullToRefreshScene:onEnter()")
end

function PullToRefreshScene:onClear()
    print("PullToRefreshScene:onClear()")
end

return PullToRefreshScene