
---@class fgui.UIConfig 
local UIConfig={ }
fgui.UIConfig=UIConfig




---* 
---@param aliasName string
---@param realName string
---@return self
function UIConfig:registerFont (aliasName,realName) end
---* 
---@param aliasName string
---@param isTTF boolean
---@return string
function UIConfig:getRealFontName (aliasName,isTTF) end