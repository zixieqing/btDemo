
---@class fgui.GComponent :fgui.GObject
local GComponent={ }
fgui.GComponent=GComponent




---* 
---@param child fgui.GObject
---@return fgui.GObject
function GComponent:addChild (child) end
---* 
---@return fgui.IHitTest
function GComponent:getHitArea () end
---* 
---@return self
function GComponent:applyAllControllers () end
---* 
---@return boolean
function GComponent:getOpaque () end
---* 
---@param value int
---@return self
function GComponent:setChildrenRenderOrder (value) end
---* 
---@param value boolean
---@return self
function GComponent:setOpaque (value) end
---* 
---@return float
function GComponent:getViewWidth () end
---* 
---@return array_table
function GComponent:getTransitions () end
---* 
---@return float
function GComponent:getViewHeight () end
---* 
---@return self
function GComponent:ensureBoundsCorrect () end
---* 
---@param obj fgui.GObject
---@return boolean
function GComponent:isAncestorOf (obj) end
---* 
---@return array_table
function GComponent:getChildren () end
---* 
---@return cc.Node
function GComponent:getMask () end
---* 
---@param obj fgui.GObject
---@param c fgui.GController
---@return self
function GComponent:adjustRadioGroupDepth (obj,c) end
---* 
---@param name string
---@return fgui.GController
function GComponent:getController (name) end
---* 
---@param value int
---@return self
function GComponent:setApexIndex (value) end
---* 
---@param name string
---@return fgui.Transition
function GComponent:getTransition (name) end
---* 
---@return int
function GComponent:getFirstChildInView () end
---* 
---@param child fgui.GObject
---@return boolean
function GComponent:isChildInView (child) end
---* 
---@return self
function GComponent:setBoundsChangedFlag () end
---* 
---@param child fgui.GObject
---@param index int
---@return fgui.GObject
function GComponent:addChildAt (child,index) end
---@overload fun(int:int,int:int):self
---@overload fun():self
---@param beginIndex int
---@param endIndex int
---@return self
function GComponent:removeChildren (beginIndex,endIndex) end
---* 
---@param index int
---@return self
function GComponent:removeChildAt (index) end
---* 
---@param name string
---@return fgui.GObject
function GComponent:getChild (name) end
---* 
---@param c fgui.GController
---@return self
function GComponent:addController (c) end
---* 
---@param child fgui.GObject
---@param oldValue int
---@param newValue int
---@return self
function GComponent:childSortingOrderChanged (child,oldValue,newValue) end
---* 
---@param c fgui.GController
---@return self
function GComponent:applyController (c) end
---* 
---@return array_table
function GComponent:getControllers () end
---* 
---@param value cc.Node
---@param inverted boolean
---@return self
function GComponent:setMask (value,inverted) end
---* 
---@param child fgui.GObject
---@param index int
---@return self
function GComponent:setChildIndex (child,index) end
---* 
---@param value float
---@return self
function GComponent:setViewWidth (value) end
---* 
---@param id string
---@return fgui.GObject
function GComponent:getChildById (id) end
---* 
---@param child fgui.GObject
---@return int
function GComponent:getChildIndex (child) end
---* 
---@param index int
---@return fgui.GController
function GComponent:getControllerAt (index) end
---* 
---@param pt vec2_table
---@return vec2_table
function GComponent:getSnappingPosition (pt) end
---* 
---@param index int
---@return fgui.GObject
function GComponent:getChildAt (index) end
---* 
---@return int
function GComponent:getApexIndex () end
---* 
---@return fgui.ScrollPane
function GComponent:getScrollPane () end
---* 
---@param index int
---@return fgui.Transition
function GComponent:getTransitionAt (index) end
---* 
---@param group fgui.GGroup
---@param name string
---@return fgui.GObject
function GComponent:getChildInGroup (group,name) end
---* 
---@param c fgui.GController
---@return self
function GComponent:removeController (c) end
---* 
---@param path string
---@return fgui.GObject
function GComponent:getChildByPath (path) end
---* 
---@param child fgui.GObject
---@param index int
---@return int
function GComponent:setChildIndexBefore (child,index) end
---* 
---@param value fgui.IHitTest
---@return self
function GComponent:setHitArea (value) end
---* 
---@param component fgui.GComponent
---@param action int
---@return boolean
function GComponent:sendEventToLua (component,action) end
---* 
---@param index1 int
---@param index2 int
---@return self
function GComponent:swapChildrenAt (index1,index2) end
---* 
---@return int
function GComponent:numChildren () end
---* 
---@return string
function GComponent:getBaseUserData () end
---* 
---@param child fgui.GObject
---@return self
function GComponent:removeChild (child) end
---* 
---@param child1 fgui.GObject
---@param child2 fgui.GObject
---@return self
function GComponent:swapChildren (child1,child2) end
---* 
---@param child fgui.GObject
---@return self
function GComponent:childStateChanged (child) end
---* 
---@return int
function GComponent:getChildrenRenderOrder () end
---* 
---@param value float
---@return self
function GComponent:setViewHeight (value) end
---* 
---@return self
function GComponent:create () end
---* 
---@param worldPoint vec2_table
---@param camera cc.Camera
---@return fgui.GObject
function GComponent:hitTest (worldPoint,camera) end
---* 
---@return self
function GComponent:GComponent () end