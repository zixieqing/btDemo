
--【基础功能展示】
local DemoScene = require("fairyGUI.views.DemoScene")
local BasicsScene = class("BasicsScene",  DemoScene)
local scheduler = require("src.cocos.framework.scheduler")
local Window1 = require("src.fairyGUI.views.window.Window1")
local Window2 = require("src.fairyGUI.views.window.Window2")

function BasicsScene:ctor() 
    BasicsScene.super.ctor(self)
end

function BasicsScene:initVars()
    self._demoObjects = {}
    self._backBtn = nil
    self._demoContainer = nil
    self._pm = nil
    self._popupCom = nil
    self._winA = nil
    self._winB = nil
end

function BasicsScene:onExit()
    CC_SAFE_RELEASE(self._pm)
    CC_SAFE_RELEASE(self._popupCom)
    CC_SAFE_RELEASE(self._winA)
    CC_SAFE_RELEASE(self._winB)
    for k, v in pairs(self._demoObjects) do
        CC_SAFE_RELEASE(v)
    end
    fgui.UIPackage:removePackage("fairyGUIDemo/Basics") 
    BasicsScene.super.onExit(self)  
end


function BasicsScene:continueInit()
    fgui.UIConfig.buttonSound = "ui://Basics/click";
    fgui.UIConfig.verticalScrollBar = "ui://Basics/ScrollBar_VT";
    fgui.UIConfig.horizontalScrollBar = "ui://Basics/ScrollBar_HZ";
    fgui.UIConfig.tooltipsWin = "ui://Basics/WindowFrame";
    fgui.UIConfig.popupMenu = "ui://Basics/PopupMenu";

    fgui.UIPackage:addPackage("fairyGUIDemo/Basics")
    local _view = fgui.UIPackage:createObject("Basics", "Main")
    self._groot:addChild(_view)
    self:initUI(_view)
end

function BasicsScene:initUI(_view)
    self._backBtn = _view:getChild("btn_Back");
    self._backBtn:setVisible(false);
    self._backBtn:addClickListener(handler(self, self.onClickBack)) 

    self._demoContainer = _view:getChild("container")
    self._cc = _view:getController("c1");

    local  cnt = _view:numChildren();
    for i = 0, cnt - 1  do
        local obj = _view:getChildAt(i);
        if (obj:getGroup() and string.find(obj:getGroup().name, "btns") > 0) then
            obj:addClickListener(handler(self, self.runDemo));
        end
    end
end

function BasicsScene:onClickBack()
    local index = self._cc:getSelectedIndex() == 1 and 0 or 1
    self._cc:setSelectedIndex(index);
    self._cc.selectedIndex = index
    self._backBtn:setVisible(false);
end

function BasicsScene:runDemo(context)
    local type = context:getSender().name
    local type = string.sub( type, 5 )
    print("runDemo",type)
    local isExist = false
    local obj
    for k, v in pairs(self._demoObjects) do
        if k == type then
            isExist = true
            obj = v
        end
    end
    if isExist == false then
        obj = fgui.UIPackage:createObject("Basics", "Demo_" .. type);
        obj:retain()
        self._demoObjects[type] = obj
    end
    self._demoContainer:removeChildren()
    self._demoContainer:addChild(obj);

    self._cc:setSelectedIndex(1);
    self._backBtn:setVisible(true);

    if (type == "Text") then
        self:playText();
    elseif (type == "Depth") then
        self:playDepth();
    elseif (type == "Window") then
        self:playWindow();
    elseif (type == "Drag&Drop") then
        self:playDragDrop();
    elseif (type == "Popup") then
        self:playPopup();
    elseif (type == "ProgressBar") then
        self:playProgress();
    end
end

function BasicsScene:playText()
    local obj = self._demoObjects["Text"];
    obj:getChild("n12"):addEventListener(fgui.UIEventType.ClickLink, function(context) 
        local t = context:getSender();
        local text = string.format("[img]ui://Basics/pet[/img][color=#FF0000]You click the link[/color]:%s", context:getDataValue() )
        t:setText(text);
    end);
    obj:getChild("n25"):addClickListener(function() 
        obj:getChild("n24"):setText(obj:getChild("n22"):getText());
    end);
end

