
---@class fgui.GGroup :fgui.GObject
local GGroup={ }
fgui.GGroup=GGroup




---* 
---@param value boolean
---@return self
function GGroup:setAutoSizeDisabled (value) end
---* 
---@return int
function GGroup:getColumnGap () end
---* 
---@param dw float
---@param dh float
---@return self
function GGroup:resizeChildren (dw,dh) end
---* 
---@return int
function GGroup:getMainGridMinSize () end
---* 
---@param value int
---@return self
function GGroup:setMainGridMinSize (value) end
---* 
---@param value int
---@return self
function GGroup:setLayout (value) end
---* 
---@return int
function GGroup:getMainGridIndex () end
---* 
---@param value int
---@return self
function GGroup:setColumnGap (value) end
---* 
---@return self
function GGroup:setBoundsChangedFlag () end
---* 
---@return boolean
function GGroup:isAutoSizeDisabled () end
---* 
---@param dx float
---@param dy float
---@return self
function GGroup:moveChildren (dx,dy) end
---* 
---@return int
function GGroup:getLineGap () end
---* 
---@param value int
---@return self
function GGroup:setMainGridIndex (value) end
---* 
---@param value boolean
---@return self
function GGroup:setExcludeInvisibles (value) end
---* 
---@param value int
---@return self
function GGroup:setLineGap (value) end
---* 
---@return boolean
function GGroup:isExcludeInvisibles () end
---* 
---@return int
function GGroup:getLayout () end
---* 
---@return self
function GGroup:create () end
---* 
---@return self
function GGroup:GGroup () end