
---@class fgui.GList :fgui.GComponent
local GList={ }
fgui.GList=GList




---* 
---@return self
function GList:selectAll () end
---* 
---@return int
function GList:getColumnGap () end
---* 
---@return int
function GList:getLineCount () end
---* 
---@return self
function GList:setVirtualAndLoop () end
---* 
---@param value int
---@return self
function GList:setLayout (value) end
---* 
---@return self
function GList:refreshVirtualList () end
---* 
---@param index int
---@return self
function GList:removeSelection (index) end
---* 
---@param value int
---@return self
function GList:setColumnGap (value) end
---* 
---@return int
function GList:getColumnCount () end
---* 
---@return self
function GList:setVirtual () end
---* 
---@param value int
---@return self
function GList:setNumItems (value) end
---* 
---@param value int
---@return self
function GList:setVerticalAlign (value) end
---@overload fun(int:int,int:int):self
---@overload fun(int:int):self
---@param itemCount int
---@param minSize int
---@return self
function GList:resizeToFit (itemCount,minSize) end
---* 
---@param value fgui.GController
---@return self
function GList:setSelectionController (value) end
---* 
---@param obj fgui.GObject
---@return self
function GList:returnToPool (obj) end
---* 
---@return self
function GList:clearSelection () end
---* 
---@return int
function GList:getNumItems () end
---* 
---@param value int
---@return self
function GList:setColumnCount (value) end
---* 
---@param index int
---@return self
function GList:removeChildToPoolAt (index) end
---@overload fun(string:string):self
---@overload fun():self
---@param url string
---@return fgui.GObject
function GList:addItemFromPool (url) end
---* 
---@return self
function GList:selectReverse () end
---* 
---@param value int
---@return self
function GList:setLineCount (value) end
---* 
---@param value boolean
---@return self
function GList:setAutoResizeItem (value) end
---* 
---@return int
function GList:getVerticalAlign () end
---@overload fun(int:int,int:int):self
---@overload fun():self
---@param beginIndex int
---@param endIndex int
---@return self
function GList:removeChildrenToPool (beginIndex,endIndex) end
---* 
---@param value int
---@return self
function GList:setAlign (value) end
---* 
---@return boolean
function GList:isVirtual () end
---* 
---@return int
function GList:getSelectedIndex () end
---* 
---@param result array_table
---@return self
function GList:getSelection (result) end
---* 
---@param index int
---@return int
function GList:itemIndexToChildIndex (index) end
---* 
---@return fgui.GObjectPool
function GList:getItemPool () end
---* 
---@return fgui.GController
function GList:getSelectionController () end
---* 
---@return int
function GList:getLineGap () end
---* 
---@param index int
---@param ani boolean
---@param setFirst boolean
---@return self
function GList:scrollToView (index,ani,setFirst) end
---* 
---@param dir int
---@return self
function GList:handleArrowKey (dir) end
---* 
---@return int
function GList:getAlign () end
---@overload fun(string:string):self
---@overload fun():self
---@param url string
---@return fgui.GObject
function GList:getFromPool (url) end
---* 
---@return string
function GList:getDefaultItem () end
---* 
---@return int
function GList:getSelectionMode () end
---* 
---@param value string
---@return self
function GList:setDefaultItem (value) end
---* 
---@param value int
---@return self
function GList:setSelectedIndex (value) end
---* 
---@param value int
---@return self
function GList:setSelectionMode (value) end
---* 
---@param index int
---@param scrollItToView boolean
---@return self
function GList:addSelection (index,scrollItToView) end
---* 
---@param index int
---@return int
function GList:childIndexToItemIndex (index) end
---* 
---@return boolean
function GList:getAutoResizeItem () end
---* 
---@param isEnabled boolean
---@return self
function GList:setScrollItemToViewEnabled (isEnabled) end
---* 
---@param value int
---@return self
function GList:setLineGap (value) end
---* 
---@param child fgui.GObject
---@return self
function GList:removeChildToPool (child) end
---* 
---@return int
function GList:getLayout () end
---* 
---@return self
function GList:create () end
---* 
---@param child fgui.GObject
---@param index int
---@return fgui.GObject
function GList:addChildAt (child,index) end
---* 
---@param pt vec2_table
---@return vec2_table
function GList:getSnappingPosition (pt) end
---* 
---@param index int
---@return self
function GList:removeChildAt (index) end
---* 
---@return int
function GList:getFirstChildInView () end
---* 
---@return self
function GList:GList () end