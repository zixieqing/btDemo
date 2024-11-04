
---@class fgui.EventContext 
local EventContext={ }
fgui.EventContext=EventContext




---* 
---@return self
function EventContext:preventDefault () end
---* 
---@return boolean
function EventContext:isDefaultPrevented () end
---* 
---@return int
function EventContext:getType () end
---* 
---@return cc.Ref
function EventContext:getSender () end
---* 
---@return self
function EventContext:uncaptureTouch () end
---* 
---@return fgui.InputEvent
function EventContext:getInput () end
---* 
---@return self
function EventContext:captureTouch () end
---* 
---@return self
function EventContext:stopPropagation () end
---* 
---@return self
function EventContext:EventContext () end