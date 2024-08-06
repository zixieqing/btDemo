
-- 挖洞
---@class HoleEffect

local test_sp = "huli.png"

local shader = {
    fs = require "app.shader.HoleFS",
    vert = require "app.shader.NormalVS",
}

local HoleEffect = class("HoleEffect")

function HoleEffect.getDescText()
    return "挖洞"
end

function HoleEffect:init(node)
    node:spTouchUseShader(test_sp, "hole_effect")
end

function HoleEffect:setUniform(glState, time, node)
    local u_holeCenter = cc.p(0.5, 0.5)

    glState:setUniformVec2("u_holeCenter", u_holeCenter)
    glState:setUniformFloat("u_holeRadius", math.random()/2)

    local tex = node:getTexture()
    glState:setUniformTexture("u_texture", tex)
    glState:setUniformVec2("u_spriteSize", cc.p(160,160))
end

function HoleEffect:resetUniform()
end

function HoleEffect.getVert()
    return shader.vert
end

function HoleEffect.needRefresh()
    return true
end

function HoleEffect.getFS()
    return shader.fs
end

function HoleEffect:resetTime(time)
    return time + 0.008
end

return HoleEffect

