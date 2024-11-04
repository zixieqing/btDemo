
--------------------------------
-- @module GGraph
-- @extend GObject
-- @parent_module fgui

--------------------------------
-- 
-- @function [parent=#GGraph] drawEllipse 
-- @param self
-- @param #float aWidth
-- @param #float aHeight
-- @param #int lineSize
-- @param #color4f_table lineColor
-- @param #color4f_table fillColor
-- @return GGraph#GGraph self (return value: fgui.GGraph)
        
--------------------------------
-- 
-- @function [parent=#GGraph] setColor 
-- @param self
-- @param #color3b_table value
-- @return GGraph#GGraph self (return value: fgui.GGraph)
        
--------------------------------
-- 
-- @function [parent=#GGraph] drawPolygon 
-- @param self
-- @param #int lineSize
-- @param #color4f_table lineColor
-- @param #color4f_table fillColor
-- @param #vec2_table points
-- @param #int count
-- @return GGraph#GGraph self (return value: fgui.GGraph)
        
--------------------------------
-- 
-- @function [parent=#GGraph] getColor 
-- @param self
-- @return color3b_table#color3b_table ret (return value: color3b_table)
        
--------------------------------
-- 
-- @function [parent=#GGraph] drawRegularPolygon 
-- @param self
-- @param #int lineSize
-- @param #color4f_table lineColor
-- @param #color4f_table fillColor
-- @param #int sides
-- @param #float startAngle
-- @param #float distances
-- @param #int distanceCount
-- @return GGraph#GGraph self (return value: fgui.GGraph)
        
--------------------------------
-- 
-- @function [parent=#GGraph] isEmpty 
-- @param self
-- @return bool#bool ret (return value: bool)
        
--------------------------------
-- 
-- @function [parent=#GGraph] drawRect 
-- @param self
-- @param #float aWidth
-- @param #float aHeight
-- @param #int lineSize
-- @param #color4f_table lineColor
-- @param #color4f_table fillColor
-- @return GGraph#GGraph self (return value: fgui.GGraph)
        
--------------------------------
-- 
-- @function [parent=#GGraph] create 
-- @param self
-- @return GGraph#GGraph ret (return value: fgui.GGraph)
        
--------------------------------
-- 
-- @function [parent=#GGraph] getProp 
-- @param self
-- @param #int propId
-- @return Value#Value ret (return value: cc.Value)
        
--------------------------------
-- 
-- @function [parent=#GGraph] setProp 
-- @param self
-- @param #int propId
-- @param #cc.Value value
-- @return GGraph#GGraph self (return value: fgui.GGraph)
        
--------------------------------
-- 
-- @function [parent=#GGraph] GGraph 
-- @param self
-- @return GGraph#GGraph self (return value: fgui.GGraph)
        
return nil
