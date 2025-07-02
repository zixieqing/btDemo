
---@class fgui.GGraph :fgui.GObject
local GGraph={ }
fgui.GGraph=GGraph




---* 
---@param aWidth float
---@param aHeight float
---@param lineSize int
---@param lineColor color4f_table
---@param fillColor color4f_table
---@return self
function GGraph:drawEllipse (aWidth,aHeight,lineSize,lineColor,fillColor) end
---* 
---@param value color3b_table
---@return self
function GGraph:setColor (value) end
---* 
---@param lineSize int
---@param lineColor color4f_table
---@param fillColor color4f_table
---@param points vec2_table
---@param count int
---@return self
function GGraph:drawPolygon (lineSize,lineColor,fillColor,points,count) end
---* 
---@return color3b_table
function GGraph:getColor () end
---* 
---@param lineSize int
---@param lineColor color4f_table
---@param fillColor color4f_table
---@param sides int
---@param startAngle float
---@param distances float
---@param distanceCount int
---@return self
function GGraph:drawRegularPolygon (lineSize,lineColor,fillColor,sides,startAngle,distances,distanceCount) end
---* 
---@return boolean
function GGraph:isEmpty () end
---* 
---@param aWidth float
---@param aHeight float
---@param lineSize int
---@param lineColor color4f_table
---@param fillColor color4f_table
---@return self
function GGraph:drawRect (aWidth,aHeight,lineSize,lineColor,fillColor) end
---* 
---@return self
function GGraph:create () end
---* 
---@param propId int
---@return cc.Value
function GGraph:getProp (propId) end
---* 
---@param propId int
---@param value cc.Value
---@return self
function GGraph:setProp (propId,value) end
---* 
---@return self
function GGraph:GGraph () end