
---@class fgui.HtmlObject 
local HtmlObject={ }
fgui.HtmlObject=HtmlObject




---* 
---@return fgui.HtmlElement
function HtmlObject:getElement () end
---* 
---@return fgui.GObject
function HtmlObject:getUI () end
---* 
---@param owner fgui.FUIRichText
---@param element fgui.HtmlElement
---@return self
function HtmlObject:create (owner,element) end
---* 
---@return self
function HtmlObject:destroy () end
---* 
---@return boolean
function HtmlObject:isHidden () end
---* 
---@return self
function HtmlObject:HtmlObject () end