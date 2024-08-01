
-- 区域修改色相
---@class AreaHSVEffect

local test_sp = "yanqing.png"

local shader = {
    fs = require "app.shader.HSVAreaFS",
    vert = require "app.shader.NormalVS",
}

local AreaHSVEffect = class("AreaHSVEffect")

function AreaHSVEffect.getDescText()
    return "设置某个区域色相/饱和度/亮度，点击设置左上角颜色改变"
end

function AreaHSVEffect:init(node)
    node:spTouchUseShader(test_sp, "hsv_area_color")
end

function AreaHSVEffect:setUniform(glState, time, node)
    math.randomseed(os.time() * 22)

    local areaPosition = cc.p(0.0, 0.0)  -- 左上角
    local areaSize = cc.p(0.5, 0.5)      -- 20% x 20% 区域

    glState:setUniformVec2("u_areaPosition", areaPosition)
    glState:setUniformVec2("u_areaSize", areaSize)

    local tex = node:getTexture()
    glState:setUniformTexture("u_hsv_texture", tex)

    -- 设置新的 HSV 值（例如，增加色相，保持饱和度和明度）
    local newHSV = cc.vec3(math.random(), math.random(), math.random()) -- 0.1 是色相的增量
    glState:setUniformVec3("u_newHSV", newHSV)

end

function AreaHSVEffect:resetUniform()
end

function AreaHSVEffect.getVert()
    return shader.vert
end

function AreaHSVEffect.needRefresh()
    return true
end

function AreaHSVEffect.getFS()
    return shader.fs
end

function AreaHSVEffect:resetTime(time)
    return time + 0.5
end

return AreaHSVEffect

