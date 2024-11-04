
---@class cc.Pass :cc.RenderState
local Pass={ }
cc.Pass=Pass




---*  Unbinds the Pass.<br>
---* This method must be called AFTER calling the actual draw call
---@return self
function Pass:unbind () end
---@overload fun(mat4_table:mat4_table,boolean:boolean):self
---@overload fun(mat4_table:mat4_table):self
---@param modelView mat4_table
---@param bindAttributes boolean
---@return self
function Pass:bind (modelView,bindAttributes) end
---* Returns a clone (deep-copy) of this instance 
---@return self
function Pass:clone () end
---*  Returns the GLProgramState 
---@return cc.GLProgramState
function Pass:getGLProgramState () end
---* Returns the vertex attribute binding for this pass.<br>
---* return The vertex attribute binding for this pass.
---@return cc.VertexAttribBinding
function Pass:getVertexAttributeBinding () end
---* 
---@return unsigned_int
function Pass:getHash () end
---* Sets a vertex attribute binding for this pass.<br>
---* When a mesh binding is set, the VertexAttribBinding will be automatically<br>
---* bound when the bind() method is called for the pass.<br>
---* param binding The VertexAttribBinding to set (or NULL to remove an existing binding).
---@param binding cc.VertexAttribBinding
---@return self
function Pass:setVertexAttribBinding (binding) end
---* 
---@param parent cc.Technique
---@return self
function Pass:create (parent) end
---*  Creates a Pass with a GLProgramState.
---@param parent cc.Technique
---@param programState cc.GLProgramState
---@return self
function Pass:createWithGLProgramState (parent,programState) end