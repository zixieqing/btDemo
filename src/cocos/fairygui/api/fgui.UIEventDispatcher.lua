
---@class fgui.UIEventDispatcher :cc.Ref
local UIEventDispatcher={ }
fgui.UIEventDispatcher=UIEventDispatcher




---* 
---@param eventType int
---@return boolean
function UIEventDispatcher:isDispatchingEvent (eventType) end
---* 
---@return self
function UIEventDispatcher:removeEventListeners () end
---* 
---@param eventType int
---@param data void
---@param dataValue cc.Value
---@return boolean
function UIEventDispatcher:bubbleEvent (eventType,data,dataValue) end
---* 
---@return self
function UIEventDispatcher:UIEventDispatcher () end