
-- 区域修改颜色
---@class LightEffect

local test_sp = "huli.png"

local shader = {
    fs = require "app.shader.LightFS",
    vert = require "app.shader.NormalVS",
}
gl.enable(gl.BLEND)
gl.blendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA)

local LightEffect = class("LightEffect")

function LightEffect.getDescText()
    return "点击物体发光"
end

function LightEffect:init(node)
    node:spTouchUseShader(test_sp, "light_effect")
end

function LightEffect:setUniform(glState, time, node)
   

    local tex = node:getTexture()
    glState:setUniformTexture("u_texture", tex)

    glState:setUniformFloat("u_brightness", math.random(1,10))
        

    -- local customColor = cc.c4f(1.0, 0.0, 0.0, 1.0) -- RGBA

end

function LightEffect:resetUniform()
end

function LightEffect.getVert()
    return shader.vert
end

function LightEffect.needRefresh()
    return true
end

function LightEffect.getFS()
    return shader.fs
end

function LightEffect:resetTime(time)
    return time + 0.008
end

return LightEffect

