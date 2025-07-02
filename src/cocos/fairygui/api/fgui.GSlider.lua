
---@class fgui.GSlider :fgui.GComponent
local GSlider={ }
fgui.GSlider=GSlider




---* 
---@param value double
---@return self
function GSlider:setMin (value) end
---* 
---@param value double
---@return self
function GSlider:setValue (value) end
---* 
---@param value boolean
---@return self
function GSlider:setWholeNumbers (value) end
---* 
---@param value double
---@return self
function GSlider:setMax (value) end
---* 
---@return boolean
function GSlider:getWholeNumbers () end
---* 
---@return double
function GSlider:getValue () end
---* 
---@return int
function GSlider:getTitleType () end
---* 
---@return double
function GSlider:getMin () end
---* 
---@return double
function GSlider:getMax () end
---* 
---@param value int
---@return self
function GSlider:setTitleType (value) end
---* 
---@return self
function GSlider:create () end
---* 
---@return self
function GSlider:GSlider () end