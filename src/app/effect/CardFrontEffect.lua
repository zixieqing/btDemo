
-- 卡牌正面搓牌
---@class CardFrontEffect

local test_sp = "yanqing.png"

local shader = {
    fs = require "app.shader.CardFrontFS",
    vert = require "app.shader.NormalVS",
}

local CardFrontEffect = class("CardFrontEffect")

function CardFrontEffect.getDescText()
    return "卡牌正面搓牌"
end

function CardFrontEffect:init(node)
    node:spTouchUseShader(test_sp, "poker_front")
end

function CardFrontEffect:setUniform(glState, time, node)
    math.randomseed(os.time() * 22)

    local tex = node:getTexture()
    -- glState:setUniformTexture("u_texture", tex)
    glState:setUniformInt("type", 1)

    -- glState:setUniformVec2("u_sprite_size", cc.p(800, 800))
    -- glState:setUniformFloat("u_OutlineWidth", 20)

    -- local a_color = cc.c4f(1.0, 0.84, 0.0, 1.0); -- 金黄色，完全不透明
    -- glState:setUniformVec4("u_outlineColor", a_color)  --从这里传进去颜色值的不生效？？？而直接写在shader 里的能生效

end

function CardFrontEffect:resetUniform()
end

function CardFrontEffect.getVert()
    return shader.vert
end

function CardFrontEffect.needRefresh()
    return true
end

function CardFrontEffect.getFS()
    return shader.fs
end

function CardFrontEffect:resetTime(time)
    return time + 0.5
end

return CardFrontEffect

