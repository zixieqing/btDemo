--【动效展示场景】
local DemoScene = require("fairyGUI.views.DemoScene")

local TransitionDemoScene = class("TransitionDemoScene",  DemoScene)


function TransitionDemoScene:ctor()
    TransitionDemoScene.super.ctor(self)
end

function TransitionDemoScene:initVars()
    self._g1 = nil
    self._g2 = nil
    self._g3 = nil
    self._g4 = nil
    self._g5 = nil
    self._g6 = nil
    self._startValue = 0
    self._endValue = 0
    self._btnGroup = nil
end

function TransitionDemoScene:continueInit()

    fgui.UIPackage:addPackage("fairyGUIDemo/Transition")
    local _view = fgui.UIPackage:createObject("Transition", "Main");
    self._groot:addChild(_view);
   
    self._btnGroup = _view:getChild("g0");

    self._g1 = fgui.UIPackage:createObject("Transition", "BOSS");
    self._g1:retain();
    self._g2 = fgui.UIPackage:createObject("Transition", "BOSS_SKILL");
    self._g2:retain();
    self._g3 = fgui.UIPackage:createObject("Transition", "TRAP");
    self._g3:retain();
    self._g4 = fgui.UIPackage:createObject("Transition", "GoodHit");
    self._g4:retain();
    self._g5 = fgui.UIPackage:createObject("Transition", "PowerUp");
    self._g5:retain();
    self._g5:getTransition("t0"):setHook("play_num_now", handler(self, self.playNum));
    self._g6 = fgui.UIPackage:createObject("Transition", "PathDemo");
    self._g6:retain();

    _view:getChild("btn0"):addClickListener(function()self:__play(self._g1); end);
    _view:getChild("btn1"):addClickListener(function()self:__play(self._g2); end);
    _view:getChild("btn2"):addClickListener(function()self:__play(self._g3); end);
    _view:getChild("btn3"):addClickListener(handler(self, self.__play4));
    _view:getChild("btn4"):addClickListener(handler(self, self.__play5));
    _view:getChild("btn5"):addClickListener(function()self:__play(self._g6); end);
end

function TransitionDemoScene:__play(target)

    self._btnGroup:setVisible(false);
    self._groot:addChild(target);
    local t = target:getTransition("t0");
    t:play(function()
        self._btnGroup:setVisible(true);
        self._groot:removeChild(target);
    end);
end

function TransitionDemoScene:__play4(context)

    self._btnGroup:setVisible(false);
    self._g4:setPosition(self._groot:getWidth() - self._g4:getWidth() - 20, 100);
    self._groot:addChild(self._g4);
    local t = self._g4:getTransition("t0");
    t:play(3, 0,function ()
        self._btnGroup:setVisible(true);
        self._groot:removeChild(self._g4);
    end);
end

function TransitionDemoScene:__play5(context)

    self._btnGroup:setVisible(false);
    self._g5:setPosition(20, self._groot:getHeight() - self._g5:getHeight() - 100);
    self._groot:addChild(self._g5);
    local t = self._g5:getTransition("t0");
    self._startValue = 10000;
    local add = 1000 + math.random() * 2000;
    self._endValue = self._startValue + add;
    self._g5:getChild("value"):setText(tostring(self._startValue));
    self._g5:getChild("add_value"):setText(tostring(add));
    t:play(function()
        self._btnGroup:setVisible(true);
        self._groot:removeChild(self._g5);
    end);
end

function TransitionDemoScene:playNum()

    fgui.GTween:to(self._startValue, self._endValue, 0.3):onUpdate(function(tweener)
        self._g5:getChild("value"):setText(tostring(tweener.value.x));
    end);
end


function TransitionDemoScene:onExit()
    print("TransitionDemoScene:onExit()")
    CC_SAFE_RELEASE(self._g1);
    CC_SAFE_RELEASE(self._g2);
    CC_SAFE_RELEASE(self._g3);
    CC_SAFE_RELEASE(self._g4);
    CC_SAFE_RELEASE(self._g5);
    CC_SAFE_RELEASE(self._g6);
    fgui.UIPackage:removePackage("fairyGUIDemo/LoopList")  -- 看项目需求，如果不经常使用的建议退出的时候移除包，避免内存长期占用问题
    TransitionDemoScene.super.onExit(self)  --如果子类有实现onExit 请调用super.onExit(self) ；如果没有实现可以不添加onExit该方法
end

function TransitionDemoScene:onEnter()
    print("TransitionDemoScene:onEnter()")
end

function TransitionDemoScene:onClear()
    print("TransitionDemoScene:onClear()")
end

return TransitionDemoScene