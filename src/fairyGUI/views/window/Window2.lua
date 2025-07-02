local Window2 = class("Window2", fgui.LuaWindow)

function Window2:ctor()
    self:enableWindowEvents()
    
end

function Window2:onInit()
    self:setContentPane(fgui.UIPackage:createObject("Basics", "WindowB"));
    self:center();
end

function Window2:doShowAnimation()
    print("Window2:doShowAnimation()")
    self:setScale(0.1, 0.1);
    self:setPivot(0.5, 0.5);

    fgui.GTween:to(self:getScale(), cc.p(1, 1), 0.3):setTarget(self, fgui.TweenPropType.Scale):onComplete(handler(self, self.onShown));
end

function Window2:doHideAnimation()
    print("Window2:doHideAnimation()")

    fgui.GTween:to(self:getScale(), cc.p(0.1, 0.1), 0.3):setTarget(self, fgui.TweenPropType.Scale):onComplete(handler(self, self.hideImmediately));
end

function Window2:onShown()

    self:getContentPane():getTransition("t1"):play();
end

function Window2:onHide()

    self:getContentPane():getTransition("t1"):stop();
end

return Window2