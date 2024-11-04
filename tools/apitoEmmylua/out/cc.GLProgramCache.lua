
---@class cc.GLProgramCache :cc.Ref
local GLProgramCache={ }
cc.GLProgramCache=GLProgramCache




---*  reload default programs these are relative to light 
---@return self
function GLProgramCache:reloadDefaultGLProgramsRelativeToLights () end
---*  adds a GLProgram to the cache for a given name 
---@param program cc.GLProgram
---@param key string
---@return self
function GLProgramCache:addGLProgram (program,key) end
---*  reload the default shaders 
---@return self
function GLProgramCache:reloadDefaultGLPrograms () end
---*  loads the default shaders 
---@return self
function GLProgramCache:loadDefaultGLPrograms () end
---*  returns a GL program for a given key 
---@param key string
---@return cc.GLProgram
function GLProgramCache:getGLProgram (key) end
---*  purges the cache. It releases the retained instance. 
---@return self
function GLProgramCache:destroyInstance () end
---*  returns the shared instance 
---@return self
function GLProgramCache:getInstance () end
---* Constructor.<br>
---* js ctor
---@return self
function GLProgramCache:GLProgramCache () end