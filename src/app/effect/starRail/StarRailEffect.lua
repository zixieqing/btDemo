
-- 星穹铁道首页(多个shader)
---@class StarRailEffect

local loadingLogo = "starRail/loadingLogo.png"
local particle = "starRail/trainParticle.png"


local shader = {
    ["StarRailLoading"] = {
        fs = require "app.shader.StarRailFS",
        vert = require "app.shader.StarRailVS",
    },
    ["LoadingParticle"] = {
        fs = require "app.shader.starRail.LoadingParticleFS",
        vert = require "app.shader.starRail.LoadingParticleVS",
    }

}
   
local StarRailEffect = class("StarRailEffect")

function StarRailEffect.getDescText()
    return "星穹铁道首页"
end

function StarRailEffect:init(node)
    -- node:spTouchUseShader(loadingLogo, "StarRailLoading")

    -- local particleTex = display.newSprite(particle)
    -- node:addChild(particleTex)
    -- particleTex:setPosition(display.cx + 200, display.cy + 100)

    node:spTouchUseShader(particle,"LoadingParticle")

end

function StarRailEffect:setUniform(glState, time, node, shaderName)
    if self["setUniform_"..shaderName] then
        self["setUniform_"..shaderName](self,glState, time, node)
    end
end

function StarRailEffect:bindAttrCustom(p,shaderName)
    if self["setAttr_"..shaderName] then
        self["setAttr_"..shaderName](self, p)
    end
end

---------------------------------------setUniform-------------------------------------------------------------

function StarRailEffect:setUniform_StarRailLoading(glState, time, node)
    glState:setUniformFloat("progress", time)
    glState:setUniformVec2("resolution", cc.p(690,542))
    -- glState:setUniformVec2("resolution", cc.p(display.width, display.height))
    glState:setUniformVec2("center", cc.p(0.5, 0.5))
    glState:setUniformVec3("highlight", cc.vec3(35/255, 117/255,218/255)) 
    local tex = node:getTexture()
    glState:setUniformTexture("diffuse", tex)
end



-- 生成贝塞尔曲线控制点数据
local function generateCircularBezierPoints(numSegments, radius, centerX, centerY)
    local bezierPoints = {}
    for i = 0, numSegments - 1 do
        local angle = (i / numSegments) * (2 * math.pi)  -- 计算当前点的角度
        local x = centerX + radius * math.cos(angle)  -- 计算 x 坐标
        local y = centerY + radius * math.sin(angle)  -- 计算 y 坐标
        local z = 0  -- z 坐标可以固定为 0
        table.insert(bezierPoints, {x,y,z})  -- 将控制点添加到数组中
    end
    return bezierPoints
end

function StarRailEffect:setUniform_LoadingParticle(glState, time, node)
   
    local tex = node:getTexture()
    glState:setUniformTexture("diffuse", tex)

    glState:setUniformFloat("time", time)

    -- 设置其他 uniforms
    glState:setUniformFloat("progress", 0.1)
    glState:setUniformFloat("ending", 0.9)

    -- 设置 bezierPos 数组
    local dir = 2
    local bezierPos = {
        cc.vec3(1200 * dir, 0, 0),
        cc.vec3(700 * dir, 0, 0),
        cc.vec3(500 * dir, 0, 0),
        cc.vec3(250 * dir, 0, 0),
        cc.vec3(150 * dir, 150 * dir, 0),
        cc.vec3(0, 200 * dir, 0),
        cc.vec3(-150 * dir, 150 * dir, 0),
        cc.vec3(-200 * dir, 0, 0),
        cc.vec3(-200 * dir, 0, 0)
    }

    local vetexPoints = {}
    for k, v in pairs(bezierPos) do
        table.insert(vetexPoints, v.x)
        table.insert(vetexPoints, v.y)
        table.insert(vetexPoints, v.z)
    end

    glState:setUniformVec3v("bezierPos",#bezierPos, vetexPoints)

    local startArr = {}
    local ctrlArr = {}
    local endArr = {}
    local rndArr = {}
    
        startArr["x"] = 5 * (2 * math.random() - 1) + 50
        startArr["y"] = 15 * (2 * math.random() - 1) + 25
        startArr["z"] = 30 * (2 * math.random() - 1)

        ctrlArr["x"] = 100 * -(2 * math.random() - 1) - 700
        ctrlArr["y"] = 30 * (2 * math.random() - 1) + 100
        ctrlArr["z"] = 350 * (2 * math.random() - 1) - 250

        endArr["x"] = 300 * -(2 * math.random() - 1) - 900
        endArr["y"] = 100 * (2 * math.random() - 1) + 20
        endArr["z"] = 150 * (2 * math.random() - 1) - 200

        rndArr["x"] = .15 * math.random() + .02
        rndArr["y"] = math.random()
        rndArr["z"] = .8 * math.random() + .2
    glState:setUniformVec3("start",startArr)
    glState:setUniformVec3("end",endArr)
    glState:setUniformVec3("rnd",rndArr)

    

end



----------------------------------set attribute------------------

function StarRailEffect:setAttr_LoadingParticle(p)
    ---这里不能在lua 里加；自定义的话需要在c++ 里加
    p:bindAttribLocation("start",0)  
    p:bindAttribLocation("end",1) 
    p:bindAttribLocation("rnd",2) 
end


function StarRailEffect:resetUniform(glState, time)
    -- glState:setUniformFloat("progress", time)
    glState:setUniformFloat("time", time)

    
    local startArr = {}
    local ctrlArr = {}
    local endArr = {}
    local rndArr = {}
    
        startArr["x"] = 5 * (2 * math.random() - 1) + 50
        startArr["y"] = 15 * (2 * math.random() - 1) + 25
        startArr["z"] = 30 * (2 * math.random() - 1)

        ctrlArr["x"] = 100 * -(2 * math.random() - 1) - 700
        ctrlArr["y"] = 30 * (2 * math.random() - 1) + 100
        ctrlArr["z"] = 350 * (2 * math.random() - 1) - 250

        endArr["x"] = 300 * -(2 * math.random() - 1) - 900
        endArr["y"] = 100 * (2 * math.random() - 1) + 20
        endArr["z"] = 150 * (2 * math.random() - 1) - 200

        rndArr["x"] = .15 * math.random() + .02
        rndArr["y"] = math.random()
        rndArr["z"] = .8 * math.random() + .2
    glState:setUniformVec3("start",startArr)
    glState:setUniformVec3("end",endArr)
    glState:setUniformVec3("rnd",rndArr)


end

function StarRailEffect.getVert(name)
    return shader[name].vert
end

function StarRailEffect.needRefresh()
    return true
end

function StarRailEffect.getFS(name)
    return shader[name].fs
end

function StarRailEffect:resetTime(time)
    return time + 0.01
end

return StarRailEffect

