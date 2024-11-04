
---@class cc.Sprite3DMaterial :cc.Material
local Sprite3DMaterial={ }
cc.Sprite3DMaterial=Sprite3DMaterial




---* Get material type<br>
---* return Material type
---@return int
function Sprite3DMaterial:getMaterialType () end
---* Create material with file name, it creates material from cache if it is previously loaded<br>
---* param path Path of material file<br>
---* return Created material
---@param path string
---@return self
function Sprite3DMaterial:createWithFilename (path) end
---* Release all cached materials
---@return self
function Sprite3DMaterial:releaseCachedMaterial () end
---@overload fun():self
---@overload fun(int:int,boolean:boolean):self
---@param type int
---@param skinned boolean
---@return self
function Sprite3DMaterial:createBuiltInMaterial (type,skinned) end
---* Create material with GLProgramState<br>
---* param programState GLProgramState instance<br>
---* return Created material
---@param programState cc.GLProgramState
---@return self
function Sprite3DMaterial:createWithGLStateProgram (programState) end
---* Release all built in materials
---@return self
function Sprite3DMaterial:releaseBuiltInMaterial () end
---* Clone material
---@return cc.Material
function Sprite3DMaterial:clone () end