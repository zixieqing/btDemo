## lua coroutine
### 创建并启动
```lua
--创建：将一个函数作为参数，如何传递？
local co = coroutine.create(function(param)
    print("this is coroutine",param)
end)

```

### 启动一个协程

```lua
coroutine.resume(co, "传入一个参数")
```

### 暂停一个协程
```lua
local co = coroutine.create(function(param)
    print("this is coroutine",param)
    for i = 1 ,3 do
        print("i",i)
        coroutine.yield("传出一个参数")
    end
end)
local status, resumeRet = coroutine.resume(co, "传入一个参数")

--重点：通信：yield和resume 可以建立互相参数传递

```

### 其他功能

#### coroutine.wrap()

创建 coroutine，返回一个函数，一旦你调用这个函数，就进入 coroutine，和 create 功能重复

--重点：用wrap 创建的协程，不需要像create那样用resume 来启动，直接调用函数就可以启动
其他都可以正常使用

--使用wrap创建协程无法拿到其协程，从而无法获取其运行状态

```lua
local co = coroutine.wrap(funciton()
    print("使用 coroutine wrap 创建了一个协程")
end)
co()

```

#### coroutine.status()
获取协程的运行状态：dead（运行结束），suspended（暂停），running（运行中）

#### coroutine.running()
返回正在跑的 coroutine，一个 coroutine 就是一个线程，当使用running的时候，就是返回一个 coroutine 的线程号
