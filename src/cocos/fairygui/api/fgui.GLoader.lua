
---@class fgui.GLoader :fgui.GObject
local GLoader={ }
fgui.GLoader=GLoader




---* 
---@return string
function GLoader:getURL () end
---* 
---@return float
function GLoader:getFillAmount () end
---* 
---@return int
function GLoader:getFillOrigin () end
---* 
---@param value int
---@return self
function GLoader:setVerticalAlign (value) end
---* 
---@param value int
---@return self
function GLoader:setFillMethod (value) end
---* 
---@return int
function GLoader:getAlign () end
---* 
---@return int
function GLoader:getFrame () end
---* 
---@return int
function GLoader:getFillMethod () end
---* 
---@return boolean
function GLoader:isFillClockwise () end
---* 
---@return fgui.GComponent
function GLoader:getComponent () end
---* 
---@return size_table
function GLoader:getContentSize () end
---* 
---@param value int
---@return self
function GLoader:setFillOrigin (value) end
---* 
---@return int
function GLoader:getVerticalAlign () end
---* 
---@param value int
---@return self
function GLoader:setAlign (value) end
---* 
---@return color3b_table
function GLoader:getColor () end
---* 
---@param value string
---@return self
function GLoader:setURL (value) end
---* 
---@param value boolean
---@return self
function GLoader:setPlaying (value) end
---* 
---@param value boolean
---@return self
function GLoader:setFillClockwise (value) end
---* 
---@return boolean
function GLoader:isPlaying () end
---* 
---@return boolean
function GLoader:isShrinkOnly () end
---* 
---@param value boolean
---@return self
function GLoader:setAutoSize (value) end
---* 
---@param value boolean
---@return self
function GLoader:setShrinkOnly (value) end
---* 
---@param value color3b_table
---@return self
function GLoader:setColor (value) end
---* 
---@param value int
---@return self
function GLoader:setFrame (value) end
---* 
---@return int
function GLoader:getFill () end
---* 
---@param value float
---@return self
function GLoader:setFillAmount (value) end
---* 
---@return boolean
function GLoader:getAutoSize () end
---* 
---@param value int
---@return self
function GLoader:setFill (value) end
---* 
---@return self
function GLoader:create () end
---* 
---@return string
function GLoader:getIcon () end
---* 
---@param propId int
---@return cc.Value
function GLoader:getProp (propId) end
---* 
---@param propId int
---@param value cc.Value
---@return self
function GLoader:setProp (propId,value) end
---* 
---@param value string
---@return self
function GLoader:setIcon (value) end
---* 
---@return self
function GLoader:GLoader () end