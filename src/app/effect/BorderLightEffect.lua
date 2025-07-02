
-- 边缘发光
---@class BorderLightEffect

local test_sp = "bianyuan.png"

local shader = {
    fs = require "app.shader.BorderLightFS",
    vert = require "app.shader.BorderLightVS",
}

local BorderLightEffect = class("BorderLightEffect")

function BorderLightEffect.getDescText()
    return "边缘发光"
end

function BorderLightEffect:init(node)
    node:spTouchUseShader(test_sp, "border_light")
end

function BorderLightEffect:setUniform(glState, time, node)
    math.randomseed(os.time() * 22)

    -- local tex = node:getTexture()
    -- glState:setUniformTexture("u_texture", tex)

    -- glState:setUniformVec2("u_sprite_size", cc.p(800, 800))
    -- glState:setUniformFloat("u_OutlineWidth", 20)

    -- local a_color = cc.c4f(1.0, 0.84, 0.0, 1.0); -- 金黄色，完全不透明
    -- glState:setUniformVec4("a_color", a_color)  --从这里传进去颜色值的不生效？？？而直接写在shader 里的能生效
    local size = node:getContentSize()
    glState:setUniformVec2("u_sprite_size", cc.p(size.width, size.height))
    glState:setUniformFloat("u_OutlineWidth", 1)

    glState:setUniformVec3("u_color", cc.vec3(1, 1, 1)) 

end

function BorderLightEffect:resetUniform()
end

function BorderLightEffect.getVert()
    return shader.vert
end

function BorderLightEffect.needRefresh()
    return true
end

function BorderLightEffect.getFS()
    return shader.fs
end

function BorderLightEffect:resetTime(time)
    return time + 0.5
end

return BorderLightEffect