function BasicsScene:playPopup()

    if (self._pm == nil) then
    
        self._pm = fgui.PopupMenu:create();
        self._pm:retain();
        self._pm:addItem("Item 1", handler(self, self.onClickMenu));
        self._pm:addItem("Item 2", handler(self, self.onClickMenu));
        self._pm:addItem("Item 3", handler(self, self.onClickMenu));
        self._pm:addItem("Item 4", handler(self, self.onClickMenu));
    end

    if (self._popupCom == nil) then
    
        self._popupCom = fgui.UIPackage:createObject("Basics", "Component12");
        self._popupCom:retain();
        self._popupCom:center();
    end
    local obj = self._demoObjects["Popup"];
    obj:getChild("n0"):addClickListener(function(context) 
        self._pm:show(context:getSender(), fgui.PopupDirection.DOWN);
    end);

    obj:getChild("n1"):addClickListener(function(context) 
        fgui.GRoot:getInstance():showPopup(self._popupCom);
    end);

    obj:addEventListener(fgui.UIEventType.RightClick, function(context) 
        self._pm:show();
    end);
end

function BasicsScene:onClickMenu(context)
    local itemObject = context:getData();
    print(string.format("click %s", itemObject:getText()));
end

function BasicsScene:playWindow()

    local obj = self._demoObjects["Window"];
    if (self._winA == nil) then
    
        self._winA = Window1.new();
        self._winA:retain();

        self._winB = Window2:create();
        self._winB:retain();

        obj:getChild("n0"):addClickListener(function(context) 
            self._winA:show();
        end);

        obj:getChild("n1"):addClickListener(function(context) 
            self._winB:show();
        end);
    end
end

function BasicsScene:playDepth()

    local obj = self._demoObjects["Depth"];
    local testContainer = obj:getChild("n22");
    local fixedObj = testContainer:getChild("n0");
    fixedObj:setSortingOrder(100);
    fixedObj:setDraggable(true);

    local numChildren = testContainer:numChildren();
    local i = 0;
    while (i < numChildren) do
    
        local child = testContainer:getChildAt(i);
        if (child ~= fixedObj) then
        
            testContainer:removeChildAt(i);
            numChildren = numChildren - 1;
        else
            i = i + 1
        end
    end
    local startPos = fixedObj:getPosition();

    obj:getChild("btn0"):addClickListener(function(context)
        local graph = fgui.GGraph:create(); --AL lib: (EE) ALCmmdevPlayback_open: Device init failed: 0x80070490 渲染库可能有问题
        startPos.x = startPos.x + 10;
        startPos.y = startPos.y + 10;
        graph:setPosition(startPos.x, startPos.y);
        graph:drawRect(150, 150, 1, cc.BLACK, cc.RED);
        obj:getChild("n22"):addChild(graph);
    end)
                                           

    obj:getChild("btn1"):addClickListener(function(context)
        local graph = fgui.GGraph:create();
        startPos.x = startPos.x + 10;
        startPos.y = startPos.y + 10;
        graph:setPosition(startPos.x, startPos.y);
        graph:drawRect(150, 150, 1, cc.BLACK, cc.GREEN);
        graph:setSortingOrder(200);
        obj:getChild("n22"):addChild(graph);
    end)
                                           
end

function BasicsScene:playDragDrop()

    local obj = self._demoObjects["Drag&Drop"]
    obj:getChild("a"):setDraggable(true);

    local b = obj:getChild("b");
    b:setDraggable(true);
    b:addEventListener(fgui.UIEventType.DragStart, function(context) 
        --Cancel the original dragging, and start a new one with a agent.
        context:preventDefault();

        fgui.DragDropManager:getInstance():startDrag(b:getIcon(), b:getIcon(), context:getInput():getTouchId());
    end);

    local c = obj:getChild("c");
    c:setIcon("");
    c:addEventListener(fgui.UIEventType.Drop, function(context) 
        c:setIcon(tostring(context:getDataValue()));
    end);

    local bounds = obj:getChild("n7");
    local rect = bounds:transformRect(cc.rect(0, 0, bounds:getSize().width, bounds:getSize().height), self._groot);

    -----~~Because at this time the container is on the right side of the stage and beginning to move to left(transition), so we need to caculate the final position
    rect.x = rect.x - obj:getParent():getX();
    ------

    local d = obj:getChild("d");
    d:setDraggable(true);
    d:setDragBounds(rect);
end

function BasicsScene:playProgress()

    local obj = self._demoObjects["ProgressBar"];

    local handle = scheduler.scheduleGlobal(function()
        self:onPlayProgress()
    end, 0.02)

    obj:addEventListener(fgui.UIEventType.Exit, function()
        scheduler.unscheduleGlobal(handle)
    end);
end

function BasicsScene:onPlayProgress(dt)

    local obj = self._demoObjects["ProgressBar"];
    local cnt = obj:numChildren();
    for i = 0, cnt-1 do
    
        local child = obj:getChildAt(i);
        if (child ~= nil) then
        
            child:setValue(child:getValue() + 1);
            if (child:getValue() > child:getMax()) then
                child:setValue(child:getMin());
            end
        end
    end
end

return BasicsScene
    
