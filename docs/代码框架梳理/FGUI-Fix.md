### FGUI-Fix-Game
FGUI 兼容老游戏;主要需要拓展一些基础组件

#### 胶水层构建
由于兼容老的UI方式，命名方式不变， 能够同时兼容两种开发方式，通过传参数
原来的命名保持不变


#### 基础架构构建
能够保证原有UI框架实现的功能


##### 1.Scene
-- 原有
BaseScene:实现功能，能够自动处理基础生命周期，GRoot的创建与释放

##### 2.Window
与原有的UIDialog功能，需要适配原来的窗口管理器：DialogSystem 做衔接

原来的窗口管理器：（基本不用动） ----
1.刘海屏适配
2.红点系统
3.层级排序
4.窗口队列的维护
5.窗户拖动（FGUI 内部Window已经实现）

##### 基础组件（Button, Glist, 等）



#### 发现问题啊

###### 问题1：层级
原来的UI架构是这样的：
GameScene + GameLayerUI + 


  -- 控制UI
    self._controlSystem = lt.ControlSystem.new(self)
    self:addChild(self._controlSystem, GameLayerUI.GAME_LAYER_ZORDER.CONTROL)
    
    self._dialogSystem = lt.DialogSystem.new({gameLayer = self, x = display.cx, y = display.cy})  --窗口层
    self:addChild(self._dialogSystem, GameLayerUI.GAME_LAYER_ZORDER.DIALOG)

    -- 倒计时层
    self._nodeTime = display.newNode()
    self:addChild(self._nodeTime, GameLayerUI.GAME_LAYER_ZORDER.TIME)

而FGUI 所有节点都是通过GRoot 来创建的，GRoot 只能放在场景Scene 上
就需要处理层级关系

===========================解决方案：
（1）直接修改原来_dialogSystem的继承类为FGUI.GCompnent：
因为修改的东西较多;考虑第一种方案；发现一些没法绕过去的问题：没法同时

view = lt[layerName].new(param)
self:addChild(view) 
兼容老的Cocos和新的fgui

(2) 创建全新的FGUI 窗口管理系统


###### 问题2：窗口类有自己的管理方式在C++ 那边：就要考虑是否用窗口类了

包括打开，释放，等都是C++ 自动进行管理的,包括后面的遮挡



###### 问题3：窗口类

当与Cocos2dx 窗口交互时点击，没法判断点到谁，从而调整层级


#### 解决方案
local _view1 = fgui.UIPackage:createObject("Emoji", "Main")
self._groot:addChild(_view1)

local view2 = cc.Node:create()
self._groot:displayObject():addChild(view2)

view1 和 view2 的父节点一样吗，如何才能让view1 和view2 在同一个父节点下

```lua
--方案一：
local _view1 = fgui.UIPackage:createObject("Emoji", "Main")
self._groot:addChild(_view1)

local view2 = cc.Node:create()
self._groot:displayObject():addChild(view2)


---方案2：已实验有效果，并可以设置层级
local _view1 = fgui.UIPackage:createObject("Emoji", "Main")
local view2 = cc.Node:create()

local container = cc.Node:create()
container:addChild(_view1:displayObject())
container:addChild(view2)

self._groot:addChild(container)

```

### 采用方案2 ，在Window下有如下问题
-- 创建 Window1
local view3 = fgui.Window1.new() 

-- 创建容器 container
local container = cc.Node:create()
self._groot:displayObject():addChild(container)

-- 将 view3 添加到容器中
container:addChild(view3:displayObject())

问题：但是放入container后，window没有调用onShown了，好奇怪

解决：这个问题可能是由于 Window 的生命周期事件的触发机制造成的。

当你直接调用 window:show() 时, Window 会自动被添加到 GRoot 中,此时会触发 onShown 事件。

但是当你将 Window 添加到 container 中时, Window 并没有被直接添加到 GRoot 中,所以可能不会触发 onShown 事件。

要解决这个问题,你可以手动触发 onShown 事件。具体做法如下:
local container = cc.Node:create()
self._groot:displayObject():addChild(container)
container:addChild(view3:displayObject())
view3:onShown()


----不能用Window了哦，只能用界面去做；组件

### TODO 明天来处理倒计时层级
目前思路：一层套一层：GComponent:create()这样

问题：111：Window 放在别的Component 上设置层级不管用了，必须放在Groot上


--- 生成FGUI与Cocos公共父节点（用于Cocos界面与FGUI兼容） ---游戏主场景不能动
function GameScene:createCommonParent()
    --一级container (包裹layer 层)
    --二级container (包裹 gamelayer 内：倒计时，窗口系统)
    --三级container (包裹窗口，fgui, cocos 窗口)
    _GAME_GROOT = self._groot
    ---一级container
    local common = fgui.GComponent:create()
    layerChild:retain()
    self._groot:addChild(layerChild)
    _GAME_GROOT = layerChild:displayObject():getParent()
    containerDiglog = diglogChild:displayObject():getParent()


    -- --二级container
    -- local innerLayerChild = fgui.GComponent:create()
    -- innerLayerChild:setSize(display.width, display.height)
    -- innerLayerChild:retain()
    -- layerChild:addChild(innerLayerChild)
    -- containerInnerLayer = innerLayerChild:displayObject():getParent()

    -- --三级container 
    -- local diglogChild = fgui.GComponent:create()
    -- diglogChild:setSize(display.width, display.height)
    -- diglogChild:retain()
    -- innerLayerChild:addChild(diglogChild)
    -- containerDiglog = diglogChild:displayObject():getParent()
    -- containerDiglogFGui = innerLayerChild
