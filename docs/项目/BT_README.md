## 行为树Demo项目
### 项目概述
计划使用cocos2dx做一个简易行为树demo;涉及A*寻路算法、行为树相关（构建行为树，行为树编辑器）、地图编辑器（tiledMap）使用

### 项目基础知识积累
#### tiledMap
分清楚 图层、图块、对象
图块：放资源的（可以是一整个大图，也可以是一小块图）
图层：制作地图，使用图块中小块进行刷地图，可多个图层进行区分阻挡、和地面
对象：用来给程序代码提供数据属性的，可以动态做一些事情

### 项目记录(按开发时间前后)
#### 1.tiledMap
（1）刷阻挡点，和阻挡点相关判断
（2）tiledMap 网格坐标与cocos坐标
（3）tiledMap getMapSize API 地图的宽度和高度（以瓦片为单位）30x20 

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
#### 2.A*寻路
（1）lua数据存储问题优化：
A.came_from（路径表），cost(代价表)，存储是以node节点（一个网格坐标为映射关系的），lua-table作为table的key不具有唯一性，进行类型转换
B.came_from 需要有序且连续，增加lua有序表（OrderTable保证有序性）

 （2）走路的平滑问题：

​	came_from计算出来是网格之间的坐标，直接移动，会很突兀；

​	（3）移动在行为树中，是一段过程，处于Running过程，需要考虑寻路的**路径缓存**

 **（4）寻路过程中，怪物作为终点值，会动态变化。这就涉及到A*寻路的性能优化了**

如果每次寻路都重新计算路径，会影响性能。



