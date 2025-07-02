local Window1 = class("Window1", fgui.LuaWindow)

function Window1:ctor()
    self:enableWindowEvents()
end

function Window1:onInit()
    self:setContentPane(fgui.UIPackage:createObject("Basics", "WindowA"));
    self:center();
end

function Window1:onShown()

    local list = self:getContentPane():getChild("n6");
    list:removeChildrenToPool();

    for i = 0, 6 do
        local item = list:addItemFromPool();
        item:setTitle(tostring(i));
        item:setIcon("ui://Basics/r4");
    end
end

return Window1