
---@class fgui.GBasicTextField :fgui.GTextField
local GBasicTextField={ }
fgui.GBasicTextField=GBasicTextField




---* 
---@return self
function GBasicTextField:create () end
---* 
---@param value int
---@return self
function GBasicTextField:setAutoSize (value) end
---* 
---@return self
function GBasicTextField:applyTextFormat () end
---* 
---@return fgui.TextFormat
function GBasicTextField:getTextFormat () end
---* 
---@return boolean
function GBasicTextField:isSingleLine () end
---* 
---@param value boolean
---@return self
function GBasicTextField:setSingleLine (value) end
---* 
---@return self
function GBasicTextField:GBasicTextField () end