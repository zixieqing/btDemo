
---@class fgui.GTree :fgui.GList
local GTree={ }
fgui.GTree=GTree




---* 
---@return fgui.GTreeNode
function GTree:getSelectedNode () end
---* 
---@param folderNode fgui.GTreeNode
---@return self
function GTree:expandAll (folderNode) end
---* 
---@return int
function GTree:getClickToExpand () end
---* 
---@param value int
---@return self
function GTree:setClickToExpand (value) end
---* 
---@param value int
---@return self
function GTree:setIndent (value) end
---* 
---@return int
function GTree:getIndent () end
---* 
---@param folderNode fgui.GTreeNode
---@return self
function GTree:collapseAll (folderNode) end
---* 
---@return fgui.GTreeNode
function GTree:getRootNode () end
---* 
---@param node fgui.GTreeNode
---@param scrollItToView boolean
---@return self
function GTree:selectNode (node,scrollItToView) end
---* 
---@param node fgui.GTreeNode
---@return self
function GTree:unselectNode (node) end
---* 
---@return self
function GTree:create () end
---* 
---@return self
function GTree:GTree () end