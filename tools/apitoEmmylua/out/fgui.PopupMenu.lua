
---@class fgui.PopupMenu :cc.Ref
local PopupMenu={ }
fgui.PopupMenu=PopupMenu




---* 
---@param name string
---@param grayed boolean
---@return self
function PopupMenu:setItemGrayed (name,grayed) end
---* 
---@param index int
---@return string
function PopupMenu:getItemName (index) end
---* 
---@return self
function PopupMenu:clearItems () end
---* 
---@return fgui.GList
function PopupMenu:getList () end
---* 
---@param name string
---@return boolean
function PopupMenu:removeItem (name) end
---* 
---@return self
function PopupMenu:addSeperator () end
---* 
---@param name string
---@param caption string
---@return self
function PopupMenu:setItemText (name,caption) end
---* 
---@param name string
---@param check boolean
---@return self
function PopupMenu:setItemChecked (name,check) end
---@overload fun(fgui.GObject:fgui.GObject,int:int):self
---@overload fun():self
---@param target fgui.GObject
---@param dir int
---@return self
function PopupMenu:show (target,dir) end
---* 
---@return fgui.GComponent
function PopupMenu:getContentPane () end
---* 
---@return int
function PopupMenu:getItemCount () end
---* 
---@param name string
---@param checkable boolean
---@return self
function PopupMenu:setItemCheckable (name,checkable) end
---* 
---@param name string
---@return boolean
function PopupMenu:isItemChecked (name) end
---* 
---@param name string
---@param visible boolean
---@return self
function PopupMenu:setItemVisible (name,visible) end
---@overload fun():self
---@overload fun(string:string):self
---@param resourceURL string
---@return self
function PopupMenu:create (resourceURL) end
---* 
---@return self
function PopupMenu:PopupMenu () end