
---@class fgui.GTextField :fgui.GObject
local GTextField={ }
fgui.GTextField=GTextField




---* 
---@param value int
---@return self
function GTextField:setAutoSize (value) end
---* 
---@return float
function GTextField:getFontSize () end
---* 
---@param value color3b_table
---@return self
function GTextField:setColor (value) end
---* 
---@param value boolean
---@return self
function GTextField:setSingleLine (value) end
---* 
---@return boolean
function GTextField:isUBBEnabled () end
---* 
---@return color3b_table
function GTextField:getColor () end
---* 
---@param value map_table
---@return self
function GTextField:setTemplateVars (value) end
---* 
---@param name string
---@param value cc.Value
---@return self
function GTextField:setVar (name,value) end
---* 
---@return color3b_table
function GTextField:getOutlineColor () end
---* 
---@param value boolean
---@return self
function GTextField:setUBBEnabled (value) end
---* 
---@return map_table
function GTextField:getTemplateVars () end
---* 
---@return int
function GTextField:getAutoSize () end
---* 
---@param value float
---@return self
function GTextField:setFontSize (value) end
---* 
---@return self
function GTextField:flushVars () end
---* 
---@return self
function GTextField:applyTextFormat () end
---* 
---@param value color3b_table
---@return self
function GTextField:setOutlineColor (value) end
---* 
---@return fgui.TextFormat
function GTextField:getTextFormat () end
---* 
---@return boolean
function GTextField:isSingleLine () end
---* 
---@return size_table
function GTextField:getTextSize () end
---* 
---@param propId int
---@return cc.Value
function GTextField:getProp (propId) end
---* 
---@param value string
---@return self
function GTextField:setText (value) end
---* 
---@param propId int
---@param value cc.Value
---@return self
function GTextField:setProp (propId,value) end
---* 
---@return string
function GTextField:getText () end