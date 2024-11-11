
-- 区域修改颜色
---@class CustomColorHSVEffect

local test_sp = "model.png"

local shader = {
    fs = require "app.shader.ColorCustomHSVFS",
    vert = require "app.shader.NormalVS",
}

local CustomColorHSVEffect = class("CustomColorHSVEffect")

function CustomColorHSVEffect.getDescText()
    return "将指定颜色调整hsv:只调整b值的颜色"
end

function CustomColorHSVEffect:init(node)
    node:spTouchUseShader(test_sp, "CustomColorHSVEffect")
end

function CustomColorHSVEffect:setUniform(glState, time, node)
    -- local areaPosition = cc.p(0.0, 0.0)  -- 左上角
    -- local areaSize = cc.p(0.5, 0.5)      -- 20% x 20% 区域

    -- glState:setUniformVec2("u_areaPosition", areaPosition)
    -- glState:setUniformVec2("u_areaSize", areaSize)

    -- local tex = node:getTexture()
    -- glState:setUniformTexture("u_texture", tex)

    local destColor = cc.vec3(math.random(), math.random(), math.random()) 
    glState:setUniformVec3("dest_color", destColor)

    -- local customColor = cc.vec3(math.random(),math.random(),math.random())
    -- glState:setUniformVec3("u_customColor", customColor)

    -- 设置新的 HSV 值（例如，增加色相，保持饱和度和明度）


end

function CustomColorHSVEffect:resetUniform()
end

function CustomColorHSVEffect.getVert()
    return shader.vert
end

function CustomColorHSVEffect.needRefresh()
    return true
end

function CustomColorHSVEffect.getFS()
    return shader.fs
end

function CustomColorHSVEffect:resetTime(time)
    return time + 0.008
end

return CustomColorHSVEffect

