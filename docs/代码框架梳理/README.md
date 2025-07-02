# 项目相关的记录
## 1. 项目地址目录
访问地址：http://192.168.6.73/
|-- client   客户端主要项目    http://192.168.6.73/tianzhilianyu/client-player.git
|-- client-player  资源仓库，及一些其他依赖库   http://192.168.6.73/tianzhilianyu/client-player.git
`-- protocol   协议   http://192.168.6.73/tianzhilianyu/client.git

## 2.相关调试前置环境
参考 ：环境.md

## 3.基本目录结构
client\tl-client\ 客户端相关代码
UserDefault.xml 
|-- README.md 
|-- UserDefault.xml 记录账号缓存信息
|-- client-developer
|-- dev 控制是否为内网开发
|-- download 为热更新缓存资源与代码
|-- game.plist  
|-- mac  mac 端
|-- make_bilpk.bat 打包加密脚本
|-- make_bilpk.sh
|-- make_edocpk.bat
|-- make_edocpk.sh
|-- mk_playerRes.bat 链接client-player资源目录脚本
|-- res       启动器代码资源与加密代码  （bil.pk, edoc.pk    这两个文件为加密代码，运行会优先加载这两个文件中的代码，如果需要调试需删除（或者屏蔽reloadLauncher方法），才能调试启动器代码）
|-- res_map.txt  本地md5文件
|-- src          启动器源代码
|-- tlApp.exe    win32启动程序
|-- version.txt  启动器版本号文件
`-- win32        游戏代码目录


win32 游戏相关  功能基本同上
|-- README.md
|-- ServerList.lua 控制添加区服列表文件
|-- UserDefault.xml
|-- dev
|-- developer
|-- download
|-- env
|-- game.plist
|-- make_bil2pk.bat
|-- make_bil2pk.sh
|-- make_emagpk.bat
|-- make_emagpk.sh
|-- mk_playerWin32Res.bat
|-- res
|-- res_map.txt 
|-- src
|-- tlApp.exe
`-- version.txt

## 4.常用信息记录
--1.快捷切换开发模式（外网 | 内网）
增加 命名为ignoreupdate 的空白文件 可以忽略更新
增加 命名为 dev 进入内网开发模式

--2.调试开发环境而非产品环境
通过zip加载的没法调试源码
加密 cc.LuaLoadChunksFromZIP 会解压并加载数据到内存中，在package.preload中可以查看到
|-- edoc.pk 启动器代码加密二进制zip  reloadLauncher
|-- protobuf.pk 协议加密
|-- bil2.pk, emag.pk 游戏加密  reloadGameCode

--3.GM 命令记录
邮件：
@email sysnotice 1716274093000020860 test2 invalid3
@email simpleattachment test2 event [370001 2]


| 邮件类型 | GM指令 |
| 不带附件的邮件 | @email sysnotice playerid title event |
| 带简单附件的邮件 | @email simpleattachment title event [itemType itemidx num bind] |
| 带正常附件的邮件 | @email sysnotice|attachment playerid title event [itemname, dura] |


简单附件：@email simpleattachment testtitle testcontent 1 10043 1 0

正常附件：
@email attachment 1719994962000067836 testtitle testcontentra 老旧书页 1



@email sysnotice 1720074531000074324 aaa test

@email attachment 1720074531000074324 ycf1 111 老旧书页 1

## 5.代码梳理
参考：代码梳理









