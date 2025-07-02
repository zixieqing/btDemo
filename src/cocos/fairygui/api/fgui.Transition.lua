
---@class fgui.Transition :cc.Ref
local Transition={ }
fgui.Transition=Transition




---* 
---@param paused boolean
---@return self
function Transition:setPaused (paused) end
---* 
---@param value float
---@return self
function Transition:setTimeScale (value) end
---* 
---@param label string
---@return float
function Transition:getLabelTime (label) end
---* 
---@param value int
---@return self
function Transition:changePlayTimes (value) end
---* 
---@return self
function Transition:onOwnerRemovedFromStage () end
---* 
---@param label string
---@param newTarget fgui.GObject
---@return self
function Transition:setTarget (label,newTarget) end
---* 
---@return self
function Transition:clearHooks () end
---@overload fun(boolean:boolean,boolean:boolean):self
---@overload fun():self
---@param setToComplete boolean
---@param processCallback boolean
---@return self
function Transition:stop (setToComplete,processCallback) end
---* 
---@param label string
---@param value float
---@return self
function Transition:setDuration (label,value) end
---* 
---@return float
function Transition:getTimeScale () end
---* 
---@return fgui.GComponent
function Transition:getOwner () end
---* 
---@param label string
---@param values array_table
---@return self
function Transition:setValue (label,values) end
---* 
---@return self
function Transition:onOwnerAddedToStage () end
---* 
---@return boolean
function Transition:isPlaying () end
---* 
---@param autoPlay boolean
---@param times int
---@param delay float
---@return self
function Transition:setAutoPlay (autoPlay,times,delay) end
---* 
---@param targetId string
---@param dx float
---@param dy float
---@return self
function Transition:updateFromRelations (targetId,dx,dy) end
---* 
---@param owner fgui.GComponent
---@return self
function Transition:Transition (owner) end