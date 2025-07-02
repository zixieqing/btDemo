### 关于Lua Int64 的问题记录

```lua

最近用lua处理某些大整数的时候发现不对劲

print(string.format("%d", 186312419127226*59 + 49)) 


--[[
lua51:10992432728506384
lua54:10992432728506383
C++:10992432728506383

得到结论：
lua 5.1 只支持到 32bit 数 ，而且印象中是所有整数都通过浮点数操作。
lua 5.2或者5.3 之后才加的64位整数和浮点数
--]]

--func 2
local res = ffi.new("int64_t", 186312419127226*59 + 49); --10992432728506383
print(tostring(res))






```

```cocoslua

```

### 参考
https://groups.google.com/g/openresty/c/09eW8bVevHQ