local DemoScene = class("DemoScene", function()
    return display.newScene("DemoScene")
end)

function DemoScene:ctor()
    self:enableNodeEvents()  --生命周期监听
    self:initVars(); --增加私有变量初始化方法，避免写错顺序导致释放出问题
    
    self._groot = fgui.GRoot:create(self, 1)
    self._groot:retain()
    print(string.format("scene:【%s】 的_groot引用计数为：【%s】",self.class.__cname, self._groot:getReferenceCount()))
    self:continueInit();
    self:addCloseBtn()
end

function DemoScene:addCloseBtn()
    -- //add a closebutton to scene
    local closeButton = fgui.UIPackage:createObject("MainMenu", "CloseButton");
    closeButton:setPosition(self._groot:getWidth() - closeButton:getWidth() - 10, self._groot:getHeight() - closeButton:getHeight() - 10)
    closeButton:addRelation(self._groot, fgui.RelationType.Right_Right);
    closeButton:addRelation(self._groot, fgui.RelationType.Bottom_Bottom);
    closeButton:setSortingOrder(100000);
    closeButton:addClickListener(function()
        if self.class.__cname ~= "MenuScene" then
            self.MenuScene = require("fairyGUI.views.MenuScene").new()
            cc.Director:getInstance():replaceScene(self.MenuScene);
        else
            local launcherScene = require("launcher.LauncherScene").new()
            display.runScene(launcherScene)
            -- cc.Director:getInstance():endToLua()
        end
    end);
    self._groot:addChild(closeButton);
end

function DemoScene:initVars()
    
end

function DemoScene:continueInit()

end

function DemoScene:onExit()
    print("DemoScene:onExit()")
    -- --debug
    -- if DEBUG > 0 and self.class.__cname then 
    --     for key, _ in pairs(package.loaded) do
    --         if string.find(tostring(key), self.class.__cname) == 1 then
    --             print("卸载包，重新require", key)
    --             package.loaded[key] = nil
    --         end
    --     end
    -- end
    CC_SAFE_RELEASE(self._groot)
    if not tolua.isnull(self._groot) then
        print(string.format("scene:%s 的_groot引用计数为：%s",self.class.__cname, self._groot:getReferenceCount()))
    end
  
    self._groot = nil;
end

function DemoScene:onEnter()
    print("DemoScene:onEnter()")
end


return DemoScene