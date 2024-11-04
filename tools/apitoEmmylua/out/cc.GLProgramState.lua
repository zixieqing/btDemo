
---@class cc.GLProgramState :cc.Ref
local GLProgramState={ }
cc.GLProgramState=GLProgramState




---*  Get the flag of vertex attribs used by OR operation.
---@return unsigned_int
function GLProgramState:getVertexAttribsFlags () end
---@overload fun(string0:int,vec4_table:vec4_table):self
---@overload fun(string:string,vec4_table:vec4_table):self
---@param uniformName string
---@param value vec4_table
---@return self
function GLProgramState:setUniformVec4 (uniformName,value) end
---* Applies the specified custom auto-binding.<br>
---* param uniformName Name of the shader uniform.<br>
---* param autoBinding Name of the auto binding.
---@param uniformName string
---@param autoBinding string
---@return self
function GLProgramState:applyAutoBinding (uniformName,autoBinding) end
---@overload fun(string0:int,vec2_table:vec2_table):self
---@overload fun(string:string,vec2_table:vec2_table):self
---@param uniformName string
---@param value vec2_table
---@return self
function GLProgramState:setUniformVec2 (uniformName,value) end
---@overload fun(string0:int,vec3_table:vec3_table):self
---@overload fun(string:string,vec3_table:vec3_table):self
---@param uniformName string
---@param value vec3_table
---@return self
function GLProgramState:setUniformVec3 (uniformName,value) end
---* Apply GLProgram, attributes and uniforms.<br>
---* param modelView The applied modelView matrix to shader.
---@param modelView mat4_table
---@return self
function GLProgramState:apply (modelView) end
---* Returns the Node bound to the GLProgramState
---@return cc.Node
function GLProgramState:getNodeBinding () end
---@overload fun(string0:int,int:int,vec4_table:vec4_table):self
---@overload fun(string:string,int:int,vec4_table:vec4_table):self
---@param uniformName string
---@param size int
---@param pointer vec4_table
---@return self
function GLProgramState:setUniformVec4v (uniformName,size,pointer) end
---* Apply GLProgram, and built in uniforms.<br>
---* param modelView The applied modelView matrix to shader.
---@param modelView mat4_table
---@return self
function GLProgramState:applyGLProgram (modelView) end
---* Sets the node that this render state is bound to.<br>
---* The specified node is used to apply auto-bindings for the render state.<br>
---* This is typically set to the node of the model that a material is<br>
---* applied to.<br>
---* param node The node to use for applying auto-bindings.
---@param node cc.Node
---@return self
function GLProgramState:setNodeBinding (node) end
---@overload fun(string0:int,int:int):self
---@overload fun(string:string,int:int):self
---@param uniformName string
---@param value int
---@return self
function GLProgramState:setUniformInt (uniformName,value) end
---* Sets a uniform auto-binding.<br>
---* This method parses the passed in autoBinding string and attempts to convert it<br>
---* to an enumeration value. If it matches to one of the predefined strings, it will create a<br>
---* callback to get the correct value at runtime.<br>
---* param uniformName The name of the material parameter to store an auto-binding for.<br>
---* param autoBinding A string matching one of the built-in AutoBinding enum constants.
---@param uniformName string
---@param autoBinding string
---@return self
function GLProgramState:setParameterAutoBinding (uniformName,autoBinding) end
---@overload fun(string0:int,int:int,vec2_table:vec2_table):self
---@overload fun(string:string,int:int,vec2_table:vec2_table):self
---@param uniformName string
---@param size int
---@param pointer vec2_table
---@return self
function GLProgramState:setUniformVec2v (uniformName,size,pointer) end
---* Get the number of user defined uniform count.
---@return int
function GLProgramState:getUniformCount () end
---* Apply attributes.<br>
---* param applyAttribFlags Call GL::enableVertexAttribs(_vertexAttribsFlags) or not.
---@return self
function GLProgramState:applyAttributes () end
---*  Returns a new copy of the GLProgramState. The GLProgram is reused 
---@return self
function GLProgramState:clone () end
---* Setter and Getter of the owner GLProgram binded in this program state.
---@param glprogram cc.GLProgram
---@return self
function GLProgramState:setGLProgram (glprogram) end
---@overload fun(string0:int,int:int,float:float):self
---@overload fun(string:string,int:int,float:float):self
---@param uniformName string
---@param size int
---@param pointer float
---@return self
function GLProgramState:setUniformFloatv (uniformName,size,pointer) end
---* 
---@return cc.GLProgram
function GLProgramState:getGLProgram () end
---@overload fun(string0:int,cc.Texture2D:cc.Texture2D):self
---@overload fun(string:string,cc.Texture2D:cc.Texture2D):self
---@param uniformName string
---@param texture cc.Texture2D
---@return self
function GLProgramState:setUniformTexture (uniformName,texture) end
---* Apply user defined uniforms.
---@return self
function GLProgramState:applyUniforms () end
---@overload fun(string0:int,float:float):self
---@overload fun(string:string,float:float):self
---@param uniformName string
---@param value float
---@return self
function GLProgramState:setUniformFloat (uniformName,value) end
---@overload fun(string0:int,mat4_table:mat4_table):self
---@overload fun(string:string,mat4_table:mat4_table):self
---@param uniformName string
---@param value mat4_table
---@return self
function GLProgramState:setUniformMat4 (uniformName,value) end
---@overload fun(string0:int,int:int,vec3_table:vec3_table):self
---@overload fun(string:string,int:int,vec3_table:vec3_table):self
---@param uniformName string
---@param size int
---@param pointer vec3_table
---@return self
function GLProgramState:setUniformVec3v (uniformName,size,pointer) end
---* Get the number of vertex attributes.
---@return int
function GLProgramState:getVertexAttribCount () end
---*  returns a new instance of GLProgramState for a given GLProgram 
---@param glprogram cc.GLProgram
---@return self
function GLProgramState:create (glprogram) end
---@overload fun(string:string,cc.Texture2D:cc.Texture2D):self
---@overload fun(string:string):self
---@param glProgramName string
---@param texture cc.Texture2D
---@return self
function GLProgramState:getOrCreateWithGLProgramName (glProgramName,texture) end
---*  gets-or-creates an instance of GLProgramState for a given GLProgram 
---@param glprogram cc.GLProgram
---@return self
function GLProgramState:getOrCreateWithGLProgram (glprogram) end
---*  gets-or-creates an instance of GLProgramState for given shaders 
---@param vertexShader string
---@param fragShader string
---@param compileTimeDefines string
---@return self
function GLProgramState:getOrCreateWithShaders (vertexShader,fragShader,compileTimeDefines) end