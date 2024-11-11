
-- 区域修改颜色
---@class AreaColorEffect

local test_sp = "huli.png"

local shader = {
    fs = require "app.shader.ColorAreaFS",
    vert = require "app.shader.NormalVS",
}

local AreaColorEffect = class("AreaColorEffect")

function AreaColorEffect.getDescText()
    return "设置某个区域颜色，点击设置左上角颜色改变"
end

function AreaColorEffect:init(node)
    node:spTouchUseShader(test_sp, "area_color")
end

function AreaColorEffect:setUniform(glState, time, node)
    local areaPosition = cc.p(0.0, 0.0)  -- 左上角
    local areaSize = cc.p(0.5, 0.5)      -- 20% x 20% 区域

    glState:setUniformVec2("u_areaPosition", areaPosition)
    glState:setUniformVec2("u_areaSize", areaSize)

    local tex = node:getTexture()
    glState:setUniformTexture("u_texture", tex)

    local customColor = cc.c4f(1.0, 0.0, 0.0, 1.0) -- RGBA，绿色
    glState:setUniformVec4("u_customColor", customColor) --这里也是不生效

end

function AreaColorEffect:resetUniform()
end

function AreaColorEffect.getVert()
    return shader.vert
end

function AreaColorEffect.needRefresh()
    return true
end

function AreaColorEffect.getFS()
    return shader.fs
end

function AreaColorEffect:resetTime(time)
    return time + 0.008
end

return AreaColorEffect

