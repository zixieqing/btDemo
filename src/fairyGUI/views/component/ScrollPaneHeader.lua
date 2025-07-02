local ScrollPaneHeader = class("ScrollPaneHeader", fgui.GComponent)

function ScrollPaneHeader:ctor()

end

function ScrollPaneHeader:onConstruct()

    self._c1 = self:getController("c1");

    self:addEventListener(fgui.UIEventType.SizeChange, handler(self, self.onSizeChanged));
end

function ScrollPaneHeader:onSizeChanged()

    if (self._c1:getSelectedIndex() == 2 or self._c1:getSelectedIndex() == 3) then
        return;
    end

    if (self:getHeight() > self.sourceSize.height) then
        self._c1:setSelectedIndex(1);
    else
        self._c1:setSelectedIndex(0);
    end
end

function ScrollPaneHeader:setRefreshStatus(value)

    self._c1:setSelectedIndex(value);
end

function ScrollPaneHeader:isReadyToRefresh()
   return self._c1:getSelectedIndex() == 1;
end

return ScrollPaneHeader