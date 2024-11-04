
---@class cc.CallFunc :cc.ActionInstant
local CallFunc={ }
cc.CallFunc=CallFunc




---*  Executes the callback.
---@return self
function CallFunc:execute () end
---*  Get the selector target.<br>
---* return The selector target.
---@return cc.Ref
function CallFunc:getTargetCallback () end
---*  Set the selector target.<br>
---* param sel The selector target.
---@param sel cc.Ref
---@return self
function CallFunc:setTargetCallback (sel) end
---* 
---@return self
function CallFunc:clone () end
---* param time In seconds.
---@param time float
---@return self
function CallFunc:update (time) end
---* 
---@return self
function CallFunc:reverse () end
---* 
---@return self
function CallFunc:CallFunc () end