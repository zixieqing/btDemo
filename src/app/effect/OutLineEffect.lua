
-- 挖洞
---@class OutLineEffect

local test_sp = "model_2_1_0_10_16.png"
-- local test_sp = "huli.png"


local shader = {
    fs = require "app.shader.OutLine2FS",
    vert = require "app.shader.NormalVS",
}

local OutLineEffect = class("OutLineEffect")

function OutLineEffect.getDescText()
    return "OutLineEffect"
end

function OutLineEffect:init(node)
    node:spTouchUseShader(test_sp, "OutLineEffect")
end

function OutLineEffect:setUniform(glState, time, node)
    
    --- 加载plist里pixelWidth 计算
    --   cc.SpriteFrameCache:getInstance():addSpriteFrames("tlmodel/role/model_2_1_0_10_1.plist","tlmodel/role/model_2_1_0_10_1.pvr.ccz")

    -- local spriteFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame("model_2_1_0_10_0.png")
    -- local rect = spriteFrame:getRect() -- 返回 cc.rect(x, y, width, height)
    -- local offset = spriteFrame:getOffset() -- 纹理偏移
    -- local originalSize = spriteFrame:getOriginalSize() -- 原始尺寸
    -- local rectInPixels = spriteFrame:getRectInPixels() -- 纹理区域（像素）
    -- local texture = spriteFrame:getTexture()
    -- local atlasSize = texture:getContentSize() -- 返回 cc.size(width, height)
    -- dump(rect)

    -- local rect = spriteFrame:getRect()
    -- local u_uvMin_x = rect.x / atlasSize.width
    -- local u_uvMin_y = rect.y / atlasSize.height
    -- local u_uvMax_x = (rect.x + rect.width) / atlasSize.width
    -- local u_uvMax_y = (rect.y + rect.height) / atlasSize.height

    -- self._pixelWidth = (u_uvMax_x - u_uvMin_x) / originalSize.width;
    -- self._pixelHeight = (u_uvMax_y - u_uvMin_y) / originalSize.height;



    local tex = node:getTexture()
    tex:setAliasTexParameters()
    local size = node:getContentSize()
    print("OutLineEffect",tex)
    glState:setUniformTexture("u_texture", tex)
    glState:setUniformVec2("u_sprite_size", cc.p(size.width, size.height))
end

function OutLineEffect:resetUniform()
end

function OutLineEffect.getVert()
    return shader.vert
end

function OutLineEffect.needRefresh()
    return true
end

function OutLineEffect.getFS()
    return shader.fs
end

function OutLineEffect:resetTime(time)
    return time + 0.008
end

return OutLineEffect

