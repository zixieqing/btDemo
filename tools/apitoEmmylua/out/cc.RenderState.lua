
---@class cc.RenderState :cc.Ref
local RenderState={ }
cc.RenderState=RenderState




---*  Texture that will use in the CC_Texture0 uniform.<br>
---* Added to be backwards compatible. Use Samplers from .material instead.
---@param texture cc.Texture2D
---@return self
function RenderState:setTexture (texture) end
---* Returns the topmost RenderState in the hierarchy below the given RenderState.
---@param below cc.RenderState
---@return self
function RenderState:getTopmost (below) end
---*  Returns the texture that is going to be used for CC_Texture0.<br>
---* Added to be backwards compatible.
---@return cc.Texture2D
function RenderState:getTexture () end
---* Binds the render state for this RenderState and any of its parents, top-down,<br>
---* for the given pass.
---@param pass cc.Pass
---@return self
function RenderState:bind (pass) end
---* 
---@return string
function RenderState:getName () end
---* 
---@return cc.RenderState.StateBlock
function RenderState:getStateBlock () end
---* 
---@param parent cc.RenderState
---@return self
function RenderState:setParent (parent) end
---* Static initializer that is called during game startup.
---@return self
function RenderState:initialize () end