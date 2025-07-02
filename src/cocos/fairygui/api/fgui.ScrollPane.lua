
---@class fgui.ScrollPane :cc.Ref
local ScrollPane={ }
fgui.ScrollPane=ScrollPane




---* 
---@param value boolean
---@return self
function ScrollPane:setBouncebackEffect (value) end
---* 
---@return fgui.GScrollBar
function ScrollPane:getHzScrollBar () end
---@overload fun(fgui.GObject0:rect_table,boolean:boolean,boolean:boolean):self
---@overload fun(fgui.GObject:fgui.GObject,boolean:boolean,boolean:boolean):self
---@param obj fgui.GObject
---@param ani boolean
---@param setFirst boolean
---@return self
function ScrollPane:scrollToView (obj,ani,setFirst) end
---* 
---@return float
function ScrollPane:getDecelerationRate () end
---* 
---@return float
function ScrollPane:getPercX () end
---* 
---@return float
function ScrollPane:getPosY () end
---* 
---@return fgui.GComponent
function ScrollPane:getFooter () end
---* 
---@param value float
---@param ani boolean
---@return self
function ScrollPane:setPosX (value,ani) end
---* 
---@return float
function ScrollPane:getPosX () end
---* 
---@param value int
---@param ani boolean
---@return self
function ScrollPane:setPageY (value,ani) end
---* 
---@return self
function ScrollPane:scrollTop () end
---* 
---@return boolean
function ScrollPane:isSnapToItem () end
---* 
---@return boolean
function ScrollPane:isTouchEffect () end
---* 
---@param value float
---@return self
function ScrollPane:setScrollStep (value) end
---* 
---@return self
function ScrollPane:scrollBottom () end
---* 
---@param obj fgui.GObject
---@return boolean
function ScrollPane:isChildInView (obj) end
---* 
---@return boolean
function ScrollPane:isPageMode () end
---* 
---@param value float
---@return self
function ScrollPane:setDecelerationRate (value) end
---* 
---@return float
function ScrollPane:getScrollingPosY () end
---* 
---@return float
function ScrollPane:getScrollingPosX () end
---* 
---@return size_table
function ScrollPane:getContentSize () end
---* 
---@return boolean
function ScrollPane:isRightMost () end
---* 
---@param value fgui.GController
---@return self
function ScrollPane:setPageController (value) end
---* 
---@param size int
---@return self
function ScrollPane:lockHeader (size) end
---* 
---@param size int
---@return self
function ScrollPane:lockFooter (size) end
---* 
---@return self
function ScrollPane:scrollDown () end
---* 
---@param value boolean
---@return self
function ScrollPane:setSnapToItem (value) end
---* 
---@return float
function ScrollPane:getScrollStep () end
---* 
---@return int
function ScrollPane:getPageX () end
---* 
---@return self
function ScrollPane:scrollLeft () end
---* 
---@return size_table
function ScrollPane:getViewSize () end
---* 
---@param value boolean
---@return self
function ScrollPane:setInertiaDisabled (value) end
---* 
---@return fgui.GController
function ScrollPane:getPageController () end
---* 
---@param value int
---@param ani boolean
---@return self
function ScrollPane:setPageX (value,ani) end
---* 
---@return self
function ScrollPane:scrollUp () end
---* 
---@return boolean
function ScrollPane:isMouseWheelEnabled () end
---* 
---@param value boolean
---@return self
function ScrollPane:setPageMode (value) end
---* 
---@param value boolean
---@return self
function ScrollPane:setTouchEffect (value) end
---* 
---@param value boolean
---@return self
function ScrollPane:setMouseWheelEnabled (value) end
---* 
---@return boolean
function ScrollPane:isInertiaDisabled () end
---* 
---@param value float
---@param ani boolean
---@return self
function ScrollPane:setPercX (value,ani) end
---* 
---@param value float
---@param ani boolean
---@return self
function ScrollPane:setPercY (value,ani) end
---* 
---@return self
function ScrollPane:cancelDragging () end
---* 
---@return float
function ScrollPane:getPercY () end
---* 
---@return self
function ScrollPane:scrollRight () end
---* 
---@param buffer fgui.ByteBuffer
---@return self
function ScrollPane:setup (buffer) end
---* 
---@return fgui.GScrollBar
function ScrollPane:getVtScrollBar () end
---* 
---@return fgui.GComponent
function ScrollPane:getOwner () end
---* 
---@return boolean
function ScrollPane:isBottomMost () end
---* 
---@return int
function ScrollPane:getPageY () end
---* 
---@return boolean
function ScrollPane:isBouncebackEffect () end
---* 
---@param value float
---@param ani boolean
---@return self
function ScrollPane:setPosY (value,ani) end
---* 
---@return fgui.GComponent
function ScrollPane:getHeader () end
---* 
---@return self
function ScrollPane:getDraggingPane () end
---* 
---@param owner fgui.GComponent
---@return self
function ScrollPane:ScrollPane (owner) end