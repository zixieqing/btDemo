
---@class fgui.GProgressBar :fgui.GComponent
local GProgressBar={ }
fgui.GProgressBar=GProgressBar




---* 
---@param value double
---@return self
function GProgressBar:setMin (value) end
---* 
---@param value double
---@return self
function GProgressBar:setValue (value) end
---* 
---@param value double
---@param duration float
---@return self
function GProgressBar:tweenValue (value,duration) end
---* 
---@param value double
---@return self
function GProgressBar:setMax (value) end
---* 
---@param newValue double
---@return self
function GProgressBar:update (newValue) end
---* 
---@return double
function GProgressBar:getValue () end
---* 
---@return int
function GProgressBar:getTitleType () end
---* 
---@return double
function GProgressBar:getMin () end
---* 
---@return double
function GProgressBar:getMax () end
---* 
---@param value int
---@return self
function GProgressBar:setTitleType (value) end
---* 
---@return self
function GProgressBar:create () end
---* 
---@return self
function GProgressBar:GProgressBar () end