-- local MailItem = class("MailItem", function()
--     return fgui.GButton:create()
-- end)

local MailItem = class("MailItem", fgui.GButton)

function MailItem:ctor()
    
end

function MailItem:onConstruct() 
    self._timeText = self:getChild("timeText");
    self._readController = self:getController("IsRead");
    self._fetchController = self:getController("c1");
    self._trans = self:getTransition("t0");
end

function MailItem:setTime(value)
    self._timeText:setText(value);
end

function MailItem:setRead(value)
    self._readController:setSelectedIndex(value and 1 or 0);
end

function MailItem:setFetched(value)
    self._fetchController:setSelectedIndex(value and 1 or 0);
end

function MailItem:playEffect(delay)
    self:setVisible(false);
    self._trans:play(1, delay, function()
        print("MailItem:playEffect(delay) finish")
    end);
end

return MailItem