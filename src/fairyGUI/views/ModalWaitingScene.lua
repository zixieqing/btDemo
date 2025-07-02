-- 【模式等待场景】
local DemoScene = require("fairyGUI.views.DemoScene")
local ModalWaitScene = class("ModalWaitScene", DemoScene)
local scheduler = require("src.cocos.framework.scheduler")

function ModalWaitScene:ctor()
    ModalWaitScene.super.ctor(self)
end

function ModalWaitScene:initVars()
    self._testWin = nil
end

function ModalWaitScene:continueInit()
    fgui.UIConfig.globalModalWaiting = "ui://ModalWaiting/GlobalModalWaiting";
    fgui.UIConfig.windowModalWaiting = "ui://ModalWaiting/WindowModalWaiting";
    fgui.UIPackage:addPackage("fairyGUIDemo/ModalWaiting")
    local _view = fgui.UIPackage:createObject("ModalWaiting", "Main")
    self._groot:addChild(_view)

    self._testWin = fgui.Window:create();
    self._testWin:retain();
    self._testWin:setContentPane(fgui.UIPackage:createObject("ModalWaiting", "TestWin"));
    self._testWin:getContentPane():getChild("n1"):addClickListener(function()
    
        self._testWin:showModalWait();
        --simulate a asynchronous request
        scheduler.performWithDelayGlobal(function ()
            self._testWin:closeModalWait();
        end, 3);
    end);
   
    _view:getChild("n0"):addClickListener(function()
         self._testWin:show(); 
    end);
   
    self._groot:showModalWait();
   
    --simulate a asynchronous request
   
    scheduler.performWithDelayGlobal(function ()
        self._groot:closeModalWait();
    end, 3);

end

function ModalWaitScene:onExit()
    print("ModalWaitScene:onExit()")
    CC_SAFE_RELEASE(self._testWin)
    fgui.UIPackage:removePackage("fairyGUIDemo/ModalWaiting")
    ModalWaitScene.super.onExit(self)
end

function ModalWaitScene:onEnter()
    print("ModalWaitScene:onEnter()")
end

function ModalWaitScene:onClear()
    print("ModalWaitScene:onClear()")
end

return ModalWaitScene