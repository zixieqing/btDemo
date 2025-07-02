
#### 1.目录结构
|-- LuaDebug.lua  调试文件
|-- app
|   |-- Game.lua 进行游戏前置初始化操作
|   |-- GameConfig.lua 游戏配置
|   |-- Init.lua 将文件结构目录Lua文件，进行字段映射，方便维护
|   |-- common  通用字段定义
|   |-- data    1.dao 配表数据查询  2.meta 配表数据封装  3.model 数据业务逻辑类封装
|   |-- game    游戏内相关处理
|   |-- helper  一些简易游戏功能便捷类封装
|   |-- manager 相关管理器类 【HangupManager 挂机管理器 , AutoManager 各种自动化功能,例如自动使用技能、拾取物品和移动角色】
|   |-- module 接受服务器数据，以及数据相关方法封装，方便Scene类使用  ，init 在ConnectManager.init内就开始处理接受
|   |-- net   协议相关，协议号定义，协议接口
|   |-- scene 游戏场景UI 1.UIDlg 窗口  2.UIWgt 窗口内小组件 
|   |-- thirdparty  第三方lua库 
|   `-- util     拓展系统工具
|-- cocos        cocos库
|-- config.json  cocos 系统配置
|-- config.lua   lua cocos 配置
|-- game.lua     游戏相关配置（服务器地址）
|-- lib          第三方库
|   `-- utf8.lua
|-- main.lua     入口
|-- packages
|   `-- mvc   基础父类的封装：AppBase,ViewBase
`-- updater    游戏热更新相关
    |-- updateStr.lua
    `-- updater.lua

#### 2.功能开发：MVC 交互方式

```lua
--[[
    以邮件系统为参照：
--]]

--1.接受服务器数据  【MailModule】  ---接受服务器数据，调用数据类  将接受到数据set到数据处理
SocketApi:addProtoListener(ServerCmdDef.RES_EMAIL_LIST, handler(self, self.onMailList), "MailModule:onMailList")

--2.监听
function MailModule:onMailList(event)
    self._mailArray = {}

    local proto = event.param.emailList
    for i,v in ipairs(proto) do
        local data = MailData.new()   --【单个数据类封装】MailData
        data:setRowID(v.rowID)
        data:setSender(v.sender)
        data:setTitle(v.title)
        data:setDate(v.date)
        data:setEmailType(v.emailType)
        data:setReadFlag(v.readFlag)
        data:setDrawFlag(v.drawFlag)
        data:autoOrder()

        self._mailArray[#self._mailArray+1] = data
    end

    table.sort(self._mailArray, function(a, b)
        if a:getOrder() ~= b:getOrder() then
            return a:getOrder() < b:getOrder()
        else
            return a:getDate() > b:getDate()
        end
    end)

    NtfManager:dispatchNtf(NtfManager.NTF.NET_MAIL_LIST) --【发送事件到View层】
end

--3.View层 进行接收并处理UI逻辑 【UIDlgMail】
NtfManager:addNtfListener(NtfManager.NTF.NET_MAIL_LIST, handler(self, self.onMailListUpdate), "UIDlgMail:onMailListUpdate")
function UIDlgMail:onMailListUpdate()  --【UI层去处理UI相关逻辑】
    local data = MailModule:getListData()
    if not self._mailListView then
        self._mailListView = ListView.new(self._listNode, {
            renderItemCallBack = handler(self,self._renderItemFun),
            totalNumber = #data,
        })
    else
        self._mailListView:reload({totalNumber = #data})
    end

    local state = MailModule:hasDrawMails()

    self._btnAutoDraw:setVisible(state)
    self._btnAutoRead:setVisible(not state)

    if #data > 0 and self._curSelectIndex == nil then
        self:readMail(1)
    end
end
```


#### 3.前后流程

#### d.代码前后梳理

```lua 
function Game:run()
    if _G_STARTER_MODE then
        -- 启动器模式
        local layer = lt.InitLauncherLayer.new()
        local scene = display.getRunningScene()
        if scene then
            scene:addDelegateLayer(layer)
        end
    else
        local initScene = lt.InitScene.new()
        display.runScene(initScene)  --待查看
    end
end

--InitLauncherLayer-> onLoginGameAck 收到服务器-> RoleScene 进入创角界面 ->点击开始selectRoleReq->onBillBoardCmd-> GameScene->GameLayerUI, GameLayerUIMenu

```