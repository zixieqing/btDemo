--【摇杆】
local DemoScene = require("fairyGUI.views.DemoScene")
local JoystickModule = require("src.fairyGUI.views.component.JoystickModule")
local JoystickScene = class("JoystickScene",  DemoScene)

function JoystickScene:ctor() 
    JoystickScene.super.ctor(self)
end

function JoystickScene:initVars()
    self._joystick = nil
end

function JoystickScene:continueInit()
    fgui.UIPackage:addPackage("fairyGUIDemo/Joystick")
    local _view = fgui.UIPackage:createObject("Joystick", "Main")
    _view:makeFullScreen()  -- 全屏界面适配
    self._groot:addChild(_view)

    self._joystick = JoystickModule.new(_view);
    self._joystick:retain();

    local tf = _view:getChild("n9");

    self._joystick:addEventListener(self._joystick.MOVE, function(context)
        tf:setText(tostring(context:getDataValue()));
    end);

    self._joystick:addEventListener(self._joystick.END, function(context)
        tf:setText("");
    end);
    print("JoystickScene:continueInit() ")
end

function JoystickScene:onExit()
    print("JoystickScene:onExit()")
    CC_SAFE_RELEASE(self._joystick)
    self._joystick = nil
    JoystickScene.super.onExit(self)  --如果子类有实现onExit 请调用super.onExit(self) ；如果没有实现可以不添加onExit该方法
end

function JoystickScene:onEnter()
    print("JoystickScene:onEnter()")
end

function JoystickScene:onClear()
    print("JoystickScene:onClear()")
end

return JoystickScene