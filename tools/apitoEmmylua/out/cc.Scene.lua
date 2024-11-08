
---@class cc.Scene :cc.Node
local Scene={ }
cc.Scene=Scene




---* 
---@return boolean
function Scene:initWithPhysics () end
---* 
---@return self
function Scene:setCameraOrderDirty () end
---@overload fun(cc.Renderer:cc.Renderer,mat4_table:mat4_table,mat4_table:mat4_table,unsigned_int:unsigned_int):self
---@overload fun(cc.Renderer:cc.Renderer,mat4_table:mat4_table,mat4_table:mat4_table):self
---@param renderer cc.Renderer
---@param eyeTransforms mat4_table
---@param eyeProjections mat4_table
---@param multiViewCount unsigned_int
---@return self
function Scene:render (renderer,eyeTransforms,eyeProjections,multiViewCount) end
---* 
---@param deltaTime float
---@return self
function Scene:stepPhysicsAndNavigation (deltaTime) end
---* 
---@param event cc.EventCustom
---@return self
function Scene:onProjectionChanged (event) end
---*  Get the physics world of the scene.<br>
---* return The physics world of the scene.<br>
---* js NA
---@return cc.PhysicsWorld
function Scene:getPhysicsWorld () end
---* 
---@param size size_table
---@return boolean
function Scene:initWithSize (size) end
---*  Get the default camera.<br>
---* js NA<br>
---* return The default camera of scene.
---@return cc.Camera
function Scene:getDefaultCamera () end
---*  Creates a new Scene object with a predefined Size. <br>
---* param size The predefined size of scene.<br>
---* return An autoreleased Scene object.<br>
---* js NA
---@param size size_table
---@return self
function Scene:createWithSize (size) end
---*  Creates a new Scene object. <br>
---* return An autoreleased Scene object.
---@return self
function Scene:create () end
---*  Create a scene with physics.<br>
---* return An autoreleased Scene object with physics.<br>
---* js NA
---@return self
function Scene:createWithPhysics () end
---* 
---@return boolean
function Scene:init () end
---* 
---@return string
function Scene:getDescription () end
---*  override function 
---@return self
function Scene:removeAllChildren () end
---* 
---@return self
function Scene:Scene () end