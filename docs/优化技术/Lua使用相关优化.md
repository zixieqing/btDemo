# Lua 使用相关优化工作

## CPU
资源来源：https://zhuanlan.zhihu.com/p/29317103
#### 1.局部变量使用问题
- 不要在for 循环内、定时器内使用GetComponent方法，要用缓存

```lua
-- 模拟一个UI对象
local UIObject = {
    -- 模拟的组件
    components = {
        Button = { name = "SubmitButton" },
        Text = { name = "TitleText" }
    },

    -- 模拟的GetComponent方法
    function(self, componentType)
        -- 模拟耗时操作
        -- 实际中可能是查找或复杂逻辑
        print("调用GetComponent获取" .. componentType)
        return self.components[componentType]
    end
}

-- 不缓存组件，每次都调用GetComponent
function updateUIWithoutCache()
    for i = 1, 10 do -- 模拟每帧调用10次
        local button = UIObject:GetComponent("Button")
        -- 做一些操作
        print("操作按钮: " .. button.name)
    end
end

-- 缓存组件，避免重复调用GetComponent
function updateUIWithCache()
    -- 在循环外缓存一次
    local button = UIObject:GetComponent("Button")
    for i = 1, 10 do
        -- 直接使用缓存
        print("操作按钮: " .. button.name)
    end
end

print("不缓存的调用：")
updateUIWithoutCache()

print("\n缓存的调用：")
updateUIWithCache()


```


#### 2.复杂函数的记忆化处理
```lua
function memoize(f)
    local mem = {}
    setmetatable(mem, { __mode = "kv" })--同时对键和值都弱引用,帮助自动管理缓存，避免内存泄漏
    return function(x)
        local r = mem[x]
        if r == nil then
            r = f(x)
            mem[x] = r
        end
        return r
    end
end

--使用：
local slowFunction = function(x)
    -- 模拟耗时操作
    print("计算：" .. x)
    return x * x
end

local memoizedFunction = memoize(slowFunction)

print(memoizedFunction(4)) -- 第一次调用，计算
print(memoizedFunction(4)) -- 第二次调用，直接返回缓存


```
#### 3. 多次（频繁）创建的对象，合理利用对象池

** 什么时候用？ 尤其是使用对象池缓存一个经常复用的对象时，这样的优化更明显，比如说LuaVector3、GameObject、滚动列表中的对象。

- 避免重复创建LuaVector3对象：在设位置时，避免每次都新建对象，可以复用已有的对象。
- 使用对象池：为移动消息创建一个对象池，复用消息对象，减少频繁的内存分配和回收。

- 如果该对象有设置__newindex 属性，才会造成开销：每次赋值都可能触发__newindex，尤其是当这个属性之前不存在。
- 如果__newindex定义了逻辑（比如自动存储、监控、代理等），每次赋值都会调用这个逻辑，带来开销

```lua 
-- 定义移动消息对象池
local moveMsgPool = {}

local function getMoveMsg()
    local msg = table.remove(moveMsgPool)
    if not msg then
        msg = {}
    end
    return msg
end

local function returnMoveMsg(msg)
    -- 重置消息内容
    for k in pairs(msg) do
        msg[k] = nil
    end
    table.insert(moveMsgPool, msg)
end

-- 发送移动消息（复用对象）
local function sendMoveMessage(entityId, x, y, z)
    local msg = getMoveMsg()
    msg.entityId = entityId
    msg.position = { x = x, y = y, z = z }
    -- 模拟消息发送
    print("发送移动消息：实体ID", entityId, "位置", x, y, z)
    -- 使用完后返回池
    returnMoveMsg(msg)
end

-- 示例
for i=1, 10 do
    sendMoveMessage(i, i*1.0, i*2.0, i*3.0)
end


```

#### 4. 字符串拼接:使用table.concat

- 相关原理
Lua的字符串是内部复用的：当你创建一个字符串（比如字面量或调用字符串函数）时，
Lua会先检查它的“字符串池”中是否已经有相同内容的字符串，
如果有，就直接返回那个已有的字符串引用。这让字符串的比较（通过指针）变得非常快，也方便赋值（只需复制引用，不需要复制内容）。

- 优点：字符串比较变成指针比较，赋值只拷贝引用，非常高效
- 缺点：在拼接字符串时，Lua不能像某些语言那样直接把后者的buffer插入到前者的buffer末尾，而是必须：
遍历查找是否有相同的字符串（避免重复存储）
把整个后者的内容拷贝到新字符串中，进行拼接。
这就导致了拼接字符串的开销比直接拼接buffer的语言大很多。

