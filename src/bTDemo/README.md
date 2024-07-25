## 制作过程中的记录

### tiledMap制作
分清楚 图层、图块、对象
图块：放资源的（可以是一整个大图，也可以是一小块图）
图层：制作地图，使用图块中小块进行刷地图，可多个图层进行区分阻挡、和地面
对象：用来给程序代码提供数据属性的，可以动态做一些事情


```lua
---@return cc.size 地图的宽度和高度（以瓦片为单位）30x20 
function MapNode:getMapSize()
    return self.tileMap:getMapSize()
end
---@return cc.Size 每个瓦片的尺寸
function MapNode:getTiledSize()
   return self.tileMap:getTileSize()
end
--如果一个瓦片地图的尺寸为 20 x 15 个瓦片,那么 tiledMap:getMapSize() 返回的 cc.Size 对象将会是:{width = 20, height = 15}
self.mapNode:getMapSize().width * self.mapNode:getTiledSize().width --才是地图总宽度
--
```

### A* 寻路数据存储问题
1.存储came_from 下一个点-当前点映射关系时 发现table 作为key 值不唯一性，出现多个相同的key
2.进行改良-将key 存储为'x-y'string 的方式
3.进而发现'x-y'无法进行有序存储，存进去的路径，变成了乱序（按照数字进行排序了） 
4.考虑使用第三方orderMap lune,进行有序，且支持映射关系的存储

### 构建行为树
参考：https://github.com/zhandouxiaojiji/behavior3lua.git
1.Player: 
（1） 找食物（当HP< 50）
（2） 找怪 （HP > 80）
（3） 攻击
（4） 移动，进行寻路
（4） 撤退回家（自己血量低于30%，且敌人血量大于自己）
2.怪物AI:

### 行为树与常见的if elseif
如果使用 if-elseif 结构来实现上述游戏角色行为树的逻辑,与使用行为树的方式会有以下几点区别:

1. 结构清晰度:
   - 行为树的结构更加清晰和直观,可以更好地表达角色的决策流程和行为逻辑。
   - if-elseif 结构虽然也可以实现相同的逻辑,但会使代码看起来更加线性和扁平,不太容易理解角色的整体行为模式。

2. 可扩展性:
   - 行为树的结构更加模块化和可扩展,可以方便地添加新的行为节点或修改现有的节点,而无需重构整个逻辑。
   - if-elseif 结构在添加新的条件判断或行为时,可能需要修改大量现有的代码,扩展性较差。

3. 可视化和调试:
   - 行为树可以直观地呈现角色的行为逻辑,方便开发人员理解和调试。
   - if-elseif 结构的逻辑较为隐藏,不易于可视化和调试。

4. 并行处理:
   - 行为树可以支持并行执行多个行为,更加灵活和高效。
   - if-elseif 结构通常只能顺序执行,无法并行处理多个行为。

总的来说,使用行为树的方式可以让游戏角色的行为逻辑更加清晰、可扩展和可调试,从而更好地实现非常完美的游戏角色行为。相比之下,if-elseif 结构虽然也可以实现相同的功能,但在结构清晰度、可扩展性和并行处理等方面会相对弱一些。

### 编辑器自定义节点
通过export_node.lua 脚本来遍历process 来获取，从而生成节点配置

```lua
-- 生成节点配置：node-config.b3-setting
lua54 export_node.lua 
```

### 行为树目录相关介绍
|-- adaptLua51.lua
|-- behavior3 行为树基础组成
|   |-- behavior_event.lua
|   |-- behavior_node.lua
|   |-- behavior_ret.lua
|   |-- behavior_tree.lua
|   |-- nodes  行为树基础节点
|-- export_node.lua  用于导出节点脚本，最终导出workspace/node-config.b3-setting 提供给editor 使用
|-- json.lua 
|-- myGame 自己游戏自定义节点
|   |-- actions
|   |   |-- attack.lua
|   |   |-- dead_handle.lua
|   |   |-- get_hp.lua
|   |   |-- idle.lua
|   |   |-- move_to_pos.lua
|   |   `-- move_to_target.lua
|   `-- conditions
|       |-- find_enemy.lua
|       `-- is_dead.lua
|-- process.lua 节点表
`-- workspace 提供给editor 使用, 
    `-- node-config.b3-setting
最终使用editor 来打开behavior3lua 整个目录


### 该行为树缺点
-- 打断机制过去粗暴
我指的打断就是A在跑动的过程中被B的技能打断了当前的状态。
清除RUNNING状态不行，因为受击后还会有类似后摇的状态。
如果全部恢复初始状态，那在A跑动的之前所找到的跑动目标和路径之类的就要全部重新算一遍了。这种办法比较粗暴，如果碰到类似受到一个buff状态，导致A每三秒掉血并产生受击状态。来回的路径计算就有点不太好了。
-- 编辑器无法对已经生成树就行交换，移动编辑

### 难点
