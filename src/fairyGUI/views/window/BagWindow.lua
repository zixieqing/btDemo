--【背包窗口】

local BagWindow = class("BagWindow",  fgui.LuaWindow)

function BagWindow:ctor()
    self:enableWindowEvents()

    math.randomseed(os.time())

    self._bagWindow = nil 

    self:setContentPane(fgui.UIPackage:createObject("Bag", "BagWin"));
    self:center();
    self:setModal(true)

    self._contentPane = self:getContentPane()

    local _list = self._contentPane:getChild("list");
    _list:addEventListener(fgui.UIEventType.ClickItem, handler(self, self.onClickItem));
    _list:setItemRenderer(handler(self, self.renderListItem)) 
    _list:setNumItems(45);
end

function BagWindow:renderListItem(index, obj)
    local icon = fgui.UIPackage:getItemURL("Bag", "i"..math.random(1,9));
    obj:setIcon(icon);
    obj:setText(tostring(math.random(0,100)));
end

function BagWindow:doShowAnimation()

    self:setScale(0.1, 0.1);
    self:setPivot(0.5, 0.5);

    fgui.GTween:to(self:getScale(), cc.p(1,1), 0.3):setTarget(self, fgui.TweenPropType.Scale):onComplete(handler(self, self.onShown));
end

function BagWindow:doHideAnimation()

    fgui.GTween:to(self:getScale(), cc.p(0.1, 0.1), 0.3):setTarget(self, fgui.TweenPropType.Scale):onComplete(handler(self, self.hideImmediately));
end

function BagWindow:onClickItem(context)
    local item = context:getData();
    print("item:getIcon()",item.name)
    self._contentPane:getChild("n11"):setIcon(item:getIcon());
    self._contentPane:getChild("n13"):setText(item:getText());
end
return BagWindow