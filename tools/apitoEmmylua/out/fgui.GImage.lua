
---@class fgui.GImage :fgui.GObject
local GImage={ }
fgui.GImage=GImage




---* 
---@param value int
---@return self
function GImage:setFillMethod (value) end
---* 
---@param value boolean
---@return self
function GImage:setFillClockwise (value) end
---* 
---@param value color3b_table
---@return self
function GImage:setColor (value) end
---* 
---@return color3b_table
function GImage:getColor () end
---* 
---@return int
function GImage:getFlip () end
---* 
---@return int
function GImage:getFillMethod () end
---* 
---@param value int
---@return self
function GImage:setFlip (value) end
---* 
---@param value float
---@return self
function GImage:setFillAmount (value) end
---* 
---@return boolean
function GImage:isFillClockwise () end
---* 
---@return float
function GImage:getFillAmount () end
---* 
---@return int
function GImage:getFillOrigin () end
---* 
---@param value int
---@return self
function GImage:setFillOrigin (value) end
---* 
---@return self
function GImage:create () end
---* 
---@param propId int
---@return cc.Value
function GImage:getProp (propId) end
---* 
---@return self
function GImage:constructFromResource () end
---* 
---@param propId int
---@param value cc.Value
---@return self
function GImage:setProp (propId,value) end
---* 
---@return self
function GImage:GImage () end