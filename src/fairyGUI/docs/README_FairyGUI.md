## FGUI 相关

### 1.相关文档
官方文档：https://fairygui.com/docs/sdk/cocos2dx 
官方C++版仓库：https://github.com/fairygui/FairyGUI-cocos2dx/


### 2.测试demo接入

```lua
--加入以下代码， 按下快捷键即可（2）
if device.platform == "windows" then
	self:addHelperKeyboardListener()
end

function LauncherScene:addHelperKeyboardListener()
	local EventDispatcher = cc.Director:getInstance():getEventDispatcher()
	local keyboardListener = cc.EventListenerKeyboard:create()

	local function onKeyReleased(key, event)
		if key == cc.KeyCode.KEY_2 then
			local BaseScene = require("fairyGUI.views.MenuScene").new()
			display.runScene(BaseScene)
		end
	end

	keyboardListener:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED)

	EventDispatcher:addEventListenerWithSceneGraphPriority(keyboardListener, self)
end

```


### 3.工具链使用
（1）PSD 转换为FGUI package :https://github.com/fairygui/psd2fgui.git


### 5.TODO
1.研究把fgui相关接口lua接口导出一份文档出来
2.高级组node 无法通过代码获取问题：MenuScene btns为高级组，无法进行获取
3.Window类接口：覆盖OnShown,OnHide 等接口
4.GList类 设置虚拟列表：onConstruct覆盖问题


### 6.注意

1. 普通组】仅在编辑时有效，是辅助你进行UI设计的。普通组发布后不存在，也就是在运行时无法访问到普通组。
2. 添加资源，如果代码中需要用，一定要设置导出
3. GTween使用报错：
 error:fgui.GTween:to 有报这个是正常的： 因为会依次判断三个不同参数的类型
     `fgui.GTween:to argument #2 is 'number'; 'table' expected.`
 这里错误才是错误打印
 `msg:        [string ".\fairyGUI/views/TransitionDemoScene.lua"]:99: fgui.GTween:to has wrong number of arguments: 4, was expecting 3`

    4.Window类使用：

	如果lua 层需要实现onHide, onShow,doShowAnimation,doHideAnimation 等，请使用

 拓展类：LuaWindow，并调用enableWindowEvents方法，即可使用

