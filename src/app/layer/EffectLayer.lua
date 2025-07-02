-- EffectLayer.lua
-- Author: xianwx
-- Date: 2018-08-27 11:43:01
-- 特效界面
local EffectLayer = class("EffectLayer", function ()
    return display.newLayer()
end)

function EffectLayer:ctor(effectName)
    local effect = require("app.effect." .. effectName).new()

    local label = createSimpleLabel({ text = effect.getDescText() }):addTo(self, 1)
    label:setAnchorPoint(0.5, 0.5)
    label:setPosition(display.cx, display.height - label:getContentSize().height / 2)
   

    self._effect = effect
    self._effect:init(self)

end

function EffectLayer:spTouchUseShader(spPath, shaderName)
    local sp = display.newSprite(spPath, display.cx, display.cy):addTo(self)
    sp:setAnchorPoint(cc.p(0.5,0.6))
    addTouchEvent(sp, { endCallback = function ()
        self:_setNodeShader(sp, shaderName)

        -- 创建精灵
        local sprite = display.newSprite()
        sprite:setPosition(display.cx + 100, display.cy)  -- 设置为屏幕中心
        self:addChild(sprite, 999)
        local newFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame("model_2_1_0_10_0.png")  -- 替换为新帧名
        print("newFrame", newFrame)
        if not newFrame then
            print("newFrame is nil")
            return
        end
        sprite:setSpriteFrame(newFrame)  -- 设置新的精灵帧


    end, moveFix = true })
    return sp
end

function EffectLayer:selfUseShader(shaderName)
    self:_setNodeShader(self, shaderName)
    return self
end

function EffectLayer:spUseShader(spPath, shaderName)
    local sp = display.newSprite(spPath, display.cx, display.cy):addTo(self)
    self:_setNodeShader(sp, shaderName)
    return sp
end

function EffectLayer:_setNodeShader(node, shaderName)
    if not node then
        return
    end

    -- 创建GLProgram
    local cache = cc.GLProgramCache:getInstance()
    local p = cache:getGLProgram(shaderName)
    local time = 0
    if not p then
        p = cc.GLProgram:createWithByteArrays(self._effect.getVert(shaderName), self._effect.getFS(shaderName))
        p:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION,cc.VERTEX_ATTRIB_POSITION)  
        p:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR,cc.VERTEX_ATTRIB_COLOR)  
        p:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD,cc.VERTEX_ATTRIB_FLAG_TEX_COORDS) 
        if self._effect.bindAttrCustom then
            self._effect:bindAttrCustom(p, shaderName)
        end
        p:link()
        p:updateUniforms()
        p:use()
        cache:addGLProgram(p, shaderName)
    end


    -- set uniform value
    local glState = cc.GLProgramState:getOrCreateWithGLProgram(p)

    self._effect:setUniform(glState, time, node, shaderName)

    node:setGLProgramState(glState)

    -- if self._effect.needRefresh() then
    --     node:scheduleUpdate()
    -- end

    -- node:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function ()
    --     time = self._effect:resetTime(time)

    --     -- 避免这个值变得太大
    --     if time > 1000000 then
    --         time = 0
    --     end

    --     glState = cc.GLProgramState:getOrCreateWithGLProgram(p)
    --     self._effect:resetUniform(glState, time)
    -- end)
    node:onUpdate(function()
        time = self._effect:resetTime(time)

        -- 避免这个值变得太大
        if time > 1000000 then
            time = 0
        end

        glState = cc.GLProgramState:getOrCreateWithGLProgram(p)
        self._effect:resetUniform(glState, time)
    end)
   
end

return EffectLayer
