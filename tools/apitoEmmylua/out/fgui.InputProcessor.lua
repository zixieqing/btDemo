
---@class fgui.InputProcessor 
local InputProcessor={ }
fgui.InputProcessor=InputProcessor




---* 
---@param target fgui.GObject
---@param touchId int
---@return self
function InputProcessor:simulateClick (target,touchId) end
---* 
---@param touchId int
---@return self
function InputProcessor:cancelClick (touchId) end
---* 
---@param touchId int
---@param target fgui.GObject
---@return self
function InputProcessor:addTouchMonitor (touchId,target) end
---* 
---@return self
function InputProcessor:disableDefaultTouchEvent () end
---* 
---@param touchId int
---@return vec2_table
function InputProcessor:getTouchPosition (touchId) end
---* 
---@param touch cc.Touch
---@param event cc.Event
---@return self
function InputProcessor:touchUp (touch,event) end
---* 
---@param touch cc.Touch
---@param event cc.Event
---@return self
function InputProcessor:touchMove (touch,event) end
---* 
---@param value function
---@return self
function InputProcessor:setCaptureCallback (value) end
---* 
---@param target fgui.GObject
---@return self
function InputProcessor:removeTouchMonitor (target) end
---* 
---@param touch cc.Touch
---@param event cc.Event
---@return boolean
function InputProcessor:touchDown (touch,event) end
---* 
---@return fgui.InputEvent
function InputProcessor:getRecentInput () end
---* 
---@return boolean
function InputProcessor:isTouchOnUI () end
---* 
---@param owner fgui.GComponent
---@return self
function InputProcessor:InputProcessor (owner) end