
---@class fgui.GRoot :fgui.GComponent
local GRoot={ }
fgui.GRoot=GRoot




---* 
---@return self
function GRoot:closeAllWindows () end
---* 
---@return self
function GRoot:hideTooltips () end
---* 
---@param pt vec2_table
---@return vec2_table
function GRoot:rootToWorld (pt) end
---* 
---@return boolean
function GRoot:hasAnyPopup () end
---* 
---@return fgui.Window
function GRoot:getTopWindow () end
---@overload fun(fgui.GObject:fgui.GObject):self
---@overload fun():self
---@param popup fgui.GObject
---@return self
function GRoot:hidePopup (popup) end
---* 
---@return self
function GRoot:closeAllExceptModals () end
---* 
---@param pt vec2_table
---@return vec2_table
function GRoot:worldToRoot (pt) end
---@overload fun(fgui.GObject:fgui.GObject,fgui.GObject:fgui.GObject,int:int):self
---@overload fun(fgui.GObject:fgui.GObject):self
---@param popup fgui.GObject
---@param target fgui.GObject
---@param dir int
---@return self
function GRoot:showPopup (popup,target,dir) end
---* 
---@param tooltipWin fgui.GObject
---@return self
function GRoot:showTooltipsWin (tooltipWin) end
---* 
---@return self
function GRoot:closeModalWait () end
---* 
---@return fgui.InputProcessor
function GRoot:getInputProcessor () end
---* 
---@return float
function GRoot:getSoundVolumeScale () end
---@overload fun(fgui.GObject:fgui.GObject,fgui.GObject:fgui.GObject,int:int):self
---@overload fun(fgui.GObject:fgui.GObject):self
---@param popup fgui.GObject
---@param target fgui.GObject
---@param dir int
---@return self
function GRoot:togglePopup (popup,target,dir) end
---* 
---@return boolean
function GRoot:isSoundEnabled () end
---* 
---@param value float
---@return self
function GRoot:setSoundVolumeScale (value) end
---* 
---@return fgui.GObject
function GRoot:getTouchTarget () end
---* 
---@param win fgui.Window
---@return self
function GRoot:hideWindowImmediately (win) end
---* 
---@return fgui.GGraph
function GRoot:getModalLayer () end
---* 
---@param url string
---@param volumeScale float
---@return self
function GRoot:playSound (url,volumeScale) end
---* 
---@return fgui.GObject
function GRoot:getModalWaitingPane () end
---* 
---@param value boolean
---@return self
function GRoot:setSoundEnabled (value) end
---* 
---@param win fgui.Window
---@return self
function GRoot:bringToFront (win) end
---* 
---@return boolean
function GRoot:hasModalWindow () end
---* 
---@return self
function GRoot:showModalWait () end
---* 
---@return boolean
function GRoot:isModalWaiting () end
---* 
---@param touchId int
---@return vec2_table
function GRoot:getTouchPosition (touchId) end
---* 
---@param popup fgui.GObject
---@param target fgui.GObject
---@param dir int
---@return vec2_table
function GRoot:getPoupPosition (popup,target,dir) end
---* 
---@param win fgui.Window
---@return self
function GRoot:showWindow (win) end
---* 
---@param msg string
---@return self
function GRoot:showTooltips (msg) end
---* 
---@param win fgui.Window
---@return self
function GRoot:hideWindow (win) end
---* 
---@param scene cc.Scene
---@param zOrder int
---@return self
function GRoot:create (scene,zOrder) end
---* 
---@return self
function GRoot:getInstance () end
---* 
---@return self
function GRoot:GRoot () end