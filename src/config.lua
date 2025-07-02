
-- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 2

-- use framework, will disable all deprecated API, false - use legacy API
CC_USE_FRAMEWORK = true

-- show FPS on screen
CC_SHOW_FPS = false

-- disable create unexpected global variable
CC_DISABLE_GLOBAL = false

-- for module display
CC_DESIGN_RESOLUTION = {
    width = 1136,
    height = 640,
    autoscale = "FIXED_HEIGHT",
    callback = function(framesize)
        local ratio = framesize.width / framesize.height
        if ratio <= 1.34 then
            -- iPad 768*1024(1536*2048) is 4:3 screen
            return {autoscale = "FIXED_WIDTH"}
        end
    end
}

CC_SCENWIDTH = 1386 

function cc.GetLiuHaiX()
    --只有是全面屏 刘海屏的时候才返回不等于0的值
    local dirSize = cc.Director:getInstance():getWinSize()
    if dirSize.width/dirSize.height > 2.03 then
        local x = (CC_SCENWIDTH-1280)/2;
        return x;
    end

    return 0;
end


UTC = 8

--时间换算
MIN = 60
HOUR = 60 * MIN
DAY = 24 * HOUR
WEEK = 7 * DAY

--忽略更新
SKIP_UPT=true
