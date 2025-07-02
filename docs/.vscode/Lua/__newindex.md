# __newindex

在 Lua 中，`__newindex` 是一个元方法（metatable method），用于处理对表中不存在的索引进行赋值时的行为。它允许你定义自定义的行为，当你尝试向一个表中添加一个新键时。

### 示例

以下是一个使用 `__newindex` 的简单示例：

```lua
-- 创建一个表
local myTable = {}

-- 设置元表
setmetatable(myTable, {
    __newindex = function(table, key, value)
        print("尝试添加新键: " .. key .. "，值: " .. value)
        rawset(table, key, value.."我自定义了新值")  -- 使用 rawset 来实际设置值
    end
})

-- 尝试添加一个新键
myTable.newKey = "Hello, Lua!"  -- 输出: 尝试添加新键: newKey，值: Hello, Lua!

-- 检查新键的值
print(myTable.newKey)  -- 输出: Hello, Lua!我自定义了新值
```

### 注意事项

- `__newindex` 只在尝试设置不存在的键时触发。如果键已经存在，则直接赋值，不会调用这个元方法。
- 使用 `rawset` 是为了避免递归调用 `__newindex`，因为直接使用 `table[key] = value` 会再次触发 `__newindex`。

这个特性在实现封装、数据验证或者其他自定义逻辑时非常有用。

# 那么新增一个值时，先查找__index 还是__newindex呢?
在 Lua 中，当你对一个表进行索引操作时，顺序是先查找 `__index`，然后再查找 `__newindex`。

### 具体顺序

1. **查找值**：
   - 当你尝试访问一个表的某个键（例如 `table[key]`）时，Lua 首先检查该表是否存在这个键。
   - 如果不存在，Lua 会查找元表中的 `__index` 元方法（如果设置了元表）。
   - 如果 `__index` 方法返回 `nil`，则会返回 `nil`。

2. **新增值**：
   - 当你尝试向一个表中添加一个新键（例如 `table[key] = value`）时，Lua 会先检查元表中的 `__newindex`。
   - 如果该键在表中不存在，则会调用 `__newindex`，允许你定义自定义的行为。

### 总结

- **查找值时**：先查 `__index`。
- **新增值时**：先查 `__newindex`。

这种机制使得你可以在访问和修改表时实现灵活的行为。




