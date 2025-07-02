
---@class fgui.GObjectPool 
local GObjectPool={ }
fgui.GObjectPool=GObjectPool




---* 
---@param url string
---@return fgui.GObject
function GObjectPool:getObject (url) end
---* 
---@param obj fgui.GObject
---@return self
function GObjectPool:returnObject (obj) end
---* 
---@return self
function GObjectPool:GObjectPool () end