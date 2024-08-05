
-- 雪花
---@class XueHuaEffect

local test_sp = "yanqing.png"
local noise_sp = "gaussianNoise.png"

local shader = {
    fs = require "app.shader.CircleFS",
    vert = require "app.shader.CircleVS",
}

local XueHuaEffect = class("XueHuaEffect")

function XueHuaEffect.getDescText()
    return "雪花"
end

function XueHuaEffect:init(node)
    node:spTouchUseShader(test_sp, "xuehua_effect")
end

function XueHuaEffect:setUniform(glState, time, node)
    math.randomseed(os.time() * 22)

     -- 创建噪音图片
    local noise = display.newSprite(noise_sp, 0, 0)

    -- 获取gl id
    local tex = noise:getTexture()
    glState:setUniformTexture("u_NoiseTexture", tex)
    glState:setUniformTexture("u_texture", node:getTexture())

    
    glState:setUniformFloat("u_NoiseAmount", 0.3)



local areaPosition = cc.p(256, 256)  
    local areaSize = cc.p(160, 160)      

    glState:setUniformVec2("u_NoiseTexturePixelSize", areaPosition)
    glState:setUniformVec2("cc_ViewSizeInPixels", areaSize)

end

function XueHuaEffect:resetUniform(glState, time)
    -- glState:setUniformFloat("u_time", time)
    
end

function XueHuaEffect.getVert()
    return shader.vert
end

function XueHuaEffect.needRefresh()
    return true
end

function XueHuaEffect.getFS()
    return shader.fs
end

function XueHuaEffect:resetTime(time)
    return time + 0.5
end

return XueHuaEffect

