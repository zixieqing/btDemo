local RoleLayer = class("RoleLayer", lt.BaseLayer)
local colorReplace = require("src.app.shader.ColorReplaceEffect")
local holeEffect = require("src.app.shader.HoleEffect")

local Constant = lt.Constant
local RoleModule = lt.RoleModule
local StringManager = lt.StringManager
local ResManager = lt.ResManager
local LabelEx = lt.LabelEx
local UIMgr = lt.UIMgr
local NtfManager = lt.NtfManager

RoleLayer._armatureIdx        = nil         -- 当前选中armature的idx

RoleLayer._uiDlgRoleCreate = nil
RoleLayer._uiDlgRoleRecover= nil

RoleLayer._roleScene = nil

function RoleLayer:ctor(roleScene)
    RoleLayer.super.ctor(self)

    self._roleScene = roleScene

    self:initUI()
    self:uptLayer()
end

function RoleLayer:onClear()
    lt.LogUtil:debug("RoleLayer:onClear")
    if self._tip then
        self._tip = nil
    end    
    self:removeAllChildren()
end

function RoleLayer:onEnter()
    lt.LogUtil:debug("RoleLayer:onEnter")
    lt.ConnectManager:setDelegate(self)
    lt.SocketApi:addProtoListener(lt.SocketApi._Event.CreateRole_ACK, handler(self, self.onCreateRoleAck), "RoleLayer:onCreateRoleAck")
    lt.SocketApi:addProtoListener(lt.SocketApi._Event.DelRole_ACK, handler(self, self.onDelRoleAck), "RoleLayer:onDelRoleAck")
    lt.SocketApi:addProtoListener(lt.SocketApi._Event.UnDelRole_ACK, handler(self, self.onUnDelRoleAck), "RoleLayer:onUnDelRoleAck")
    lt.NtfManager:addNtfListener(lt.NtfManager.NTF.NTF_ALERT_TIP, handler(self, self.openSystemTip), "RoleLayer:openSystemTip")

    lt.AudioManager:playMusic("selectcharacter")
end

function RoleLayer:onExit()
    lt.LogUtil:debug("RoleLayer:onExit")
    lt.AudioManager:stopMusic(true)
    
    lt.ConnectManager:clearDelegate(self)
    lt.SocketApi:removeProtoListenerByTag("RoleLayer:onCreateRoleAck")
    lt.SocketApi:removeProtoListenerByTag("RoleLayer:onDelRoleAck")
    lt.SocketApi:removeProtoListenerByTag("RoleLayer:onUnDelRoleAck")
    lt.NtfManager:removeNtfListenerByTag("RoleLayer:openSystemTip")

    -- 移除特效
    for job=Constant.JOB_ZS, Constant.JOB_DS do
        for gender=0, 1 do
            local armatureName = string.format("model_%d_%d", job, gender)
            local armatureFile = string.format("ui/init/init_create/%s.ExportJson", armatureName)
            ccs.ArmatureDataManager:getInstance():removeArmatureFileInfo(armatureFile)
        end
    end
end

