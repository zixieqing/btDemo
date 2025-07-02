
---@class fgui.GRichTextField :fgui.GTextField
local GRichTextField={ }
fgui.GRichTextField=GRichTextField




---* 
---@param name string
---@return fgui.HtmlObject
function GRichTextField:getControl (name) end
---* 
---@return self
function GRichTextField:create () end
---* 
---@param value int
---@return self
function GRichTextField:setAutoSize (value) end
---* 
---@return fgui.TextFormat
function GRichTextField:getTextFormat () end
---* 
---@param value boolean
---@return self
function GRichTextField:setSingleLine (value) end
---* 
---@param worldPoint vec2_table
---@param camera cc.Camera
---@return fgui.GObject
function GRichTextField:hitTest (worldPoint,camera) end
---* 
---@return self
function GRichTextField:applyTextFormat () end
---* 
---@return boolean
function GRichTextField:isSingleLine () end
---* 
---@return self
function GRichTextField:GRichTextField () end