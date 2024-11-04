
---@class fgui.GScrollBar :fgui.GComponent
local GScrollBar={ }
fgui.GScrollBar=GScrollBar




---* 
---@param target fgui.ScrollPane
---@param vertical boolean
---@return self
function GScrollBar:setScrollPane (target,vertical) end
---* 
---@param value float
---@return self
function GScrollBar:setDisplayPerc (value) end
---* 
---@return float
function GScrollBar:getMinSize () end
---* 
---@param value float
---@return self
function GScrollBar:setScrollPerc (value) end
---* 
---@return self
function GScrollBar:create () end
---* 
---@return self
function GScrollBar:GScrollBar () end