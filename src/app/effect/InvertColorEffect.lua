-- InvertColorEffect.lua
-- Author: xianwx
-- Date: 2018-08-28 18:20:18
-- 反色效果
local test_sp = "yanqing.png"

local shader = {
    fs = require "app.shader.InvertColorFS",
    vert = require "app.shader.NormalVS",
}

local InvertColorEffect = class("InvertColorEffect")

function InvertColorEffect.getDescText()
    return "反色效果\n请尝试点击一下图片"
end

function InvertColorEffect:init(node)
    node:spTouchUseShader(test_sp, "invert_color")
end

function InvertColorEffect:setUniform()
end

function InvertColorEffect:resetUniform()
end

function InvertColorEffect.getVert()
    return shader.vert
end

function InvertColorEffect.needRefresh()
    return true
end

function InvertColorEffect.getFS()
    return shader.fs
end

function InvertColorEffect:resetTime(time)
    return time + 0.008
end

return InvertColorEffect

