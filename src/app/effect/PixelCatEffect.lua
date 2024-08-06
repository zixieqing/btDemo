
-- 像素闪动
---@class PixelCatEffect

local test_sp = "nyan-cat.jpg"
local noise_sp = "noisetexture.png"

local shader = {
    fs = require "app.shader.PixelCatFS",
    vert = require "app.shader.NormalVS",
}

local PixelCatEffect = class("PixelCatEffect")


function PixelCatEffect.getDescText()
    return "像素闪动"
end

function PixelCatEffect:init(node)
    node:spTouchUseShader(test_sp, "pixel_cat_effect")
end

function PixelCatEffect:setUniform(glState, time, node)

    glState:setUniformFloat("iTime", time)
    glState:setUniformVec2("iResolution", cc.p(300,300))



    local tex = node:getTexture()
    local noise = display.newSprite(noise_sp)

    local tex2 = noise:getTexture()

    glState:setUniformTexture("iChannel0", tex)


    glState:setUniformTexture("iChannel1", tex2)

end

function PixelCatEffect:resetUniform(glState, time)
    glState:setUniformFloat("iTime", time)
end

function PixelCatEffect.getVert()
    return shader.vert
end

function PixelCatEffect.needRefresh()
    return true
end

function PixelCatEffect.getFS()
    return shader.fs
end

function PixelCatEffect:resetTime(time)
    return time + 0.008
end

return PixelCatEffect

