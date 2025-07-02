-- MainLayer.lua
-- Author: xianwx
-- Date: 2016-08-28 10:27:13
-- 主界面
local effects = {
    "OutLineEffect",

    "SearchLightEffect",

    "CustomColorHSVEffect",
    "AreaColorEffect",

    "AreaHSVEffect",

    "BorderLightEffect",
    "BorderEmptyEffect",
    -- "starRail.StarRailEffect",
    -- "LightingEffect",
    -- "PixelCatEffect",
    "HoleEffect",
    "ColorReplaceEffect",
    "XueHuaEffect",
    "WaveEffect",
    "PixEffect",
    "LightEffect", 
    "GlowCircleEffect",
    "GrassyEffect",
    "CloudEffect",   
    "FlameEffect",
    "DissolveEffect",
    "TransferEffect",
    "FluxayEffect_1",
    "FluxayEffect_2",
    "WaterWaveEffect",
}

local EffectLayer = require "app.layer.EffectLayer"
local MainLayer = class("MainLayer", function ()
    return display.newLayer()
end)
local spriteFrameCache = cc.SpriteFrameCache:getInstance()

function MainLayer:ctor()
    math.randomseed(os.time() * 30)
    local rBtn = display.newSprite("UI/ArmyDetail/labelArrow.png", 0, 0):addTo(self, 1)
    local lBtn = display.newSprite("UI/ArmyDetail/labelArrow.png", 0, 0):addTo(self, 1)
    rBtn:setAnchorPoint(0.5, 0.5)
    lBtn:setAnchorPoint(0.5, 0.5)
    lBtn:setRotation(180)
    local size = rBtn:getContentSize()
    rBtn:setPosition(display.width - size.width / 2, display.cy)
    lBtn:setPosition(size.width / 2, display.cy)

    local max = #effects

    addTouchEvent(rBtn, { endCallback = function ()
        local idx = self._idx + 1
        idx = idx > max and 1 or idx
        self:_displayLayer(idx)
    end, moveFix = true })

    addTouchEvent(lBtn, { endCallback = function ()
        local idx = self._idx - 1
        idx = idx < 1 and max or idx
        self:_displayLayer(idx)

        -- cc.SpriteFrameCache:getInstance():addSpriteFrames("model_2_1_0_10_1.plist", "model_2_1_0_10_1.pvr")

        -- local sprite = display.newSprite()
        -- sprite:setPosition(display.cx + 100, display.cy)  -- 设置为屏幕中心
        -- self:addChild(sprite, 999)
        -- local newFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame("model_2_1_0_10_0.png")  -- 替换为新帧名
        -- print("newFrame", newFrame)
        -- if not newFrame then
        --     print("newFrame is nil")
        --     return
        -- end
        -- sprite:setSpriteFrame(newFrame)  -- 设置新的精灵帧

    end, moveFix = true })

    self:_displayLayer(1)
end

function MainLayer:_displayLayer(idx)
    local effectName = effects[idx]
    if not effectName then
        return
    end

    self._idx = idx
    safeRemoveNode(self._layer)

    local layer = EffectLayer.new(effectName)
    layer:setAnchorPoint(0, 0)
    layer:setPosition(0,0)
    self:addChild(layer)

    self._layer = layer


end

return MainLayer
