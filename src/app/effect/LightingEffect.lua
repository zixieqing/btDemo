
-- 很亮的洞
---@class LightingEffect

local test_sp = "background_01.png"

local shader = {
    fs = require "app.shader.LightingFS",
    vert = require "app.shader.NormalVS",
}

local LightingEffect = class("LightingEffect")


function LightingEffect.getDescText()
    return "很亮的洞"
end

function LightingEffect:init(node)
    local sp = node:spUseShader(test_sp,"LightingEffect")


    local function resetUniform(touch)
        if not self._glState then
            return
        end
        local touchPos = touch:getLocation()
        local nodeP = cc.p(sp:convertToNodeSpace(cc.p(touchPos)))
        self._glState:setUniformVec2("iMouse", nodeP)
    end

    addTouchEvent(node, { endCallback = function (touch)
        resetUniform(touch)
    end, moveCallback = function (touch)
        resetUniform(touch)
    end, beginCallback = function (touch)
        resetUniform(touch)
    end, moveFix = true })
end

function LightingEffect:setUniform(glState, time, node)
    self._glState = glState
    glState:setUniformFloat("iTime", time)
    glState:setUniformVec2("iResolution", cc.p(1280,720))
    glState:setUniformVec2("iMouse", cc.p(math.random(1,1280),math.random(1,720)))
end

function LightingEffect:resetUniform(glState, time)
    glState:setUniformFloat("iTime", time)
end

function LightingEffect.getVert()
    return shader.vert
end

function LightingEffect.needRefresh()
    return true
end

function LightingEffect.getFS()
    return shader.fs
end

function LightingEffect:resetTime(time)
    return time + 0.1
end

return LightingEffect

