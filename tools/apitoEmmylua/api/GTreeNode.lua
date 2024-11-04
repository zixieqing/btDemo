
--------------------------------
-- @module GTreeNode
-- @extend Ref
-- @parent_module fgui

--------------------------------
-- 
-- @function [parent=#GTreeNode] addChild 
-- @param self
-- @param #fgui.GTreeNode child
-- @return GTreeNode#GTreeNode ret (return value: fgui.GTreeNode)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] setExpaned 
-- @param self
-- @param #bool value
-- @return GTreeNode#GTreeNode self (return value: fgui.GTreeNode)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] isFolder 
-- @param self
-- @return bool#bool ret (return value: bool)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] getText 
-- @param self
-- @return string#string ret (return value: string)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] setChildIndex 
-- @param self
-- @param #fgui.GTreeNode child
-- @param #int index
-- @return GTreeNode#GTreeNode self (return value: fgui.GTreeNode)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] getNextSibling 
-- @param self
-- @return GTreeNode#GTreeNode ret (return value: fgui.GTreeNode)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] addChildAt 
-- @param self
-- @param #fgui.GTreeNode child
-- @param #int index
-- @return GTreeNode#GTreeNode ret (return value: fgui.GTreeNode)
        
--------------------------------
-- @overload self, int, int         
-- @overload self         
-- @function [parent=#GTreeNode] removeChildren
-- @param self
-- @param #int beginIndex
-- @param #int endIndex
-- @return GTreeNode#GTreeNode self (return value: fgui.GTreeNode)

--------------------------------
-- 
-- @function [parent=#GTreeNode] removeChildAt 
-- @param self
-- @param #int index
-- @return GTreeNode#GTreeNode self (return value: fgui.GTreeNode)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] getCell 
-- @param self
-- @return GComponent#GComponent ret (return value: fgui.GComponent)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] getData 
-- @param self
-- @return Value#Value ret (return value: cc.Value)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] setIcon 
-- @param self
-- @param #string value
-- @return GTreeNode#GTreeNode self (return value: fgui.GTreeNode)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] setData 
-- @param self
-- @param #cc.Value value
-- @return GTreeNode#GTreeNode self (return value: fgui.GTreeNode)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] getTree 
-- @param self
-- @return GTree#GTree ret (return value: fgui.GTree)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] getChildIndex 
-- @param self
-- @param #fgui.GTreeNode child
-- @return int#int ret (return value: int)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] getChildAt 
-- @param self
-- @param #int index
-- @return GTreeNode#GTreeNode ret (return value: fgui.GTreeNode)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] getPrevSibling 
-- @param self
-- @return GTreeNode#GTreeNode ret (return value: fgui.GTreeNode)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] isExpanded 
-- @param self
-- @return bool#bool ret (return value: bool)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] setChildIndexBefore 
-- @param self
-- @param #fgui.GTreeNode child
-- @param #int index
-- @return int#int ret (return value: int)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] getParent 
-- @param self
-- @return GTreeNode#GTreeNode ret (return value: fgui.GTreeNode)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] getIcon 
-- @param self
-- @return string#string ret (return value: string)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] setText 
-- @param self
-- @param #string value
-- @return GTreeNode#GTreeNode self (return value: fgui.GTreeNode)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] swapChildrenAt 
-- @param self
-- @param #int index1
-- @param #int index2
-- @return GTreeNode#GTreeNode self (return value: fgui.GTreeNode)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] numChildren 
-- @param self
-- @return int#int ret (return value: int)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] removeChild 
-- @param self
-- @param #fgui.GTreeNode child
-- @return GTreeNode#GTreeNode self (return value: fgui.GTreeNode)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] swapChildren 
-- @param self
-- @param #fgui.GTreeNode child1
-- @param #fgui.GTreeNode child2
-- @return GTreeNode#GTreeNode self (return value: fgui.GTreeNode)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] create 
-- @param self
-- @return GTreeNode#GTreeNode ret (return value: fgui.GTreeNode)
        
--------------------------------
-- 
-- @function [parent=#GTreeNode] GTreeNode 
-- @param self
-- @return GTreeNode#GTreeNode self (return value: fgui.GTreeNode)
        
return nil
