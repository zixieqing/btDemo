
---@class fgui.InputEvent 
local InputEvent={ }
fgui.InputEvent=InputEvent




---* 
---@return int
function InputEvent:getTouchId () end
---* 
---@return fgui.InputProcessor
function InputEvent:getProcessor () end
---* 
---@return int
function InputEvent:getButton () end
---* 
---@return int
function InputEvent:isDoubleClick () end
---* 
---@return cc.Touch
function InputEvent:getTouch () end
---* 
---@return boolean
function InputEvent:isAltDown () end
---* 
---@return fgui.GObject
function InputEvent:getTarget () end
---* 
---@return int
function InputEvent:getX () end
---* 
---@return int
function InputEvent:getY () end
---* 
---@return int
function InputEvent:getMouseWheelDelta () end
---* 
---@return boolean
function InputEvent:isShiftDown () end
---* 
---@return boolean
function InputEvent:isCtrlDown () end
---* 
---@return int
function InputEvent:getKeyCode () end
---* 
---@return vec2_table
function InputEvent:getPosition () end
---* 
---@return self
function InputEvent:InputEvent () end