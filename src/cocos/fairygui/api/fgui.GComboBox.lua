
---@class fgui.GComboBox :fgui.GComponent
local GComboBox={ }
fgui.GComboBox=GComboBox




---* 
---@return self
function GComboBox:refresh () end
---* 
---@param value string
---@return self
function GComboBox:setValue (value) end
---* 
---@param value int
---@return self
function GComboBox:setSelectedIndex (value) end
---* 
---@return array_table
function GComboBox:getItems () end
---* 
---@return int
function GComboBox:getSelectedIndex () end
---* 
---@param value string
---@return self
function GComboBox:setTitle (value) end
---* 
---@return int
function GComboBox:getTitleFontSize () end
---* 
---@return string
function GComboBox:getValue () end
---* 
---@return fgui.GObject
function GComboBox:getDropdown () end
---* 
---@return color3b_table
function GComboBox:getTitleColor () end
---* 
---@return array_table
function GComboBox:getIcons () end
---* 
---@return string
function GComboBox:getTitle () end
---* 
---@return fgui.GController
function GComboBox:getSelectionController () end
---* 
---@return array_table
function GComboBox:getValues () end
---* 
---@param value fgui.GController
---@return self
function GComboBox:setSelectionController (value) end
---* 
---@param value int
---@return self
function GComboBox:setTitleFontSize (value) end
---* 
---@param value color3b_table
---@return self
function GComboBox:setTitleColor (value) end
---* 
---@return fgui.GTextField
function GComboBox:getTextField () end
---* 
---@return self
function GComboBox:create () end
---* 
---@param propId int
---@return cc.Value
function GComboBox:getProp (propId) end
---* 
---@return string
function GComboBox:getIcon () end
---* 
---@param value string
---@return self
function GComboBox:setText (value) end
---* 
---@param propId int
---@param value cc.Value
---@return self
function GComboBox:setProp (propId,value) end
---* 
---@return string
function GComboBox:getText () end
---* 
---@param value string
---@return self
function GComboBox:setIcon (value) end
---* 
---@return self
function GComboBox:GComboBox () end