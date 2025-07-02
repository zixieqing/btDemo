
---@class fgui.GObject :fgui.UIEventDispatcher
local GObject={ }
fgui.GObject=GObject




---* 
---@param value fgui.GGroup
---@return self
function GObject:setGroup (value) end
---* 
---@return size_table
function GObject:getSize () end
---* 
---@return int
function GObject:getSortingOrder () end
---* 
---@return boolean
function GObject:isGrayed () end
---* 
---@return fgui.GGroup
function GObject:getGroup () end
---* 
---@return fgui.GTreeNode
function GObject:treeNode () end
---* 
---@param value float
---@return self
function GObject:setRotation (value) end
---* 
---@param value boolean
---@return self
function GObject:setPixelSnapping (value) end
---* 
---@param value float
---@return self
function GObject:setScaleY (value) end
---* 
---@param value float
---@return self
function GObject:setScaleX (value) end
---* 
---@return boolean
function GObject:isPixelSnapping () end
---* 
---@param value boolean
---@return self
function GObject:setDraggable (value) end
---* 
---@param value float
---@return self
function GObject:setYMin (value) end
---* 
---@param value float
---@return self
function GObject:setXMin (value) end
---* 
---@return boolean
function GObject:onStage () end
---* 
---@return string
function GObject:getIcon () end
---* 
---@param xv float
---@param yv float
---@param asAnchor boolean
---@return self
function GObject:setPivot (xv,yv,asAnchor) end
---* 
---@return float
function GObject:getAlpha () end
---* 
---@param value float
---@return self
function GObject:setSkewX (value) end
---* 
---@param value float
---@return self
function GObject:setSkewY (value) end
---* 
---@param wv float
---@param hv float
---@param ignorePivot boolean
---@return self
function GObject:setSize (wv,hv,ignorePivot) end
---* 
---@return string
function GObject:getTooltips () end
---* 
---@return self
function GObject:startDrag () end
---* 
---@return boolean
function GObject:isDraggable () end
---* 
---@param value boolean
---@return self
function GObject:setTouchable (value) end
---@overload fun(vec2_table0:rect_table):self
---@overload fun(vec2_table:vec2_table):self
---@param pt vec2_table
---@return vec2_table
function GObject:globalToLocal (pt) end
---* 
---@return self
function GObject:constructFromResource () end
---* 
---@return unsigned_int
function GObject:addDisplayLock () end
---* 
---@return boolean
function GObject:isTouchable () end
---* 
---@return string
function GObject:getResourceURL () end
---* 
---@return self
function GObject:makeFullScreen () end
---* 
---@return boolean
function GObject:isPivotAsAnchor () end
---* 
---@param xv float
---@param yv float
---@return self
function GObject:setPosition (xv,yv) end
---* 
---@return rect_table
function GObject:getDragBounds () end
---* 
---@param value boolean
---@return self
function GObject:setVisible (value) end
---* 
---@param value cc.Value
---@return self
function GObject:setCustomData (value) end
---* 
---@param index int
---@return fgui.GearBase
function GObject:getGear (index) end
---* 
---@return boolean
function GObject:isVisible () end
---* 
---@return string
function GObject:getText () end
---* 
---@return float
function GObject:getWidth () end
---* 
---@return cc.Node
function GObject:displayObject () end
---* 
---@return float
function GObject:getRotation () end
---* 
---@param value float
---@return self
function GObject:setWidth (value) end
---* 
---@param value string
---@return self
function GObject:setTooltips (value) end
---* 
---@return fgui.PackageItem
function GObject:getPackageItem () end
---* 
---@return fgui.Relations
function GObject:relations () end
---* 
---@return float
function GObject:getSkewX () end
---* 
---@return float
function GObject:getSkewY () end
---* 
---@param token unsigned_int
---@return self
function GObject:releaseDisplayLock (token) end
---* 
---@param value float
---@return self
function GObject:setHeight (value) end
---* 
---@param value boolean
---@return self
function GObject:setGrayed (value) end
---* 
---@return vec2_table
function GObject:getPosition () end
---* 
---@return fgui.GRoot
function GObject:getRoot () end
---* 
---@return fgui.GComponent
function GObject:getParent () end
---* 
---@return cc.Value
function GObject:getCustomData () end
---* 
---@param text string
---@return self
function GObject:setIcon (text) end
---* 
---@param worldPoint vec2_table
---@param camera cc.Camera
---@return self
function GObject:hitTest (worldPoint,camera) end
---* 
---@param value rect_table
---@return self
function GObject:setDragBounds (value) end
---* 
---@return float
function GObject:getXMin () end
---* 
---@param target fgui.GObject
---@param relationType int
---@return self
function GObject:removeRelation (target,relationType) end
---* 
---@param propId int
---@param value cc.Value
---@return self
function GObject:setProp (propId,value) end
---* 
---@param xv float
---@param yv float
---@return self
function GObject:setScale (xv,yv) end
---* 
---@return float
function GObject:getX () end
---* 
---@return float
function GObject:getY () end
---* 
---@return self
function GObject:stopDrag () end
---* 
---@return float
function GObject:getScaleY () end
---* 
---@return float
function GObject:getScaleX () end
---* 
---@return float
function GObject:getHeight () end
---* 
---@param value int
---@return self
function GObject:setSortingOrder (value) end
---* 
---@param value float
---@return self
function GObject:setAlpha (value) end
---@overload fun(vec2_table0:rect_table):self
---@overload fun(vec2_table:vec2_table):self
---@param pt vec2_table
---@return vec2_table
function GObject:localToGlobal (pt) end
---* 
---@param index int
---@param c fgui.GController
---@return boolean
function GObject:checkGearController (index,c) end
---* 
---@param value void
---@return self
function GObject:setData (value) end
---* 
---@param rect rect_table
---@param targetSpace fgui.GObject
---@return rect_table
function GObject:transformRect (rect,targetSpace) end
---* 
---@return self
function GObject:removeFromParent () end
---* 
---@return self
function GObject:findParent () end
---* 
---@return float
function GObject:getYMin () end
---* 
---@return vec2_table
function GObject:getScale () end
---* 
---@param value float
---@return self
function GObject:setX (value) end
---* 
---@param value float
---@return self
function GObject:setY (value) end
---* 
---@param propId int
---@return cc.Value
function GObject:getProp (propId) end
---* 
---@return self
function GObject:center () end
---* 
---@param text string
---@return self
function GObject:setText (text) end
---* 
---@param target fgui.GObject
---@param relationType int
---@param usePercent boolean
---@return self
function GObject:addRelation (target,relationType,usePercent) end
---* 
---@return vec2_table
function GObject:getPivot () end
---* 
---@return self
function GObject:create () end
---* 
---@return self
function GObject:getDraggingObject () end
---* 
---@return self
function GObject:GObject () end