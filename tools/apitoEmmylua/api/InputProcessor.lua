
--------------------------------
-- @module InputProcessor
-- @parent_module fgui

--------------------------------
-- 
-- @function [parent=#InputProcessor] simulateClick 
-- @param self
-- @param #fgui.GObject target
-- @param #int touchId
-- @return InputProcessor#InputProcessor self (return value: fgui.InputProcessor)
        
--------------------------------
-- 
-- @function [parent=#InputProcessor] cancelClick 
-- @param self
-- @param #int touchId
-- @return InputProcessor#InputProcessor self (return value: fgui.InputProcessor)
        
--------------------------------
-- 
-- @function [parent=#InputProcessor] addTouchMonitor 
-- @param self
-- @param #int touchId
-- @param #fgui.GObject target
-- @return InputProcessor#InputProcessor self (return value: fgui.InputProcessor)
        
--------------------------------
-- 
-- @function [parent=#InputProcessor] disableDefaultTouchEvent 
-- @param self
-- @return InputProcessor#InputProcessor self (return value: fgui.InputProcessor)
        
--------------------------------
-- 
-- @function [parent=#InputProcessor] getTouchPosition 
-- @param self
-- @param #int touchId
-- @return vec2_table#vec2_table ret (return value: vec2_table)
        
--------------------------------
-- 
-- @function [parent=#InputProcessor] touchUp 
-- @param self
-- @param #cc.Touch touch
-- @param #cc.Event event
-- @return InputProcessor#InputProcessor self (return value: fgui.InputProcessor)
        
--------------------------------
-- 
-- @function [parent=#InputProcessor] touchMove 
-- @param self
-- @param #cc.Touch touch
-- @param #cc.Event event
-- @return InputProcessor#InputProcessor self (return value: fgui.InputProcessor)
        
--------------------------------
-- 
-- @function [parent=#InputProcessor] setCaptureCallback 
-- @param self
-- @param #function value
-- @return InputProcessor#InputProcessor self (return value: fgui.InputProcessor)
        
--------------------------------
-- 
-- @function [parent=#InputProcessor] removeTouchMonitor 
-- @param self
-- @param #fgui.GObject target
-- @return InputProcessor#InputProcessor self (return value: fgui.InputProcessor)
        
--------------------------------
-- 
-- @function [parent=#InputProcessor] touchDown 
-- @param self
-- @param #cc.Touch touch
-- @param #cc.Event event
-- @return bool#bool ret (return value: bool)
        
--------------------------------
-- 
-- @function [parent=#InputProcessor] getRecentInput 
-- @param self
-- @return InputEvent#InputEvent ret (return value: fgui.InputEvent)
        
--------------------------------
-- 
-- @function [parent=#InputProcessor] isTouchOnUI 
-- @param self
-- @return bool#bool ret (return value: bool)
        
--------------------------------
-- 
-- @function [parent=#InputProcessor] InputProcessor 
-- @param self
-- @param #fgui.GComponent owner
-- @return InputProcessor#InputProcessor self (return value: fgui.InputProcessor)
        
return nil
