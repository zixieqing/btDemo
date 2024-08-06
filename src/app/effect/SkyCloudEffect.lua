
-- 腾云驾雾(貌似有点问题)
---@class SkyCloudEffect

local gfx02 = "gfx02.jpg"
local gfx03 = "gfx03.jpg"
local gfx04 = "gfx04.jpg"

local shader = {
    fs = require "app.shader.SkyCloudFS",
    vert = require "app.shader.NormalVS",
}

local SkyCloudEffect = class("SkyCloudEffect")


function SkyCloudEffect.getDescText()
    return "腾云驾雾"
end

function SkyCloudEffect:init(node)
    local sp = node:spUseShader(gfx02,"SkyCloudEffect")


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

function SkyCloudEffect:setUniform(glState, time, node)
    self._glState = glState
    glState:setUniformFloat("iTime", time)
    glState:setUniformVec2("iResolution", cc.p(640,360))
    glState:setUniformVec2("iMouse", cc.p(math.random(1,640),math.random(1,360)))

    local tex = node:getTexture()
    local cloud2Tex = display.newSprite(gfx03):getTexture()
    local cloud3Tex = display.newSprite(gfx04):getTexture()
    glState:setUniformTexture("iChannel0", tex)
    glState:setUniformTexture("iChannel1", cloud2Tex)
    glState:setUniformTexture("iChannel2", cloud3Tex)
end

function SkyCloudEffect:resetUniform(glState, time)
    glState:setUniformFloat("iTime", time)
end

function SkyCloudEffect.getVert()
    return shader.vert
end

function SkyCloudEffect.needRefresh()
    return true
end

function SkyCloudEffect.getFS()
    return shader.fs
end

function SkyCloudEffect:resetTime(time)
    return time + 0.4
end

return SkyCloudEffect

