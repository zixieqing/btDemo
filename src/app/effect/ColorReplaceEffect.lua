
-- 颜色替换
---@class ColorReplaceEffect

local test_sp = "yanqing.png"

local shader = {
    fs = require "app.shader.ColorReplaceFS",
    vert = require "app.shader.NormalVS",
}

local ColorReplaceEffect = class("ColorReplaceEffect")

function ColorReplaceEffect.getDescText()
    return "点击换头发颜色"
end

function ColorReplaceEffect:init(node)
    node:spTouchUseShader(test_sp, "color_replace")
end

function ColorReplaceEffect:setUniform(glState, time, node)
    math.randomseed(os.time() * 22)

    local tex = node:getTexture()
    glState:setUniformTexture("u_Texture", tex)

    local ori_color = cc.vec3(0.9, 0.8, 0.6);
    local target_color = cc.vec3(math.random(), math.random(), math.random())
    glState:setUniformVec3("u_OriginalColor", ori_color)
    glState:setUniformVec3("u_TargetColor", target_color)
end

function ColorReplaceEffect:resetUniform()
end

function ColorReplaceEffect.getVert()
    return shader.vert
end

function ColorReplaceEffect.needRefresh()
    return true
end

function ColorReplaceEffect.getFS()
    return shader.fs
end

function ColorReplaceEffect:resetTime(time)
    return time + 0.5
end

return ColorReplaceEffect

