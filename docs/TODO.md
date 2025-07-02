7.16

1.做一个行为树 的demo，要求：怪物，人物 有战斗交互
且支持自动寻路（A*寻路）

2. 研究一下lua-test NavMeshTest


7.29 
Finish：
行为树demo 已基本完成；
可用行为树编辑器自定义行为树节点；
熟悉各个行为树节点用法（Sequence\Selector\Parallel|装饰器（Not)及行为节点) \黑板上下文的概念及用法\
支持多种寻路算法；（A Star\ GreedyBestFirstSearch\ BreathFirstSearch\Dijkstra\DepthFirstSearch 等）；并动态可画出运动路线图
写了一个四叉树碰撞检测demo（处理一下，元素处于交叉格子的情况）

ING:
研究了一下遗传算法（用于处理具有大量参数和复杂数学表示形式的问题。）
背包最优

TODO:
游戏支持localhost，即客户端可以自己发本地模拟协议数据，便于客户端可自己进行数据模拟；不必等服务器数据即可开发调试
最终成果：不依赖服务器也可加载游戏
计划将：
1.
->生成模拟数据
->writeByte (打包为二进制数据) 
->再调用原有解析函数进行解包：self._packetParser:processPacket(msgID,szBuff, size)、 readByte
->正常监听按原来接受模拟数据：lt.SocketApi:addProtoListener(lt.SocketApi._Event.Login_ACK, handler(self, self.onLoginGameAck), "ConnectManager:onLoginGameAck")

2.
->监听接收客户端数据并给予反馈

遇到了问题：
按照原来的流程，需要进行对协议进行加密解密；尤其是服务器数据的加密过程（能做到还原最好）
先简单使用lua-做加密解密，暂时不考虑像c++那样对包头包体进行二进制加密
self._packetParser:processPacket(msgID,szBuff, size) 这段之前的加密过程先不做，后续TODO

->先直接做这段
模拟这段
self._packetParser:processPacket(msgID,szBuff, size)
socketApi:dispatchProto(tostring(msgID), msg) 或者直接做这段  ;这个不太行，需要做层层数据解析

7.30 
1.继续做localServer功能
2.TODO:对比luajit ，了解luajit 内部优化技术
3.TODO:饥荒源码阅读


8.9 
LocalServer:搁置了

Finish：
完成了一些shader;
学习了opengl;
发现cocos 的很多opengl 接口支持很差;(可能需要研究如何自定义分配属性) TODO:算了放弃了
发现一个新的引擎threejs\orillusion, 前者支持的比较完善，后者还在研发中
学习了c-sharp 

8.12
开始继续做localServer:

已经把基本的解析框架写完了，但是还有一些问题，加密之后，解密不出数据


8.14:
本地服务器已经可以做接收发送，及加密解密相关功能  
GG 已经做了  
GS 解析了两个
需要解决的： 
GS 中 协议中含协议格式的发送及接收问题

TODO: 
1.SPine 动画修改某部位颜色
2.背包系统（2468）


8.23
背包系统初版已完成（模仿端游）

TODO:
SPine 动画修改某部位颜色






