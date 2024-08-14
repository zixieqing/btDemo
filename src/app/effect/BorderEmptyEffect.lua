
-- 反选
---@class BorderEmptyEffect

local test_sp = "40001.png"

local shader = {
    fs = require "app.shader.BorderEmptyFS",
    vert = require "app.shader.BorderLightVS",
}


local BorderEmptyEffect = class("BorderEmptyEffect")

function BorderEmptyEffect.getDescText()
    return "镂空反选"
end

function BorderEmptyEffect:init(node)
    node:spTouchUseShader(test_sp, "BorderEmptyEffect")
end

function BorderEmptyEffect:setUniform(glState, time, node)
    local tex = node:getTexture()
    glState:setUniformTexture("u_texture", tex)

    glState:setUniformVec2("u_sprite_size", cc.p(800, 800))
    glState:setUniformFloat("u_OutlineWidth", 20)

    local a_color = cc.c4f(1.0, 0.84, 0.0, 1.0); -- 金黄色，完全不透明
    glState:setUniformVec4("a_color", a_color)  --从这里传进去颜色值的不生效？？？而直接写在shader 里的能生效
end

function BorderEmptyEffect:resetUniform()
end

function BorderEmptyEffect.getVert()
    return shader.vert
end

function BorderEmptyEffect.needRefresh()
    return true
end

function BorderEmptyEffect.getFS()
    return shader.fs
end

function BorderEmptyEffect:resetTime(time)
    return time + 0.008
end

return BorderEmptyEffect

