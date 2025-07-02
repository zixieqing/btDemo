
---@class fgui.GTweener :cc.Ref
local GTweener={ }
fgui.GTweener=GTweener




---* 
---@param value float
---@return self
function GTweener:setTimeScale (value) end
---* 
---@return int
function GTweener:getRepeat () end
---* 
---@param value int
---@return self
function GTweener:setEase (value) end
---* 
---@return float
function GTweener:getDuration () end
---* 
---@return void
function GTweener:getTarget () end
---* 
---@return self
function GTweener:kill () end
---* 
---@return boolean
function GTweener:allCompleted () end
---* 
---@param time float
---@return self
function GTweener:seek (time) end
---* 
---@param value float
---@return self
function GTweener:setDelay (value) end
---* 
---@return cc.Value
function GTweener:getUserData () end
---* 
---@param _repeat int
---@param yoyo boolean
---@return self
function GTweener:setRepeat (_repeat,yoyo) end
---* 
---@param value float
---@return self
function GTweener:setBreakpoint (value) end
---* 
---@param value float
---@return self
function GTweener:setEasePeriod (value) end
---* 
---@param path fgui.GPath
---@return self
function GTweener:setPath (path) end
---* 
---@return boolean
function GTweener:isCompleted () end
---* 
---@return float
function GTweener:getNormalizedTime () end
---@overload fun(cc.Ref:cc.Ref,int:int):self
---@overload fun(cc.Ref:cc.Ref):self
---@param target cc.Ref
---@param propType int
---@return self
function GTweener:setTarget (target,propType) end
---* 
---@param value float
---@return self
function GTweener:setEaseOvershootOrAmplitude (value) end
---* 
---@param value boolean
---@return self
function GTweener:setSnapping (value) end
---* 
---@param value void
---@return self
function GTweener:setTargetAny (value) end
---* 
---@return float
function GTweener:getDelay () end
---* 
---@param value cc.Value
---@return self
function GTweener:setUserData (value) end
---* 
---@param value float
---@return self
function GTweener:setDuration (value) end
---* 
---@param paused boolean
---@return self
function GTweener:setPaused (paused) end
---* 
---@return self
function GTweener:GTweener () end