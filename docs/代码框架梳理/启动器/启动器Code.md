### 启动器代码部分
```lua
--1.
--Starter.lua 为入口：主要做一些热更新及搜索路径相关逻辑，热更新相关封装在Cpp那块

--[[
    热更新：通过比较本地res_map.txt与远端获取的md5文本的md值，不相同则加入下载列表，其中过滤已下载的文件，-->  按照队列依次进行下载->下载相关逻辑封装在cpp层
    如果比较完，没有不同，就跳过更新  
    __G_CP_SERVER_ID 变量可控制是否热更新
    reloadLauncher 用于
--]]


--2.
--下载完成：启动LauncherScene 登录输入账号界面\选服界面
function Starter:checkStarterUpdateComplete()
	self:reloadLauncher()
	
	local launcherScene = require("launcher.LauncherScene").new()
	display.runScene(launcherScene)
end

--3.开始游戏
--进行相关游戏包检测逻辑
```lua
 LauncherLayer:onStartGame()
    if needCheck then
		self:checkGameUpdate() --游戏更新安装逻辑
	else
		self:_startGame() --开始游戏
	end
 end

--开始游戏
 function LauncherLayer:_startGame()
	self:initGameSearchPath()

	-- 重新加载代码zip
	self:reloadGameCode()

	-- 启动游戏
	self:runGame()

    -- 连接服务器
    scheduler.performWithDelayGlobal(handler(self, self._connectGame), 0)
end

--4.加载游戏
function LauncherLayer:runGame()
	if _G_Game and self._delegateLayer then
		return
	end
    
	require("app.Game"):create():run()
end