```c
/* 这是Lua源码中的一部分，负责字符串的创建和查找 */

static TString *internstr(lua_State *L, const char *str, size_t l) {
    /* 省略部分代码 */
    TString *ts = luaS_newlstr(L, str, l);
    /* luaS_newlstr会先在字符串表中查找，存在则返回已有的字符串，否则创建新字符串 */
    return ts;
}

/* 伪代码，简化版 */
TString *luaS_newlstr(lua_State *L, const char *str, size_t l) {
    Table *stringtable = G(L)->strt;  /* 全局字符串表 */
    unsigned int h = luaS_hash(str, l, /* seed */);
    TString *ts = findstring(stringtable, str, l, h);
    if (ts != NULL) {
        /* 已存在，直接返回 */
        return ts;
    } else {
        /* 不存在，创建新字符串 */
        ts = luaS_newudata(L, l);
        memcpy(getstr(ts), str, l);
        ts->hash = h;
        /* 插入字符串池中 */
        insertstring(stringtable, ts);
        return ts;
    }
}


```

##### 4.1 关于字符串拼接 " .. " 

```lua 
--[[
    关于字符串拼接 " .. " 
]]
local str1 = "hello"
local str2 = "world"
local result = str1 .. str2

--[[
    原理过程如下：
调用拼接
   |
   v
查找池中是否已有"helloworld"（哈希查找）
   |                     \
  有                     没有
   |                      \
返回同一实例        创建新字符串（复制内容）
                         |
                   插入池中
                         |
                   返回新实例指针
]]

-- 那么这种 开销就很大
local test = "test"
for i = 1, 100 do 
    test = test .. i
end


```

##### 4.2 字符串table.concat 与 .. 对比
- ..
Lua的字符串拼接（..）：每次使用..拼接字符串，Lua会：
创建一个新字符串（拷贝两个字符串的内容）
这在多次拼接时，会产生大量的内存拷贝和临时字符串，导致性能瓶颈。

- table.contact
table.concat的做法：
先将所有需要拼接的字符串存入一个表（数组）
一次性计算所有字符串的总长度
在一块连续的buffer中预先分配空间
将每个字符串“直接拷贝”到这个buffer中
最后生成一个最终的拼接字符串

```lua 
-- ..每次都复制之前所有内容，重复多次内存分配和拷贝
local test = "test" 
for i = 1, 100 do 
    test = test .. i
end

-- table.concat 只一次性分配缓冲区，复制一次，效率高
local test2 = { "test" }
for i = 2, 101 do
    test2[i] = test .. (i - 1)
end
table.concat(test2)

```


### 相关知识补充
```lua 

--[[
合理使用rawset，获得性能提升
绕过元方法：rawset直接操作表本身，不会触发__newindex元方法。这样就避免了每次赋值时调用额外的函数，减少了函数调用的开销。
减少递归和逻辑开销：如果在__newindex中频繁调用rawset，可以避免递归调用__newindex，降低复杂度。

]]
rawset(t, "y", 20) -- 直接设置某个值

--[[
__index：
作用：当你访问一个表中不存在的键时，触发__index
用途：可以用来实现“继承”、属性代理、默认值等功能。
触发时机：对不存在的键进行读取操作（value = table[key]），如果key不存在，且设置了__index，就会调用__index

]]

local parent = { a = 10 }
local child = {}
setmetatable(child, {
    __index = parent  -- 当访问child不存在的键时，从parent中查找
})

print(child.a) -- 输出10（因为child没有a，从parent中找）
print(child.b) -- 输出nil（没有b，也没有__index指向的表中）


--[[
__newindex:
作用：当你给一个表中的不存在的键赋值时，触发__newindex
用途：可以用来实现只读属性、属性监控、自动存储、代理等
触发时机：对不存在的键进行写入操作（table[key] = value），如果key不存在，且设置了__newindex，就会调用__newindex
]]

local t = {}
setmetatable(t, {
    __newindex = function(table, key, value)
        print("设置 " .. key .. " = " .. tostring(value))
        rawset(table, key, value) -- 直接存值，避免再次触发__newindex
    end
})

t.x = 100 -- 触发__newindex
print(t.x) -- 输出100


```