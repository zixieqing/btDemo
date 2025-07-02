---@class UIPanelBase fgui基础组件类
local UIPanelBase = class("UIPanelBase", fgui.GComponent)

function UIPanelBase:ctor(param)
    self.isFairyGUI = true
    
    self:retain()
    self:setParam(param)
    
end

function UIPanelBase:onInit(url)
    local pkgName, resName = lt.FGUIUtil:normalizeURL(url)
    print("UIPanelBase:onInit(url)", pkgName, resName)
    local obj = fgui.UIPackage:createObject(pkgName, resName)
    self.obj = obj
    self:addChild(obj)
    self:setSize(obj:getSize().width, obj:getSize().height)
    self:center();
    self:setProperyByParam()
end

function UIPanelBase:show()
    self:setVisible(true)
end
function UIPanelBase:hide()
    self:setVisible(false)
end



----------------------------功能----------------------------------------

function UIPanelBase:setProperyByParam()
    local params = self:getParam() or {}
  
end



------------------------------补丁----------------------------------------

function UIPanelBase:onClear()
    self:release()
end

function UIPanelBase:getContentSize()
    return self:getSize()
end

function UIPanelBase:checkRedTips(name)
    
end

function UIPanelBase:setSelfPos()
    self:center()
end

function UIPanelBase:setLocalZOrder(zorder)
    print('UIPanelBase:setLocalZOrder(zorder)',zorder)
    self:setSortingOrder(zorder)
end
function UIPanelBase:getLocalZOrder()
    print("UIPanelBase:getLocalZOrder()", self:getSortingOrder())
    return self:getSortingOrder()
end
function UIPanelBase:onCloseView()
    self:getDialogSystem():closeView(self:getParam().layerName)
end

function UIPanelBase:onOpenView()
    -- self:show()
end

function UIPanelBase:contain(point)
    local bounds = self:getSize()
    local point = lt.FGUIUtil:fGuiPosToCocos(point)
    local x,y = self:getPosition()
    local rect = {
        x = x,
        y = y,
        width = bounds.width,
        height = bounds.height
    }
    local isContain = cc.rectContainsPoint(rect, point)
    return isContain
end


function UIPanelBase:openView(layerName, param)
    if not param then param = {} end
    self:getDialogSystem():openView(layerName,param)
end

function UIPanelBase:setParam(param)
    self._param = param
end

function UIPanelBase:getParam()
    return self._param
end

function UIPanelBase:getDialogSystem()
    return self.dialogSystem
end

function UIPanelBase:touchEvent()
    -- self._touchArea = self:getFrame():getChild("dragArea")
    self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self.onTouchWindowBegan));
    self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self.onTouchWindowMoved));
    self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self.onTouchWindowEnded));
end

function UIPanelBase:onTouchWindowBegan(context)
    print("UIPanelBase:onTouchBegan(context)")
    -- local touchPoint = context:getInput():getPosition()
    -- -- local point = fgui.GRoot:getInstance():globalToLocal(touchPoint)
    -- local point = lt.FGUIUtil:fGuiPosToCocos(touchPoint)
    -- local selectTouch = self:getDialogSystem():onTouchBegan(point)
    -- local ownTouch = self:contain(point)
    -- if selectTouch and ownTouch then
        return true
    -- end
    -- return false
end

function UIPanelBase:onTouchWindowMoved(context) 
    -- local touchPoint = context:getInput():getPosition()
    -- local point = fgui.GRoot:getInstance():globalToLocal(touchPoint)
    -- print("UIPanelBase:onTouchMoved(point)")
    -- self:getDialogSystem():onTouchMoved(point)

end

function UIPanelBase:onTouchWindowEnded(context)
--     local touchPoint = context:getInput():getPosition()
--     local point = fgui.GRoot:getInstance():globalToLocal(touchPoint)
    print("UIPanelBase:onTouchEnded(point)")
--     self:getDialogSystem():onTouchEnded(point)
end

function UIPanelBase:onTouchBegan(point)
end

function UIPanelBase:onTouchMoved(point) 
end

function UIPanelBase:onTouchEnded(point)
end



function UIPanelBase:getPosition()
    return self:getX(), self:getY()
end

function UIPanelBase:setPositionEx(offX, offY)
    local x, y = self:getPosition()
    x = x + offX
    y = y + offY
    
    self:setPosition(x, y)
end


return UIPanelBase









