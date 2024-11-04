
---@class cc.GLProgram :cc.Ref
local GLProgram={ }
cc.GLProgram=GLProgram




---*  returns the fragmentShader error log 
---@return string
function GLProgram:getFragmentShaderLog () end
---@overload fun(char:char,char:char,string:string):self
---@overload fun(char:char,char:char):self
---@overload fun(char:char,char:char,string:string,string:string):self
---@param vShaderByteArray char
---@param fShaderByteArray char
---@param compileTimeHeaders string
---@param compileTimeDefines string
---@return boolean
function GLProgram:initWithByteArrays (vShaderByteArray,fShaderByteArray,compileTimeHeaders,compileTimeDefines) end
---@overload fun(string:string,string:string,string:string):self
---@overload fun(string:string,string:string):self
---@overload fun(string:string,string:string,string:string,string:string):self
---@param vShaderFilename string
---@param fShaderFilename string
---@param compileTimeHeaders string
---@param compileTimeDefines string
---@return boolean
function GLProgram:initWithFilenames (vShaderFilename,fShaderFilename,compileTimeHeaders,compileTimeDefines) end
---*  it will call glUseProgram() 
---@return self
function GLProgram:use () end
---*  returns the vertexShader error log 
---@return string
function GLProgram:getVertexShaderLog () end
---@overload fun():self
---@overload fun(mat4_table:mat4_table):self
---@param modelView mat4_table
---@return self
function GLProgram:setUniformsForBuiltins (modelView) end
---*  It will create 4 uniforms:<br>
---* - kUniformPMatrix<br>
---* - kUniformMVMatrix<br>
---* - kUniformMVPMatrix<br>
---* - GLProgram::UNIFORM_SAMPLER<br>
---* And it will bind "GLProgram::UNIFORM_SAMPLER" to 0
---@return self
function GLProgram:updateUniforms () end
---*  calls glUniform1i only if the values are different than the previous call for this same shader program.<br>
---* js setUniformLocationI32<br>
---* lua setUniformLocationI32
---@param location int
---@param i1 int
---@return self
function GLProgram:setUniformLocationWith1i (location,i1) end
---*  Reload all shaders, this function is designed for android<br>
---* when opengl context lost, so don't call it.
---@return self
function GLProgram:reset () end
---*   It will add a new attribute to the shader by calling glBindAttribLocation. 
---@param attributeName string
---@param index unsigned_int
---@return self
function GLProgram:bindAttribLocation (attributeName,index) end
---*  Calls glGetAttribLocation. 
---@param attributeName string
---@return int
function GLProgram:getAttribLocation (attributeName) end
---*  links the glProgram 
---@return boolean
function GLProgram:link () end
---@overload fun(char:char,char:char,string:string):self
---@overload fun(char:char,char:char):self
---@overload fun(char:char,char:char,string:string,string:string):self
---@param vShaderByteArray char
---@param fShaderByteArray char
---@param compileTimeHeaders string
---@param compileTimeDefines string
---@return self
function GLProgram:createWithByteArrays (vShaderByteArray,fShaderByteArray,compileTimeHeaders,compileTimeDefines) end
---@overload fun(string:string,string:string,string:string):self
---@overload fun(string:string,string:string):self
---@overload fun(string:string,string:string,string:string,string:string):self
---@param vShaderFilename string
---@param fShaderFilename string
---@param compileTimeHeaders string
---@param compileTimeDefines string
---@return self
function GLProgram:createWithFilenames (vShaderFilename,fShaderFilename,compileTimeHeaders,compileTimeDefines) end
---* Constructor.
---@return self
function GLProgram:GLProgram () end