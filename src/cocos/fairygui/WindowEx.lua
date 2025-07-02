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

-- 注册fgui.GComponent 事件:  onEnter()  onExit() 
function fgui.GComponent:enableComponentEvents()
    self:registerLifeCycle(function(state)
        print("enableWindowEvents", state)
        local printInfo = string.format("use class: 【%s】 function:【%s】 isExist: 【%s】",self.class.__cname, state, self[state]~=nil and "true" or "false")
        print(printInfo)
        if self[state] then
            self[state](self)
        end
        return self[state] ~= nil
    end)
end




--- 注册组件拓展
---@param url string
---@param extensiton class
function fgui.registerComponent(url, extensiton)
    if DEBUG > 0 then
        local checkUrlItem  = fgui.UIPackage:hasItemByURL(url)
        assert(checkUrlItem, string.format("[error] function 'fgui.registerComponent' url:[%s] is not exist, fix path correct.", url))
    end
    fgui.UIObjectFactory:registComponent(url, function()
        return extensiton.new()
    end,function(obj)
        extensiton.onConstruct(obj)
    end)
end

fgui.UIRoot = fgui.GRoot:getInstance()