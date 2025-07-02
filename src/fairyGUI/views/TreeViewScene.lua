-- 【树形列表】
local DemoScene = require("fairyGUI.views.DemoScene")

local TreeViewScene = class("TreeViewScene", DemoScene)

function TreeViewScene:ctor()
    TreeViewScene.super.ctor(self)
end

function TreeViewScene:initVars()
    
end

function TreeViewScene:continueInit()
    fgui.UIPackage:addPackage("fairyGUIDemo/TreeView")
    local _view = fgui.UIPackage:createObject("TreeView", "Main")
    self._groot:addChild(_view)

    local _tree1 = _view:getChild("tree");
    _tree1:addEventListener(fgui.UIEventType.ClickItem, handler(self, self.onClickNode));

    local _tree2 = _view:getChild("tree2");
    _tree2:addEventListener(fgui.UIEventType.ClickItem, handler(self, self.onClickNode));
    _tree2.treeNodeRender = handler(self, self.renderTreeNode);

    local topNode = fgui.GTreeNode:create(true);
    topNode:setData("I'm a top node");
    _tree2:getRootNode():addChild(topNode);
    for i = 0, 5 do
    
        local node = fgui.GTreeNode:create();
        node:setData("Hello " .. i);
        topNode:addChild(node);
    end

    local aFolderNode = fgui.GTreeNode:create(true);
    aFolderNode:setData("A folder node");
    topNode:addChild(aFolderNode);
    for i = 0, 5 do
    
        local node = fgui.GTreeNode:create();
        node:setData("Good " .. i);
        aFolderNode:addChild(node);
    end

    for i = 0, 3 do
    
        local node = fgui.GTreeNode:create();
        node:setData("World " .. i);
        topNode:addChild(node);
    end

    local anotherTopNode = fgui.GTreeNode:create();
    anotherTopNode:setData({
        "I'm a top node too", 
        "ui://TreeView/heart"
    });
    _tree2:getRootNode():addChild(anotherTopNode);
end

function TreeViewScene:onClickNode(context)

    local node = context:getData():treeNode();
    print(string.format("click node %s", node:getText()));
end

function TreeViewScene:renderTreeNode(node, obj)
    local btn = node:getCell();
    if (node:isFolder()) then
        btn:setText(tostring(node:getData()));
    elseif type(node:getData()) == "table" then    
        local t = node:getData()
        btn:setIcon(t[2])
        btn:setText(t[1])
    else
        btn:setIcon("ui://TreeView/file");
        btn:setText(tostring(node:getData()));
    end
end



function TreeViewScene:onExit()
    print("TreeViewScene:onExit()")
    fgui.UIPackage:removePackage("fairyGUIDemo/TreeView")
    TreeViewScene.super.onExit(self)
end

function TreeViewScene:onEnter()
    print("TreeViewScene:onEnter()")
end

function TreeViewScene:onClear()
    print("TreeViewScene:onClear()")
end

return TreeViewScene