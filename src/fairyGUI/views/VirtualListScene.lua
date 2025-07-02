--【虚拟列表场景】
local DemoScene = require("fairyGUI.views.DemoScene")

local VirtualListScene = class("VirtualListScene",  DemoScene)
local MailItem = require("fairyGUI.views.component.MailItem")

function VirtualListScene:ctor()
    VirtualListScene.super.ctor(self)
end

function VirtualListScene:continueInit()

    fgui.UIPackage:addPackage("fairyGUIDemo/VirtualList")
    fgui.UIObjectFactory:setPackageItemExtension("ui://VirtualList/mailItem", function()
        --  C++ 这里会setVirtual之后从GComponent：constructFromResource-> 去调用 MailItem 的onConstruct但是lua没法回调回来了
        return MailItem.new() 
    end);

    --[[
        1.setPackageItemExtension 流程记录：设置之后，
        2.setVirtual
        3.->createObjectFromURL
        ->
        5.GObject* UIObjectFactory::newObject(PackageItem* pi)
        {
            GObject* obj;
            if (pi->extensionCreator != nullptr)
                obj = pi->extensionCreator(); --【此处触发回调】
            else
                obj = newObject(pi->objectType);
            if (obj != nullptr)
                obj->_packageItem = pi;

            return obj;
        }
        ->
        4.GObject* UIPackage::createObject(PackageItem* item)
        {
            GObject* g = UIObjectFactory::newObject(item); 5
            if (g == nullptr)
                return nullptr;

            _constructing++;
            g->constructFromResource();6
            _constructing--;
            return g;
        }
        ->
        6.g->constructFromResource();
        ->
        7.调用onConstruct :此处没法调用到lua的onConstruct,TODO 后续做优化； 先暂时在renderListItem里手动调用onConstruct
    ]]

    fgui.UIConfig.horizontalScrollBar = "";  
    fgui.UIConfig.verticalScrollBar = "";
   
    local _view = fgui.UIPackage:createObject("VirtualList", "Main");
    self._groot:addChild(_view);
   
    local _list = _view:getChild("mailList")
    _list:setItemRenderer(handler(self, self.renderListItem))
    _list:setVirtual();
    _list:setNumItems(1000);

    _view:getChild("n6"):addClickListener(function() _list:addSelection(500, true); end);
    _view:getChild("n7"):addClickListener(function() _list:getScrollPane():scrollTop(); end);
    _view:getChild("n8"):addClickListener(function() _list:getScrollPane():scrollBottom(); end);
   
end

function VirtualListScene:renderListItem(index, obj)
    obj:onConstruct()
    obj:setFetched(index % 3 == 0);
    obj:setRead(index % 2 == 0);
    obj:setTime("5 Nov 2015 16:24:33");
    obj:setText(tostring(index) .. " Mail title here");
end

function VirtualListScene:onExit()
    print("VirtualListScene:onExit()")
    fgui.UIPackage:removePackage("fairyGUIDemo/VirtualList")  -- 看项目需求，如果不经常使用的建议退出的时候移除包，避免内存长期占用问题
    VirtualListScene.super.onExit(self)  --如果子类有实现onExit 请调用super.onExit(self) ；如果没有实现可以不添加onExit该方法
end

function VirtualListScene:onEnter()
    print("VirtualListScene:onEnter()")
end

function VirtualListScene:onClear()
    print("VirtualListScene:onClear()")
end

return VirtualListScene