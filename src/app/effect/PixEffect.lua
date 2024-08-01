
-- 像素风
---@class PixEffect

local test_sp = "huli.png"

local shader = {
    fs = require "app.shader.PixFS",
    vert = require "app.shader.NormalVS",
}


local PixEffect = class("PixEffect")

function PixEffect.getDescText()
    return "点击物体变像素风"
end

function PixEffect:init(node)
    node:spTouchUseShader(test_sp, "pix_effect")
end

function PixEffect:setUniform(glState, time, node)
   

    local tex = node:getTexture()
    glState:setUniformTexture("u_texture", tex)

    glState:setUniformFloat("u_pixelSize", math.random() *0.1)
        


end

function PixEffect:resetUniform()
end

function PixEffect.getVert()
    return shader.vert
end

function PixEffect.needRefresh()
    return true
end

function PixEffect.getFS()
    return shader.fs
end

function PixEffect:resetTime(time)
    return time + 0.008
end

return PixEffect

