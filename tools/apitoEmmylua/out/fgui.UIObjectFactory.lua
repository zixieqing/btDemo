
---@class fgui.UIObjectFactory 
local UIObjectFactory={ }
fgui.UIObjectFactory=UIObjectFactory




---@overload fun(fgui.PackageItem0:int):fgui.GObject
---@overload fun(fgui.PackageItem:fgui.PackageItem):fgui.GObject
---@param pi fgui.PackageItem
---@return fgui.GObject
function UIObjectFactory:newObject (pi) end