
---@class fgui.GTreeNode :cc.Ref
local GTreeNode={ }
fgui.GTreeNode=GTreeNode




---* 
---@param child fgui.GTreeNode
---@return self
function GTreeNode:addChild (child) end
---* 
---@param value boolean
---@return self
function GTreeNode:setExpaned (value) end
---* 
---@return boolean
function GTreeNode:isFolder () end
---* 
---@return string
function GTreeNode:getText () end
---* 
---@param child fgui.GTreeNode
---@param index int
---@return self
function GTreeNode:setChildIndex (child,index) end
---* 
---@return self
function GTreeNode:getNextSibling () end
---* 
---@param child fgui.GTreeNode
---@param index int
---@return self
function GTreeNode:addChildAt (child,index) end
---@overload fun(int:int,int:int):self
---@overload fun():self
---@param beginIndex int
---@param endIndex int
---@return self
function GTreeNode:removeChildren (beginIndex,endIndex) end
---* 
---@param index int
---@return self
function GTreeNode:removeChildAt (index) end
---* 
---@return fgui.GComponent
function GTreeNode:getCell () end
---* 
---@return cc.Value
function GTreeNode:getData () end
---* 
---@param value string
---@return self
function GTreeNode:setIcon (value) end
---* 
---@param value cc.Value
---@return self
function GTreeNode:setData (value) end
---* 
---@return fgui.GTree
function GTreeNode:getTree () end
---* 
---@param child fgui.GTreeNode
---@return int
function GTreeNode:getChildIndex (child) end
---* 
---@param index int
---@return self
function GTreeNode:getChildAt (index) end
---* 
---@return self
function GTreeNode:getPrevSibling () end
---* 
---@return boolean
function GTreeNode:isExpanded () end
---* 
---@param child fgui.GTreeNode
---@param index int
---@return int
function GTreeNode:setChildIndexBefore (child,index) end
---* 
---@return self
function GTreeNode:getParent () end
---* 
---@return string
function GTreeNode:getIcon () end
---* 
---@param value string
---@return self
function GTreeNode:setText (value) end
---* 
---@param index1 int
---@param index2 int
---@return self
function GTreeNode:swapChildrenAt (index1,index2) end
---* 
---@return int
function GTreeNode:numChildren () end
---* 
---@param child fgui.GTreeNode
---@return self
function GTreeNode:removeChild (child) end
---* 
---@param child1 fgui.GTreeNode
---@param child2 fgui.GTreeNode
---@return self
function GTreeNode:swapChildren (child1,child2) end
---* 
---@return self
function GTreeNode:create () end
---* 
---@return self
function GTreeNode:GTreeNode () end