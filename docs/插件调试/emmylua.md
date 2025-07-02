

#### launch.json配置

创建选择 EmmyLua Launch Debug选项
```json

{
    // 使用 IntelliSense 了解相关属性。 
    // 悬停以查看现有属性的描述。
    // 欲了解更多信息，请访问: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "type": "emmylua_launch",
            "request": "launch",
            "name": "启动并附加程序",
            "program": "D:/forkGit/client/tl-client/tlApp.exe",
            "workingDir": "D:/forkGit/client/tl-client/",
            "arguments": [
                "-workdir ${workspaceRoot}/src",
                "-file  src/main.lua"
            ],
            "newWindow": false
        }
    ]
}
```

#### 调试器代码插入
插入调试代码时：选择x86
ctrl + shift + p 选择insert代码，即可自动插入下面代码

```lua
package.cpath = package.cpath .. ";c:/Users/user/.vscode/extensions/tangzx.emmylua-0.7.4-win32-x64/debugger/emmy/windows/x86/?.dll"
local dbg = require("emmy_core")
dbg.tcpListen("localhost", 9966)

```

#### 全局变量爆红问题
参考：https://github.com/EmmyLua/VSCode-EmmyLua/blob/master/CHANGELOG_EN.md#0612
在工作目录，创建.emmyrc.json 配置字段："disable": ["undefined-global"],即可解决
```json
{
  "completion": {
      "autoRequire": true,
      "autoRequireFunction": "require",
      "autoRequireNamingConvention": "snakeCase",
      "callSnippet": false,
      "postfix": "@"
  },
  "diagnostics": {
      "disable": [
          "undefined-global","need-import"
      ],
      "globals": [
      ],
      "globalRegex": [
      ],
      "severity": {
      }
  },
  "hint": {
      "paramHint": true,
      "indexHint": true,
      "localHint": false,
      "overrideHint": true
  },
  "runtime": {
      "version": "Lua5.4",
      "requireLikeFunction": [],
      "frameworkVersions": []
  },
  "workspace": {
      "ignoreDir": ["src/cocos", "win32/src/cocos", "win32/src/lib"],
      "library": [],
      "workspaceRoots": [
      ],
      "preloadFileSize": 12048000
  },
  "resource": {
      "paths": [
      ]
  },
  "codeLens":{
      "enable": false
  }
}
```
最终测试可以正常拉起断点
