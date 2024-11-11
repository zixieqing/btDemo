
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
    local destColor2 = cc.vec3(math.random(), math.random(), math.random()) 
    glState:setUniformVec3("dest_color_b", destColor2)

    local destColor = cc.vec3(math.random(), math.random(), math.random()) 
    glState:setUniformVec3("dest_color_gb", destColor)

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

