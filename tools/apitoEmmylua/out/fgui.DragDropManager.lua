
---@class fgui.DragDropManager 
local DragDropManager={ }
fgui.DragDropManager=DragDropManager




---* 
---@return self
function DragDropManager:cancel () end
---* 
---@return boolean
function DragDropManager:isDragging () end
---* 
---@return fgui.GLoader
function DragDropManager:getAgent () end
---* 
---@param icon string
---@param sourceData cc.Value
---@param touchPointID int
---@return self
function DragDropManager:startDrag (icon,sourceData,touchPointID) end
---* 
---@return self
function DragDropManager:getInstance () end
---* 
---@return self
function DragDropManager:DragDropManager () end