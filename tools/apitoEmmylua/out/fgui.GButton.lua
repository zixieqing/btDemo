
---@class fgui.GButton :fgui.GComponent
local GButton={ }
fgui.GButton=GButton




---* 
---@return fgui.GController
function GButton:getRelatedController () end
---* 
---@param value boolean
---@return self
function GButton:setChangeStateOnClick (value) end
---* 
---@param value string
---@return self
function GButton:setSelectedTitle (value) end
---* 
---@param value boolean
---@return self
function GButton:setSelected (value) end
---* 
---@param c fgui.GController
---@return self
function GButton:setRelatedController (c) end
---* 
---@param value string
---@return self
function GButton:setTitle (value) end
---* 
---@return int
function GButton:getTitleFontSize () end
---* 
---@return string
function GButton:getSelectedIcon () end
---* 
---@return boolean
function GButton:isSelected () end
---* 
---@return color3b_table
function GButton:getTitleColor () end
---* 
---@return string
function GButton:getSelectedTitle () end
---* 
---@return string
function GButton:getTitle () end
---* 
---@param value string
---@return self
function GButton:setSelectedIcon (value) end
---* 
---@return fgui.GTextField
function GButton:getTextField () end
---* 
---@return boolean
function GButton:isChangeStateOnClick () end
---* 
---@param value int
---@return self
function GButton:setTitleFontSize (value) end
---* 
---@param value color3b_table
---@return self
function GButton:setTitleColor (value) end
---* 
---@return self
function GButton:create () end
---* 
---@param propId int
---@return cc.Value
function GButton:getProp (propId) end
---* 
---@return string
function GButton:getIcon () end
---* 
---@param value string
---@return self
function GButton:setText (value) end
---* 
---@param propId int
---@param value cc.Value
---@return self
function GButton:setProp (propId,value) end
---* 
---@return string
function GButton:getText () end
---* 
---@param value string
---@return self
function GButton:setIcon (value) end
---* 
---@return self
function GButton:GButton () end