function RoleLayer:initUI()
    -- 背景
    local bgSprite = display.newSprite(ResManager:getTex("_initSelectBg01"))
    bgSprite:setPosition(display.cx, display.cy)
    self:addChild(bgSprite)

    -- local function createHollowSprite(spritePath)
    --     -- 创建一个精灵
    --     local sprite = cc.Sprite:create(spritePath)
    --     local size = sprite:getContentSize()
    
    --     -- 创建模板（Stencil）
    --     local stencil = cc.DrawNode:create()
    
    --     -- 这里绘制精灵的轮廓
    --     -- 使用精灵的边界框绘制一个矩形作为轮廓
    --     local outlineColor = cc.c4f(0, 0, 0, 1)  -- 轮廓颜色
    --     stencil:drawRect(cc.p(0, 0), cc.p(size.width, size.height), outlineColor)
    
    --     -- 创建裁剪节点
    --     local clipNode = cc.ClippingNode:create(stencil)
    --     clipNode:setInverted(true)  -- 反转裁剪效果
    
    --     -- 将精灵添加到裁剪节点
    --     clipNode:addChild(sprite)
    
    --     return clipNode
    -- end
    
    -- -- 在场景中使用
    -- local hollowSprite = createHollowSprite("ui/wing/model/40001.png")
    -- hollowSprite:setPosition(display.cx, display.cy)
    -- self:addChild(hollowSprite)
    
    



    -- local bgSprite = display.newSprite("ui/init/bg_account.jpg")
    -- bgSprite:setPosition(display.cx, display.cy)
    -- self:addChild(bgSprite)

			
    local cachedData = sp.SkeletonData:create("spine/battle/guaji.json", "spine/battle/guaji.atlas")
    local spineSP = sp.SkeletonAnimation:createWithData(cachedData)

    spineSP:setPosition(display.width / 2, display.height / 2)
    spineSP:addTo(self)
    spineSP:setAnimation(0, "1", true)
    self.spineSp = spineSP
    colorReplace:render(self.spineSp, cc.vec3(242/255,212/255,86/255),cc.vec3(0/255,0/255,255/255))

    -- holeEffect:render(spineSP)227,70,70 242,212,86

    local bgSize = bgSprite:getContentSize()
    self._players = {}
    for i=1,2 do
        local node = self:initPlayerDesc(i)
        node:setPosition(({cc.p(bgSize.width/2-255, 0), cc.p(bgSize.width/2+310, 0)})[i])
        bgSprite:addChild(node)

        self._players[#self._players + 1] = node

        local btnRole = UIMgr:createButton("_none", nil, {
            size = cc.size(250, 323),
            clickCb = function ()
                self:swithPlayer(i)
            end
        })
        btnRole:setPosition(({cc.p(bgSize.width/2-175, 380), cc.p(bgSize.width/2+170, 380)})[i])
        bgSprite:addChild(btnRole)
    end


    local createButton = UIMgr:createButton("_initCreateBtn", nil, {
        clickCb = handler(self, self.onClickCreate)
    })
    createButton:setPosition(cc.p(bgSize.width/2, 150))
    bgSprite:addChild(createButton)

    local enterButton = UIMgr:createButton("_initEnterGameBtn", nil, {
        clickCb = handler(self, self.onClickStart)
        -- clickCb = function()
        --     colorReplace:render(self.spineSp, cc.vec3(242/255,212/255,86/255))
        -- end
    })
    enterButton:setPosition(cc.p(bgSize.width/2-105, 105))
    bgSprite:addChild(enterButton)
    
    local deleteButton = UIMgr:createButton("_initDeleteBtn", nil, {
        clickCb = handler(self, self.onClickDelete)
    })
    deleteButton:setPosition(cc.p(bgSize.width/2, 105))
    bgSprite:addChild(deleteButton)

    local backButton = UIMgr:createButton("_initBackBtn", nil, {
        clickCb = handler(self, self._onClickBack)
    })
    backButton:setPosition(cc.p(bgSize.width/2+105, 105))
    bgSprite:addChild(backButton)

    local recoverButton = UIMgr:createButton("_initRecoverBtn", nil, {
        clickCb = handler(self, self.onClickRecover)
    })
    recoverButton:setPosition(cc.p(bgSize.width/2, 60))
    bgSprite:addChild(recoverButton)

    self._arrowLayer = display.newNode()
    self._arrowLayer:setPosition(cc.p(bgSize.width/2, 0))
    bgSprite:addChild(self._arrowLayer)

    self._upArrow = UIMgr:createButton("_initUpBtn", nil, {
        clickCb = handler(self, self.onClickSwitch)
    })
    self._upArrow:setTag(-1)
    self._upArrow:setPosition(cc.p(0, 420))
    self._arrowLayer:addChild(self._upArrow)

    self._downArrow = UIMgr:createButton("_initDownBtn", nil, {
        clickCb = handler(self, self.onClickSwitch)
    })
    self._downArrow:setTag(1)
    self._downArrow:setPosition(cc.p(0, 340))
    self._arrowLayer:addChild(self._downArrow)

    self._bg = bgSprite

    -- 初始化动作
    for job=Constant.JOB_ZS, Constant.JOB_DS do
        for gender=0, 1 do
            local armatureName = string.format("model_%d_%d", job, gender)
            local armatureFile = string.format("ui/init/init_create/%s.ExportJson", armatureName)
            ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(armatureFile)
        end
    end

    ---插入
    performWithDelay(self,function()
        self:onClickStart()
    end,0.3)
end

function RoleLayer:swithPlayer(index)
    local curPage = RoleModule:getCurPage()
    local numEachPage = RoleModule:getNumEachPage()
    local array = RoleModule:getRoleArray()
    if array[curPage*numEachPage+index] then
        self._armatureIdx = curPage*numEachPage+index
        RoleModule:setSelect(self._armatureIdx)
        self:setInfo()

        if self._armatures[index] then
            self._armatures[index]:playUnStone()
        end
        if self._armatures[({2, 1})[index]] then
            self._armatures[({2, 1})[index]]:playStone()
        end
    end
end

function RoleLayer:initPlayerDesc(index)
    local node = display.newNode()
    local btn = UIMgr:createButton("_initChooseBtn01", nil, {
        disableImg = "_initChooseBtn02",
        clickCb = function ()
            self:swithPlayer(index)
        end
    })
    btn:setZoomScale(0)
    btn:setPosition(cc.p(10, 155))
    node:addChild(btn)

    -- name
    local szName = LabelEx.new("", {font=Constant.FONT_2, size=14, color=Constant.COLOR_TEXT_WHITE})
    szName:setPosition(0, 118)
    node:addChild(szName)

    local szLv = LabelEx.new("", {font=Constant.FONT_2, size=14, color=Constant.COLOR_TEXT_WHITE})
    szLv:setPosition(0, 90)
    node:addChild(szLv)

    local szJob = LabelEx.new("", {font=Constant.FONT_2, size=14, color=Constant.COLOR_TEXT_WHITE})
    szJob:setPosition(0, 62)
    node:addChild(szJob)

    function node:updateData(data)
        if not data then
            btn:setEnabled(false)
            szName:setString("")
            szJob:setString("")
            szLv:setString("")

            return
        end

        local curPage = RoleModule:getCurPage()
        local numEachPage = RoleModule:getNumEachPage()
        btn:setEnabled((curPage*numEachPage+index) ~= RoleModule:getSelect())
        szName:setString(data:getName())
        szJob:setString(StringManager:getJobName(data:getJob()))

        -- if data:getRealm() > 0 then
        --     szLv:setString(StringManager:getLevel(data:getLevel()))
        -- else
        --     szLv:setString(data:getLevel())
        -- end
        --转生修改
        szLv:setString(data:getLevel())
    end

    return node
end

function RoleLayer:uptLayer()
    self._armatureIdx = self._armatureIdx or RoleModule:getSelect()
    self:showRoleLayer()
    self:showArmature()
    self:setInfo()
end
function RoleLayer:showRoleLayer()
    if self._uiDlgRoleCreate then
        self._uiDlgRoleCreate:setVisible(false)
        self._uiDlgRoleCreate:removeTouch()
    end

    self._arrowLayer:setVisible(RoleModule:getOwnRoleCount() > RoleModule:getNumEachPage())

    self._upArrow:setVisible(true)
    self._downArrow:setVisible(true)
    local curPage = RoleModule:getCurPage()
    if curPage == 0 then
        self._upArrow:setVisible(false)
    end
    if curPage == math.ceil(RoleModule:getOwnRoleCount() / 2) - 1 then
        self._downArrow:setVisible(false)
    end

    for i,v in ipairs(self._armatures or {}) do
        v:setVisible(true)
    end
end

function RoleLayer:hideRoleLayer()
    self._arrowLayer:setVisible(false)
    for i,v in ipairs(self._armatures) do
        v:setVisible(false)
    end
end

function RoleLayer:showArmature()
    for i=1,2 do
        if self._armatures and self._armatures[i] then
            self._armatures[i]:removeSelf()
        end
    end
    self._armatures = {}

    local roleArray = RoleModule:getRoleArray()
    local page = RoleModule:getCurPage()
    local numEachPage = RoleModule:getNumEachPage()
    self._armatureIdx = RoleModule:getSelect()
    for i=1,2 do
        local index = page*numEachPage + i
        if roleArray[index] then
            self._armatures[i] = lt.RoleArmature.new({ job = roleArray[index]:getJob(), sex = roleArray[index]:getSex() })
            self._armatures[i]:setPosition(cc.p(self._bg:getContentSize().width/2 + (i==1 and -190 or 160), 230))

            self._bg:addChild(self._armatures[i])

            if self._armatureIdx == index then
                self._armatures[i]:playIdle()
            else
                self._armatures[i]:playStone(true)
            end
        end
    end

end

function RoleLayer:playSound(job,sex)
    local soundId = nil
    if job == 1 and sex == 0 then
        soundId = lt.ResManager.SOUND_NUM.CREATE_ZS_FEMALE
    elseif job == 1 and sex == 1 then
        soundId = lt.ResManager.SOUND_NUM.CREATE_ZS_MALE
    elseif job == 2 and sex == 0 then
        soundId = lt.ResManager.SOUND_NUM.CREATE_FS_FEMALE
    elseif job == 2 and sex == 1 then
        soundId = lt.ResManager.SOUND_NUM.CREATE_FS_MALE
    elseif job == 3 and sex == 0 then
        soundId = lt.ResManager.SOUND_NUM.CREATE_DS_FEMALE
    elseif job == 3 and sex == 1 then
        soundId = lt.ResManager.SOUND_NUM.CREATE_DS_MALE
    end
    lt.AudioManager:playSound(soundId)
end

function RoleLayer:selectArmature(touchIdx)
    if touchIdx and touchIdx == self._armatureIdx then
        return
    end

    local idx = RoleModule:getSelect()
    self._armatureIdx = idx

    local left_side = idx % 2 == 1
    if left_side then
        self._armature1:setColor(cc.c3b(255, 255, 255))
        self._armature1:getAnimation():playWithIndex(1)
        local roleArray = RoleModule:getRoleArray()
        self:playSound(roleArray[idx]._job, roleArray[idx]._sex)
        
        if self._armature2 then
            self._armature2:setColor(cc.c3b(128, 128, 128))
            self._armature2:getAnimation():playWithIndex(0)
        end

        self._nameLabel1:setColor(Constant.COLOR_TEXT_WHITE)
        self._jobLabel1:setColor(Constant.COLOR_TEXT_WHITE)
        self._levelLabel1:setColor(Constant.COLOR_TEXT_WHITE)
        --self._dumbLabel1:setColor(Constant.COLOR_TEXT_WHITE)

        self._nameLabel2:setColor(Constant.COLOR_TEXT_GRAY)
        self._jobLabel2:setColor(Constant.COLOR_TEXT_GRAY)
        self._levelLabel2:setColor(Constant.COLOR_TEXT_GRAY)
        --self._dumbLabel2:setColor(Constant.COLOR_TEXT_GRAY)
    else
        self._armature1:setColor(cc.c3b(128, 128, 128))
        self._armature1:getAnimation():playWithIndex(0)

        if self._armature2 then
            self._armature2:setColor(cc.c3b(255, 255, 255))
            self._armature2:getAnimation():playWithIndex(1)
            local  roleArray = RoleModule:getRoleArray()
            self:playSound(roleArray[idx]._job, roleArray[idx]._sex)
        end

        self._nameLabel1:setColor(Constant.COLOR_TEXT_GRAY)
        self._jobLabel1:setColor(Constant.COLOR_TEXT_GRAY)
        self._levelLabel1:setColor(Constant.COLOR_TEXT_GRAY)
        --self._dumbLabel1:setColor(Constant.COLOR_TEXT_GRAY)

        self._nameLabel2:setColor(Constant.COLOR_TEXT_WHITE)
        self._jobLabel2:setColor(Constant.COLOR_TEXT_WHITE)
        self._levelLabel2:setColor(Constant.COLOR_TEXT_WHITE)
        --self._dumbLabel2:setColor(Constant.COLOR_TEXT_WHITE)
    end
end

function RoleLayer:setInfo()
    local roleArray = RoleModule:getRoleArray()
    local page = RoleModule:getCurPage()
    local numEachPage = RoleModule:getNumEachPage()

    self._players[1]:updateData(roleArray[page*numEachPage + 1])
    self._players[2]:updateData(roleArray[page*numEachPage + 2])
end

function RoleLayer:getRoleNameCur()
    local name = nil
    local roleArray = RoleModule:getRoleArray()
    local idx = RoleModule:getSelect()
    if roleArray[idx] then
        name = roleArray[idx]:getName()
    end
    return name
end

-- 按钮事件
function RoleLayer:onClickStart(event)
    local roleName = self:getRoleNameCur()
    if not roleName then
        local tip = lt.UIWgtFloatTip.new({content = StringManager:getString(StringManager.KEY_TIP_CREATE)})
        tip:setPosition(display.cx, display.cy)
        self:addChild(tip, 999)
        lt.LogUtil:debug("RoleName is nil...")
        return
    end

    lt.LogUtil:debug("lt.SocketApi:selectRoleReq:" .. roleName)
    lt.SocketApi:selectRoleReq(roleName)

    lt.RoleModule:setCurRoleName(roleName)

    -- init setItemData
    --lt.CommonModule:setItemData()
    -- 登陆统计
    if (device.platform == "ios" or device.platform == "android") and cpp.SdkService:shared().statisLogin then
        local createTime = ""
        local roleId = ""
        local roleLevel = ""
        local roleName = ""
        local serverId = ""
        local serverName = ""

        local roleArray = RoleModule:getRoleArray()
        local role = roleArray[self._armatureIdx]
        if role then
            roleLevel = role:getLevel()
            roleName = role:getName()
            createTime = lt.CommonUtil:string2time(role:getCreateTime())
            roleId = role:getPlayerId()
        end
        if _G_SERVER_INFO then
            serverId = tostring(_G_SERVER_INFO.id)
            serverName = tostring(_G_SERVER_INFO.name)
        end

        cpp.SdkService:shared():statisLogin(createTime, roleId, roleLevel, roleName, serverId, serverName)
    end

    if (device.platform == "ios" or device.platform == "android") or _G_STARTER_MODE then
        local gameId = 0
        local uuid = ""
        local serverId = ""
        local roleId = ""
        local roleName = ""
        local createTime = ""
        local roleLevel = ""

        if _G_GAME_INFO then
            gameId = _G_GAME_INFO.id
        end
        if _G_TOKEN then
            uuid = _G_TOKEN
        end
        if _G_SERVER_INFO then
            serverId = tostring(_G_SERVER_INFO.id)
        end

        local roleArray = RoleModule:getRoleArray()
        local role = roleArray[self._armatureIdx]
        if role then
            roleId = role:getPlayerId()
            roleName = role:getName()
            createTime = lt.CommonUtil:string2time(role:getCreateTime())
            roleLevel = role:getLevel()
        end

        lt.HttpApi:plyLoginStatistics(gameId, uuid, serverId, roleId, roleName, createTime, roleLevel)
    end
end

function RoleLayer:openSystemTip(event)
    param = event.param
    self._tip = lt.UIDlgTip.new({
        content = param.content,
        btns = param.btns,
        title = StringManager:getString(StringManager.KEY_SYSTEM_TIP),
        callback = function(state)
            if param.offLine then 
                local fadeOutView = lt.FadeOutView.new(function()
                    self:goLauncher()
                end)
                self:addChild(fadeOutView)
                lt.RoleModule:clear()
            else
                local callback = param.callback
                if callback then
                    callback(state)
                end
                self._tip = nil
            end  
        end,
        otherWay = true,
        mask = true
    })
    self._tip:setPosition(display.cx, display.cy)
    self._roleScene:addChild(self._tip, 10)
end

function RoleLayer:openScrollTip(param)
    self._tip = lt.UIDlgScrollTip.new({
        content = param.content,
        btns = param.btns,
        title = StringManager:getString(StringManager.KEY_SYSTEM_TIP),
        callback = function(state)
            local callback = param.callback
            if callback then
                callback(state)
            end
            self._tip = nil
        end,
        otherWay = true,
        mask = true
    })

    self._tip:setPosition(display.cx, display.cy)
    self._roleScene:addChild(self._tip, 10)
end


function RoleLayer:onClickCreate(event)
    if RoleModule:getOwnRoleCount() == RoleModule:getMaxRoleNum() then
        lt.NtfManager:dispatchNtf(lt.NtfManager.NTF.NTF_ALERT_TIP, {
            content = StringManager:getString(StringManager.KEY_TIP_CREATE_OUT), 
            btns = { Constant.COMMON_TIP_BTN.BTN_CONFIM }
        })
        return
    end

    self:hideRoleLayer()
    self:showRoleCreateDlg()
end

function RoleLayer:onClickDelete(event)

    if RoleModule:isDelRoleLimit() then
        lt.NtfManager:dispatchNtf(lt.NtfManager.NTF.NTF_ALERT_TIP, {content = StringManager:getString(StringManager.KEY_TIP_DEL_LIMITE)})
        return
    end

    local  roleArray = RoleModule:getRoleArray()
    if roleArray[self._armatureIdx] then
        local roleName = roleArray[self._armatureIdx]._name
        lt.NtfManager:dispatchNtf(lt.NtfManager.NTF.NTF_ALERT_TIP, 
                                    {content = string.format(StringManager:getString(StringManager.KEY_TIP_CREATE_DEL), roleName),
                                    callback = function (state)
                                        if state == Constant.COMMON_TIP_BTN.BTN_CONFIM then
                                            RoleModule:deleteRoleReq(roleName)
                                        end
                                    end})
    end
end

function RoleLayer:onClickRecover(event)
    if not self._uiDlgRoleRecover then
        self._uiDlgRoleRecover = lt.UIDlgRoleRecover.new()
        self._roleScene:addChild(self._uiDlgRoleRecover)
    end

    self._uiDlgRoleRecover:show(job, gender)
end

function RoleLayer:onClickBack(event)
    if RoleModule:isHaveRole() then
        self:showRoleLayer()
    else
        self:_onClickBack()
    end
end

function RoleLayer:_onClickBack()
    local fadeOutView = lt.FadeOutView.new(function()
        -- 断开网络
        print("断开网络")
        -- lt.SocketManager:disconnect()

        self:goLauncher()
    end)
    self:addChild(fadeOutView)

    lt.RoleModule:clear()
    lt.LoginCmd:logoutReq()
    lt.SocketManager:willKick()
end

function RoleLayer:onClickSwitch(sender)
    RoleModule:setCurPage(RoleModule:getCurPage() + sender:getTag())
    self:uptLayer()
end

-- 网络事件
function RoleLayer:onCreateRoleAck(event)
    local data = event.param
    -- dump(data)
    if data and data._byResult == lt.CliGgProto.PROTO_SUCCESS then
        -- dump(data._stReply._stSucc)
        RoleModule:refreshData(data._stReply._stSucc)
        self:uptLayer()

        self:openScrollTip({
            content = StringManager:getString(StringManager.KEY_TIP_CREATE_SUCCESS), 
            btns = {Constant.COMMON_TIP_BTN.BTN_CONFIM}
        })
-- 
        -- 创角统计
        if (device.platform == "ios" or device.platform == "android") and cpp.SdkService:shared().statisCreateRole then
            local createTime = ""
            local roleId = ""
            local roleLevel = ""
            local roleName = ""
            local serverId = ""
            local serverName = ""
            local roleJob = ""

            local roleArray = RoleModule:getRoleArray()
            local role = roleArray[RoleModule:getSelect()]
            if role then
                roleLevel = role:getLevel()
                roleName = role:getName()
                createTime = lt.CommonUtil:string2time(role:getCreateTime())
                roleId = role:getPlayerId()
            end

            if _G_SERVER_INFO then
                serverId = tostring(_G_SERVER_INFO.id)
                serverName = tostring(_G_SERVER_INFO.name)
            end

            cpp.SdkService:shared():statisCreateRole(createTime, roleId, roleLevel, roleName, serverId, serverName)
        end

        if (device.platform == "ios" or device.platform == "android") or _G_STARTER_MODE then
            local gameId = 0
            local uuid = ""
            local serverId = ""
            local roleId = ""
            local roleName = ""
            local createTime = ""
            local roleJob = ""

            if _G_GAME_INFO then
                gameId = _G_GAME_INFO.id
            end
            if _G_TOKEN then
                uuid = _G_TOKEN
            end
            if _G_SERVER_INFO then
                serverId = tostring(_G_SERVER_INFO.id)
            end

            local roleArray = RoleModule:getRoleArray()
            local role = roleArray[self._armatureIdx]
            if role then
                roleId = role:getPlayerId()
                roleName = role:getName()
                createTime = lt.CommonUtil:string2time(role:getCreateTime())
                roleJob = role:getJob()
            end

            lt.HttpApi:plyCreateStatistics(gameId, uuid, serverId, roleId, roleName, createTime, roleJob)
        end

    elseif data._byResult == lt.CliGgProto.PROTO_FAILURE then
        local errorId = data._stReply._stFail._wErrCode
        if errorId then
            lt.NtfManager:dispatchNtf(lt.NtfManager.NTF.NTF_ALERT_TIP, {content = StringManager:getStringByErrorCode(errorId),
                                                                    btns = {Constant.COMMON_TIP_BTN.BTN_CONFIM}})
        end
    end
end

function RoleLayer:onDelRoleAck(event)
    lt.LogUtil:debug("RoleLayer:onDelRoleAck")
    local data = event.param
    if data and data._byResult == lt.CliGgProto.PROTO_SUCCESS then
        RoleModule:deletRole(self._armatureIdx)
        self:uptLayer()
    elseif data._byResult == lt.CliGgProto.PROTO_FAILURE then
        local errorId = data._stReason._wErrCode
        if errorId then
            lt.NtfManager:dispatchNtf(lt.NtfManager.NTF.NTF_ALERT_TIP, {content = StringManager:getStringByErrorCode(errorId),
                                                                    btns = {Constant.COMMON_TIP_BTN.BTN_CONFIM}})
        end
    end
end

function RoleLayer:onSelectRoleAck(event)
    lt.LogUtil:debug("RoleLayer:onSelectRoleAck")
    local data = event.param
    if data and data._byResult == lt.CliGgProto.PROTO_SUCCESS then
        lt.LogUtil:debug("RoleLayer:onSelectRoleAck success")
    else
        lt.LogUtil:debug("onSelectRoleAck Fail")
    end
end

function RoleLayer:onUnDelRoleAck(event)
    local data = event.param
    if data and data._byResult == lt.CliGgProto.PROTO_SUCCESS then
        RoleModule:recoverRole()
        self:uptLayer()
    else
        local errorId = data._stReason._wErrCode
        if errorId then
            lt.NtfManager:dispatchNtf(lt.NtfManager.NTF.NTF_ALERT_TIP, {content = StringManager:getStringByErrorCode(errorId),
                                                                    btns = {Constant.COMMON_TIP_BTN.BTN_CONFIM}})
        end
    end
end

function RoleLayer:onKickOff(event)
    lt.NtfManager:dispatchNtf(lt.NtfManager.NTF.NTF_ALERT_TIP, 
                                                    {content = lt.StringManager:getString(lt.StringManager.KEY_CONNECTING_FAIL),
                                                      btns = {lt.Constant.COMMON_TIP_BTN.BTN_CONFIM},offLine = true})
end

function RoleLayer:onBillBoardCmd(event)
    local proto = event.param
    lt.LogUtil:debug("RoleLayer:onBillBoardCmd:" .. proto.msg)
    
    -- 进入游戏场景
    local gameScene = lt.GameScene.new()
    display.runScene(gameScene)
end

function RoleLayer:showRoleCreateDlg(job, gender)
    if not self._uiDlgRoleCreate then
        self._uiDlgRoleCreate = lt.UIDlgRoleCreate.new()
        self._uiDlgRoleCreate:setPosition(cc.p(self._bg:getContentSize().width/2, 0))
        self._bg:addChild(self._uiDlgRoleCreate, 1)

        self._uiDlgRoleCreate:setCloseCb(handler(self, self.onClickBack))
    end

    self._uiDlgRoleCreate:show(job, gender)
end

function RoleLayer:goLauncher()
    if _G_Game then
        _G_Game:resetScene()
    end
end

return RoleLayer
