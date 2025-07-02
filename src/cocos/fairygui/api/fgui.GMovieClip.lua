
---@class fgui.GMovieClip :fgui.GObject
local GMovieClip={ }
fgui.GMovieClip=GMovieClip




---* 
---@param time float
---@return self
function GMovieClip:advance (time) end
---* 
---@param value float
---@return self
function GMovieClip:setTimeScale (value) end
---* 
---@param value color3b_table
---@return self
function GMovieClip:setColor (value) end
---* 
---@param value int
---@return self
function GMovieClip:setFrame (value) end
---* 
---@return color3b_table
function GMovieClip:getColor () end
---* 
---@return int
function GMovieClip:getFlip () end
---* 
---@return int
function GMovieClip:getFrame () end
---* 
---@param value int
---@return self
function GMovieClip:setFlip (value) end
---* 
---@param value boolean
---@return self
function GMovieClip:setPlaying (value) end
---* 
---@return boolean
function GMovieClip:isPlaying () end
---* 
---@return float
function GMovieClip:getTimeScale () end
---* 
---@return self
function GMovieClip:create () end
---* 
---@param propId int
---@return cc.Value
function GMovieClip:getProp (propId) end
---* 
---@return self
function GMovieClip:constructFromResource () end
---* 
---@param propId int
---@param value cc.Value
---@return self
function GMovieClip:setProp (propId,value) end
---* 
---@return self
function GMovieClip:GMovieClip () end