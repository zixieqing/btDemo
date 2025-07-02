
# 参考资料
https://www.cnblogs.com/chevin/p/5668364.html

# 大致思路
(1) 最方便：
直接修改即可
local cachedData = sp.SkeletonData:create("spine/battle/guaji.json", "spine/battle/guaji.atlas")
local spineSP = sp.SkeletonAnimation:createWithData(cachedData)

spineSP:setPosition(display.width / 2, display.height / 2)
spineSP:addTo(self)
spineSP:setAnimation(0, "1", true)
colorReplace:render(spineSP, cc.vec3(242/255,212/255,86/255),cc.vec3(0/255,0/255,255/255))

