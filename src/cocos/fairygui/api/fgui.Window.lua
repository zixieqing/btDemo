
---@class fgui.Window :fgui.GComponent
local Window={ }
fgui.Window=Window




---* 
---@return fgui.GObject
function Window:getCloseButton () end
---* 
---@return fgui.GComponent
function Window:getContentPane () end
---* 
---@return self
function Window:show () end
---* 
---@return boolean
function Window:isTop () end
---* 
---@return self
function Window:hideImmediately () end
---* 
---@return self
function Window:toggleStatus () end
---* 
---@return self
function Window:hide () end
---* 
---@return fgui.GComponent
function Window:getFrame () end
---* 
---@return boolean
function Window:isShowing () end
---@overload fun(int:int):self
---@overload fun():self
---@param requestingCmd int
---@return boolean
function Window:closeModalWait (requestingCmd) end
---* 
---@return self
function Window:initWindow () end
---* 
---@param value fgui.GObject
---@return self
function Window:setContentArea (value) end
---* 
---@param value fgui.GObject
---@return self
function Window:setDragArea (value) end
---* 
---@param value fgui.GComponent
---@return self
function Window:setContentPane (value) end
---* 
---@return boolean
function Window:isModal () end
---* 
---@return boolean
function Window:isBringToFrontOnClick () end
---* 
---@return fgui.GObject
function Window:getContentArea () end
---* 
---@param value boolean
---@return self
function Window:setBringToFrontOnClick (value) end
---* 
---@param value boolean
---@return self
function Window:setModal (value) end
---* 
---@return fgui.GObject
function Window:getModalWaitingPane () end
---* 
---@return fgui.GObject
function Window:getDragArea () end
---* 
---@return self
function Window:bringToFront () end
---@overload fun(int:int):self
---@overload fun():self
---@param requestingCmd int
---@return self
function Window:showModalWait (requestingCmd) end
---* 
---@param value fgui.GObject
---@return self
function Window:setCloseButton (value) end
---* 
---@param uiSource fgui.IUISource
---@return self
function Window:addUISource (uiSource) end
---* 
---@return self
function Window:create () end
---* 
---@return self
function Window:Window () end