
---@class fgui.GTween 
local GTween={ }
fgui.GTween=GTween




---@overload fun(cc.Ref:cc.Ref,int:int):self
---@overload fun(cc.Ref:cc.Ref):self
---@param target cc.Ref
---@param propType int
---@return fgui.GTweener
function GTween:getTween (target,propType) end
---@overload fun(cc.Ref:cc.Ref,int:int):self
---@overload fun(cc.Ref:cc.Ref):self
---@param target cc.Ref
---@param propType int
---@return boolean
function GTween:isTweening (target,propType) end
---* 
---@param delay float
---@return fgui.GTweener
function GTween:delayedCall (delay) end
---@overload fun(color4b_table0:vec2_table,color4b_table1:vec2_table,float:float):self
---@overload fun(color4b_table0:float,color4b_table1:float,float:float):self
---@overload fun(color4b_table0:vec3_table,color4b_table1:vec3_table,float:float):self
---@overload fun(color4b_table0:vec4_table,color4b_table1:vec4_table,float:float):self
---@overload fun(color4b_table:color4b_table,color4b_table:color4b_table,float:float):self
---@param startValue color4b_table
---@param endValue color4b_table
---@param duration float
---@return fgui.GTweener
function GTween:to (startValue,endValue,duration) end
---* 
---@param startValue double
---@param endValue double
---@param duration float
---@return fgui.GTweener
function GTween:toDouble (startValue,endValue,duration) end
---* 
---@return self
function GTween:clean () end
---* 
---@param startValue vec2_table
---@param amplitude float
---@param duration float
---@return fgui.GTweener
function GTween:shake (startValue,amplitude,duration) end
---@overload fun(cc.Ref:cc.Ref,int1:boolean):self
---@overload fun(cc.Ref:cc.Ref):self
---@overload fun(cc.Ref:cc.Ref,int:int,boolean:boolean):self
---@param target cc.Ref
---@param propType int
---@param complete boolean
---@return self
function GTween:kill (target,propType,complete) end