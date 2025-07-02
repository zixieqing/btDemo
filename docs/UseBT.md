# Use BT

可以勾选行为树节点，是否调试，增加当前行为树节点的运行debug 信息,
或在代码中控制
代码全部打开：
```lua
--behavior_node.lua
if true or self.data.debug then
    debugger(self, env, ret)
end
```

# 如何维护BT树的
```lua
--behavior_tree.lua
if env:get_inner_var(self, "YIELD") == nil then
    env:push_stack(self)
end

if ret ~= bret.RUNNING then
    for i, var_name in ipairs(self.data.output or {}) do
        env:set_var(var_name, vars[i + 1])
    end
    env:set_inner_var(self, "YIELD", nil)
    env:pop_stack()
elseif env:get_inner_var(self, "YIELD") == nil then
    env:set_inner_var(self, "YIELD", true)
end

--[[
也就是说，
首先判断当前节点YIELD里面是否存储的有值(换言之，就是是否正在挂起中)
没有值，就插入到stack 中，
有值，说明正在RUNNING


就插入队列，不在RUNNING则从队列中取出

--]]

```