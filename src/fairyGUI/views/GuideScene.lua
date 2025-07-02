-- 【新手引导】
local DemoScene = require("fairyGUI.views.DemoScene")

local GuideScene = class("GuideScene", DemoScene)

function GuideScene:ctor()
    GuideScene.super.ctor(self)
end

function GuideScene:initVars()
    self._guideLayer = nil
end

function GuideScene:continueInit()
    fgui.UIPackage:addPackage("fairyGUIDemo/Guide")
    local _view = fgui.UIPackage:createObject("Guide", "Main")
    self._groot:addChild(_view)

    self._guideLayer = fgui.UIPackage:createObject("Guide", "GuideLayer");
    self._guideLayer:makeFullScreen();
    self._guideLayer:addRelation(self._groot, fgui.RelationType.Size);
    self._guideLayer:retain();

    local bagBtn = _view:getChild("bagBtn");
    bagBtn:addClickListener(function()
        self._guideLayer:removeFromParent();
    end)
    
    _view:getChild("n2"):addClickListener(function()
        self._groot:addChild(self._guideLayer); --!!Before using TransformRect(or GlobalToLocal), the object must be added first
        local defaultRect = cc.rect(0, 0, bagBtn:getSize().width, bagBtn:getSize().height)
        local rect = bagBtn:transformRect(defaultRect, self._guideLayer);

        local window = self._guideLayer:getChild("window");
        window:setSize(rect.width,rect.height);

        fgui.GTween:to(window:getPosition(), cc.p(rect.x, rect.y), 0.5):setTarget(window, fgui.TweenPropType.Position);
    end);

end

function GuideScene:onExit()
    print("GuideScene:onExit()")
    CC_SAFE_RELEASE(self._guideLayer)
    fgui.UIPackage:removePackage("fairyGUIDemo/Guide")
    GuideScene.super.onExit(self)
end

function GuideScene:onEnter()
    print("GuideScene:onEnter()")
end

function GuideScene:onClear()
    print("GuideScene:onClear()")
end

return GuideScene