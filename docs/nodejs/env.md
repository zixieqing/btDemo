## 环境的坑

```shell
node:internal/modules/cjs/loader:1148
  throw err;
  ^

Error: Cannot find module 'D:\installApp\nodejs\node_modules\npm\node_modules\npm\bin\npm-cli.js '
    at Module._resolveFilename (node:internal/modules/cjs/loader:1145:15)
    at Module._load (node:internal/modules/cjs/loader:986:27)
    at Function.executeUserEntryPoint [as runMain] (node:internal/modules/run_main:174:12)
    at node:internal/main/run_main_module:28:49 {
  code: 'MODULE_NOT_FOUND',
  requireStack: []
}
```
删除C:\Users\user\npmrc即可