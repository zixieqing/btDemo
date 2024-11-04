
---@class fgui.GController :fgui.UIEventDispatcher
local GController={ }
fgui.GController=GController




---* 
---@param value string
---@return int
function GController:getPageIndexById (value) end
---* 
---@param value string
---@param triggerEvent boolean
---@return self
function GController:setSelectedPage (value,triggerEvent) end
---* 
---@return int
function GController:getPrevisousIndex () end
---* 
---@param value int
---@param triggerEvent boolean
---@return self
function GController:setSelectedIndex (value,triggerEvent) end
---* 
---@param index int
---@return string
function GController:getPageId (index) end
---* 
---@return string
function GController:getSelectedPageId () end
---* 
---@param value fgui.GComponent
---@return self
function GController:setParent (value) end
---* 
---@return self
function GController:runActions () end
---* 
---@param value string
---@return self
function GController:setOppositePageId (value) end
---* 
---@param aName string
---@return boolean
function GController:hasPage (aName) end
---* 
---@param value string
---@return string
function GController:getPageNameById (value) end
---* 
---@return string
function GController:getPreviousPageId () end
---* 
---@return int
function GController:getPageCount () end
---* 
---@return int
function GController:getSelectedIndex () end
---* 
---@return string
function GController:getPreviousPage () end
---* 
---@param value string
---@param triggerEvent boolean
---@return self
function GController:setSelectedPageId (value,triggerEvent) end
---* 
---@return string
function GController:getSelectedPage () end
---* 
---@return fgui.GComponent
function GController:getParent () end
---* 
---@return self
function GController:GController () end