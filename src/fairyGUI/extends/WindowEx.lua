-- 注册fgui.LuaWindow 事件:onInit,onHide,onShown,doShowAnimation,doHideAnimation
function fgui.LuaWindow:enableWindowEvents()
    self:registerScriptHandler(function(state)
        print("enableWindowEvents", state)
        local printInfo = string.format("use class: 【%s】 function:【%s】 isExist: 【%s】",self.class.__cname, state, self[state]~=nil and "true" or "false")
        print(printInfo)
        if self[state] then
            self[state](self)
        end
        return self[state] ~= nil
    end)
end

-- 后续如果需要自己做统一窗口动画，创建一个WindowBase即可