end


问题：
通过传递参数，为什么会被释放
param.dialogSystem
而view.dialogSystem 不会

问题：吞噬触摸，cocos节点触摸优先级更高解决：可能要查C++ 那边代码了


### 处理
1.fgui 界面不禁用
2.在最上层的cocos view 不禁用
3.打开界面中没有FGUI（曾经没关闭过FGUI） 不禁用
4.其他都是禁用的

检测点：1.层级切换时(打开新的view),2.创建新的view 时,3.关闭时


      -- local originMaterial = node:getMaterial()
            -- local newMaterial = cc.Material:create()
            -- newMaterial:setTechnique(originMaterial:getTechnique())
            -- newMaterial:setTexture(originMaterial:getTexture())
            -- newMaterial:setUniformVec4("u_color", cc.v4(0.5, 0.5, 0.5, 0.5))
            print("cc.Button  setEnabled")
            node:setEnabled(enabled)
            -- node:setMaterial(newMaterial)

# 富文本
[color=#FF3300][b][活动时间][/b][/color]
[color=#FFFF00]每日14:00-14:30
[color=#FF3300]参与条件
[color=#FFFF00]等级达到50级
[color=#FF3300]活动入口

每日14:00-14:30<color=title 参与条件>等级达到50级<color=title 活动入口>"




Support UBB grammer：
[color=#FF3300][b]FairyGUI Editor[/b][/color] is a [i]WYS1WYG[/i][size=30] Game UI Editor[/size]，FairyGUI是一个所见即所得的[color=#FFFF00]游戏UI编辑器[/color]。

### 2024.6.20
1.removePackage 异常问题
2.富文本布局问题，控制器的使用

### 2024.6.21
需解决问题;
1.随着fgui制作的界面越来越多，fgui有自己的一套ui，那么cocos 原来也有一套UI
例如：技能，effect, 等，这些需要外部加载，作为FGUI\COCOS 公共资源
--尝试测试外部资源加载接口
--经过测试可以使用SetURL 可以加loadExternalcocos 的纹理资源图片
--再测试动画

2.富文本换行问题，遇到图片不会换行
解决：</br>

3. 富文本 空格问题：可能被忽略了；要看C++ 代码 :未解决

4.字体不生效问题：已解决，增加registerFont


3.富文本多个事件判断问题 :已解决<<a href='A事件'>>


-------------------------
## 2024 6 月第4周

###  2024.6.25
1.先用fgui做完活动界面-并完成替换旧的类型
2.搞个富文本组件类 
3.把其他window类型做完

### 2024.6.26-6.28 
1.GM - Net协议测试 开发
--建立proto-cmd 关联，
--支持新增协议测试模式
--与服务器联调
2.测试fairygui关联系统与应用

3.继续完善fgui 下的富文本组件开发，支持图片、文字等
4.活动界面完成替换为旧界面

## 2024 7 月第1周
计划：
-完成基础组件、
-查找公共使用次数较多的组件并开发


### 2024.7.1
1.完善其他模式的window（12种类型）
2.背包打开时，活动界面切换页签闪退问题   :已解决-》由于debug模式，调试在fgui 窗口打开的情况下，去卸载包并重新加载，必然出现问题



### 6月份考核内容填写
#工作内容：
  1.解决游戏中FGUI界面与cocos界面共存问题（层级、触摸交互）
  2.游戏中FGUI基础组件制作与开发（物品、窗口系统、富文本、页签）
  3.使用FGUI完成活动界面开发
  4.使用FGUI开发网络GM界面，整理proto与reqID 对应关系
  5.解决FGUI 相关释放异常问题

#自我小结：
  能够独立完成项目需求，能够积极与项目人员进行沟通交流学习；


  


### 7.3
1.问题记录：
removeChildrenToPool 
addItemFromPool
经常移除添加会使应用挂掉


2.emmylua插件 有问题 ，会在GList刷新，增删改 时闪退 :排查已解决，由于debug 模式下，反复对package包进行清理导致，ui界面还在，去删除包导致



3.todo
1.多个fgui界面交互，设置zorder的情况
2.新邮件问题，排序问题
3



### 7.4 
1.问题记录
GList 没法记录上次点击的是哪个，因为每次GList 都会重新刷新，上面的标记都会被清除

2.fgui界面交互

1fgui + 2cocos + 3fgui 当最上层3fgui 关闭时，层级切换失效


问题：
窗口带有特殊图案-像素拉长，空白区域导致无法触摸的问题

### 7.8 
1.再次排查cocos 界面与fgui 界面触摸交互问题
（即，不论cocos界面与fgui 界面的层级关系如何，总是cocos 界面触摸事件先响应）
之前：采用禁用cocos 界面触摸的方式
看看有没有更好的方式来处理

结论：
Cocos2D-X 和 FairyGUI 都有自己的事件处理机制,这两种机制在实现上存在一些差异:

**Cocos2D-X 的事件处理机制**:
   - Cocos2D-X 使用基于节点的事件处理机制。当用户与场景中的某个节点交互时(例如点击按钮),事件会从该节点开始向上冒泡,一直到根节点。
   - 事件在冒泡过程中,每个节点都有机会处理该事件。节点可以选择是否停止事件的进一步传播。
   - Cocos2D-X 的事件处理是基于优先级的。优先级高的节点会先收到事件,并有机会先行处理。
无法通过其他方案来规避该问题

### 7.9
（1）发现人物挂机时会卡住：-》查看寻路算法源码，看看是否有优化的地方





#### （2) 增加游戏性能工具，有利于查看开发界面的内存释放问题，及drawcall等调用



#### (3) fairygui 制作过程中如何减少draw call?
  TODO： 测试相关组件使用减少drawcall
 
 参考资料：https://zhuanlan.zhihu.com/p/50556095

#### 复合组件制作注意事项：
好的,我可以总结一下在制作复合组件时需要注意的一些事项:

1. 资源管理:
   - 尽量将复合组件内部使用的素材(图片、字体等)放在同一个纹理集或资源包中,以便于共享和复用。
   - 避免使用外部加载的资源,因为这会打断合批过程。
   - 合理管理资源的生命周期,避免频繁创建和销毁。

2. 渲染状态一致性:
   - 确保复合组件内部的所有 UI 元素使用相同的渲染状态(如混合模式、裁剪区域等)。
   - 状态一致有利于进行合批渲染,避免频繁切换状态。

3. 几何数据连续性:
   - 尽量保持复合组件内部 UI 元素的几何数据(顶点、纹理坐标等)连续。
   - 这样可以提高合批的效率,减少不必要的数据拷贝。

4. 层级结构优化:
   - 合理规划复合组件的层级结构,将使用相同材质的 UI 元素放在同一个层级上。
   - 这样可以确保渲染顺序的一致性,避免打断合批。

5. 组件复用:
   - 尽量将可复用的 UI 元素封装成独立的组件,方便在不同复合组件中进行复用。
   - 这样可以减少重复的开发工作,提高开发效率。

6. 性能监测和优化:
   - 在开发过程中,需要定期监测复合组件的渲染性能,关注 drawcall 数量、合批效率等指标。
   - 根据监测结果,及时进行优化调整,确保复合组件的渲染性能符合要求。

7. 文档和协作:
   - 为复合组件编写详细的使用文档,包括组件结构、资源依赖、使用方法等。
   - 在团队协作中,确保所有开发人员都能理解和正确使用复合组件。






 #### (4) 解决第一次进入地图卡住问题

 ~~#### (5) 空格支持~~:使用自定义字符


### fgui技术方案探讨

未加载物品装备:270
cocos:363  93个drawcall 5.4个/每个装备   ---优化后：357  87个 5.11个  --继续优化：334  64 3.7个
fgui: 328  58个drawcall 3.4个/每个装备                               --同等优化：302  32 1.88个
-----------------------------

未加载物品装备:270 -> 293    + 23
cocos:363  93个drawcall 5.4个/每个装备   ---优化后：357  87个 5.11个  --继续优化：334  64 3.7个
fgui: 328  58个drawcall 3.4个/每个装备                               --同等优化：302  32 1.88个


drawcall性能：
GLoader加载素材：
对于装备icon资源的使用性能、内存考虑：

1.cocos 纹理加载：
（1）本地单个资源加载：363
（2）将本地资源打成plist：363

2.fgui 加载loadFromPackage：
使用fgui - package :328
方法2存在共存资源问题 11.2 MB  会增加包体或热更大小

#### 对比老界面
17个装备：68个drawcall 4个/每个装备 
未加载装备：285 
加载完装备：353 



18.08
测试数据1plist
未加载：247
加载：333
86


测试数据2plist
未加载：269
加载：354
85

测试数据3plist
未加载：240
加载：325
85

5个drawcall
------------------------------------------------

删除btn

1:242 327 85
264  349 85

________________________________________________

非DEBUG:
186 328  =142
186 328

206 349 =143


174 316 =142 是否删除btn 并无变化
----------------------------------------------------

测试 不使用plist
174-316 142    34 / 17 =2 
174-282 108
235-360         7


--------------------
使用GLoader 加载：
320 253 67   === 3.9
320 253 67   ===3.9


### 优化物品
放在同一纹理集之中
304-236 =  68 / 17 = 4
313-245 = 68 /17 = 4

优化有些隐藏的物品
267-233=34/17 = 2
301-233 = 68/17 = 4

物品icon 的加载方式：
1.cocos加载资源：drawcall 为4
2.通过fgui package加载：drawcall 为2  ：但是资源会有2份，导致包体增大














