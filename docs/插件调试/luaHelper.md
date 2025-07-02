### launch.json 配置

```json
{
    // 使用 IntelliSense 了解相关属性。 
    // 悬停以查看现有属性的描述。
    // 欲了解更多信息，请访问: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "type": "LuaHelper-Debug",
            "request": "launch",
            "name": "LuaHelper-Attach",
            "description": "通用模式,通常调试项目请选择此模式",
            "cwd":"${workspaceRoot}",
            "luaFileExtension": ".lua",
            "connectionPort": 8818,
            "stopOnEntry": true,
            "useCHook": true,
            "autoPathMode": false,
            "distinguishSameNameFile":true,
            "logLevel": 0,
            "program":"${workspaceRoot}/tlApp.exe",
            "args": [
                "-workdir ${workspaceRoot}/src",
                "-file  src/main.lua"
            ],
        },
        {
            "type": "LuaHelper-Debug",
            "request": "launch",
            "name": "LuaHelper-DebugFile",
            "description": "独立文件调试模式",
            "luaPath": "",
            "packagePath": [],
            "luaFileExtension": "",
            "connectionPort": 8818,
            "stopOnEntry": true,
            "useCHook": true
        }
    ]
}

```

```json
// --主要需要自己手动添加以下自动即可拉起
"program":"${workspaceRoot}/tlApp.exe",
"args": [
    "-workdir ${workspaceRoot}/src",
    "-file  src/main.lua"
],

```

#### 插入代码及调试库
参考文档：https://github.com/Tencent/LuaHelper/blob/master/docs/manual/usedebug.md
ctrl+shift+p 
LuaHelper: Open Debug Foder，表示打开插件自带的关键目录（里面包含LuaPanda.lua和luasocket库）。
LuaHelper: Copy debug file to workspace, 表示把LuaPanda.lua文件拷贝到项目中指定的目录，需要手动指定目标目录。
LuaHelper: Copy Lua Socket Lib, 表示把luasocket网络库拷贝到项目中指定的目录，需要手动指定目标目录。
LuaHelper: Insert Debugger Code, 表示在lua代码指定的位置快捷插入，require("LuaPanda").start("127.0.0.1", 8818);

#### 坑点
##### 1.luahelper 调试拉起失败
终端要默认设置为powershell
如果cmd 会报这个：导致起不来
用vs code运行python代码时，报"此时不应有 &"

##### 2.断点调试只能从第一行开始
不知道什么原因，其他处的断点无效，只能放弃


