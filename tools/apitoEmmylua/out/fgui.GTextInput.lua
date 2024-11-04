
---@class fgui.GTextInput :fgui.GTextField@all parent class: GTextField,EditBoxDelegate
local GTextInput={ }
fgui.GTextInput=GTextInput




---* 
---@param value int
---@return self
function GTextInput:setKeyboardType (value) end
---* 
---@param value string
---@return self
function GTextInput:setPrompt (value) end
---* 
---@param value int
---@return self
function GTextInput:setMaxLength (value) end
---* 
---@param value string
---@return self
function GTextInput:setRestrict (value) end
---* 
---@param value boolean
---@return self
function GTextInput:setPassword (value) end
---* 
---@return self
function GTextInput:create () end
---* 
---@return fgui.TextFormat
function GTextInput:getTextFormat () end
---* 
---@return self
function GTextInput:applyTextFormat () end
---* 
---@return boolean
function GTextInput:isSingleLine () end
---* 
---@param value boolean
---@return self
function GTextInput:setSingleLine (value) end
---* 
---@return self
function GTextInput:GTextInput () end