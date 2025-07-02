#### luaide-lite 

vscode 插件 luaide-lite 可以断点调试，需手动增加以下步骤
缺点：
1.遇到大容量会卡 
2.文件转定义有的没解析完会无法转到定义处  
3.暂时可以考虑使用Luaide-lite: Core 设置为 legacy 解析库，避免解析不完成 ；
4.TODO后续考虑luahelper,emmylua
-- 1.launch.json配置
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Cocos-Launch333",
            "type": "lua",
            "request": "launch",
            "runtimeType": "Cocos2",
            "localRoot": "${workspaceRoot}",
            "mainFile": "${workspaceRoot}/src/main.lua",
            "commandLine": [
                "-workdir ${workspaceRoot}",
                "-file  src/main.lua"
            ],
            "port": 7003,
            "exePath": "D:/forkGit/client/tl-client/tlApp.exe",
            "printType": 3
        }
    ]
}
```

-- 2. 手动引用
```lua
--其中LuaDebug文件 https://github.com/wellshsu/luaide-lite/blob/master/test/cocos/src/LuaDebug.lua 自行下载copy 到main.lua 同级目录即可
require("LuaDebug")("localhost", 7003)