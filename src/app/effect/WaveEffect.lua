
-- 波动效果
---@class WaveEffect

local test_sp = "huli.png"

local shader = {
    fs = require "app.shader.WaveFS",
    vert = require "app.shader.NormalVS",
}


local WaveEffect = class("WaveEffect")

function WaveEffect.getDescText()
    return "点击物体波动效果"
end

function WaveEffect:init(node)
    node:spTouchUseShader(test_sp, "wave_effect")
end

function WaveEffect:setUniform(glState, time, node)
   
    local tex = node:getTexture()
    glState:setUniformTexture("u_texture", tex)

    glState:setUniformFloat("u_time", time)

end

function WaveEffect:resetUniform(glState, time)
    glState:setUniformFloat("u_time", time)
end

function WaveEffect.getVert()
    return shader.vert
end

function WaveEffect.needRefresh()
    return true
end

function WaveEffect.getFS()
    return shader.fs
end

function WaveEffect:resetTime(time)
    return time + 0.06
end

return WaveEffect

