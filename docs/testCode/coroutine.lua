print("-----------------------------new example 0 -------------------------------------------------------------")
function foo()
    print("协同程序 foo 开始执行")
    local value = coroutine.yield("暂停 foo 的执行")
    print("协同程序 foo 恢复执行，传入的值为: " .. tostring(value))
    print("协同程序 foo 结束执行")
end

-- 创建协同程序
local co = coroutine.create(foo)

-- 启动协同程序
local status, result = coroutine.resume(co)
print(result) -- 输出: 暂停 foo 的执行

-- 恢复协同程序的执行，并传入一个值
status, result = coroutine.resume(co, 42)
print(result) -- 输出: 协同程序 foo 恢复执行，传入的值为: 42

-----------------------------new example -------------------------------------------------------------
print("-----------------------------new example1 -------------------------------------------------------------")
-- coroutine_test.lua 文件
-- 创建了一个新的协同程序对象 co，其中协同程序函数打印传入的参数 i
co = coroutine.create(function(i)
    print(i);
end)
-- 使用 coroutine.resume 启动协同程序 co 的执行，并传入参数 1。协同程序开始执行，打印输出为 1
coroutine.resume(co, 1) -- 1

-- 通过 coroutine.status 检查协同程序 co 的状态，输出为 dead，表示协同程序已经执行完毕
print(coroutine.status(co)) -- dead

print("----------")

-- 使用 coroutine.wrap 创建了一个协同程序包装器，将协同程序函数转换为一个可直接调用的函数对象
co = coroutine.wrap(function(i)
    print(i);
end)

co(1)

print("----------")
-- 创建了另一个协同程序对象 co2，其中的协同程序函数通过循环打印数字 1 到 10，在循环到 3 的时候输出当前协同程序的状态和正在运行的线程
co2 = coroutine.create(function()
    for i = 1, 10 do
        print(i)
        if i == 3 then
            print(coroutine.status(co2)) -- running
            print(coroutine.running()) -- thread:XXXXXX
        end
        coroutine.yield()
    end
end)

-- 连续调用 coroutine.resume 启动协同程序 co2 的执行
coroutine.resume(co2) -- 1
coroutine.resume(co2) -- 2
coroutine.resume(co2) -- 3

-- 通过 coroutine.status 检查协同程序 co2 的状态，输出为 suspended，表示协同程序暂停执行
print(coroutine.status(co2)) -- suspended
print(coroutine.running())

print("----------")

----------------------------new example -------------------------------------------------------------
print("-----------------------------new example2 -------------------------------------------------------------")

function foo(a)
    print("foo 函数输出", a)
    return coroutine.yield(2 * a) -- 返回  2*a 的值
end

co = coroutine.create(function(a, b)
    print("第一次协同程序执行输出", a, b) -- co-body 1 10
    local r = foo(a + 1)

    print("第二次协同程序执行输出", r)
    local r, s = coroutine.yield(a + b, a - b) -- a，b的值为第一次调用协同程序时传入

    print("第三次协同程序执行输出", r, s)
    return b, "结束协同程序" -- b的值为第二次调用协同程序时传入
end)

print("main", coroutine.resume(co, 1, 10)) -- true, 4
print("--分割线----")
print("main", coroutine.resume(co, "r")) -- true 11 -9
print("---分割线---")
print("main", coroutine.resume(co, "x", "y")) -- true 10 end
print("---分割线---")
print("main", coroutine.resume(co, "x", "y")) -- cannot resume dead coroutine
print("---分割线---")

print("-----------------------------new example lua5.4 -------------------------------------------------------------")

function foo(a)
    print("foo", a)
    return coroutine.yield(2 * a)
end

co = coroutine.create(function(a, b)
    print("co-body", a, b)
    local r = foo(a + 1)
    print("co-body", r)
    local r, s = coroutine.yield(a + b, a - b)
    print("co-body", r, s)
    return b, "end"
end)

print("main", coroutine.resume(co, 1, 10))
-- print("main", coroutine.resume(co, "r"))
-- print("main", coroutine.resume(co, "x", "y"))
-- print("main", coroutine.resume(co, "x", "y"))
print("==========================================my test=========================")
-- 创建：将一个函数作为参数，如何传递？
local co = coroutine.create(function(param)
    print("this is coroutine", param)
    for i = 1, 3 do
        print("i", i)
        local yieldRet = coroutine.yield("传回一个参数给resume", "i的值" .. i)
        print("yieldRet", yieldRet)
    end
end)
local status, result = coroutine.resume(co, "传入一个参数")
print(status, result)
-- local status, result1, result2 = coroutine.resume(co, "传入一个参数1")
-- print("resume Ret", status, result1, result2)

local co2 = coroutine.wrap(function(param)
    print("使用 coroutine wrap 创建了一个协程",param)
end)
co2("传了一个参数")

print("co的状态：",coroutine.status(co))
print("正在跑的协程",coroutine.running())


print('===================================this is coroutine timer')

-- --dummy global variables
-- local i = 0
-- local j = 0

-- co_on_timer = coroutine.create(function()

--     local k = 0
--     while true do
--         --do something
--         print(k, ' Second: ', i, j)
--         coroutine.yield() --waiting for being activated.
--         k = k + 1
--     end

-- end)

-- coroutine.resume(co_on_timer)

-- -- init timer                                                                                                                                                   
-- local timetable = os.date("*t");
-- local lasttime = os.time(timetable)

-- while true do

--     -- dummy, do something
--     i = i + 1
--     j = j + 2

--     timetable = os.date("*t");
--     local nowtime = os.time(timetable)

--     local difft = os.difftime(nowtime, lasttime);
    
--     if difft > 1.0 then --1 second timer arrived

--         coroutine.resume(co_on_timer) --activate the timer
--         lasttime = nowtime            --next timer

--     end
-- end
--------------
--test status 
local test = coroutine.create(function()
    print("1")
    coroutine.yield()
    print("2")
end)
local status = coroutine.resume(test)
local status1 = coroutine.resume(test)
local status2 = coroutine.resume(test)
print("1111",status,status1,status2)
-------------------


print("=============for=======================")

-- local function getTime()
--     local timetable = os.date("*t");
--     return os.time(timetable)
-- end
-- local tbl = {"a", "b", "c"}
-- local pairsCo = coroutine.create(function()
--     for k, v in pairs(tbl) do
--         print(k,v)
--         coroutine.yield(getTime(),"running")
--     end
--     coroutine.yield(getTime(),"success")
-- end)

-- local _, yieldTime, status= coroutine.resume(pairsCo) -- 上次的暂停时间
-- while true do 
--     local curTime = getTime() --当前时间
--     if os.difftime(curTime, yieldTime) > 1 then
--         _, yieldTime, status = coroutine.resume(pairsCo)
--     end
--     if status == "success" then
--         break
--     end
-- end


local function delayResponse(func)
    local function getTime()
        local timetable = os.date("*t");
        return os.time(timetable)
    end
    local response = coroutine.create(function()
        print("connect success")
        coroutine.yield(getTime())
        if func then
            func()
        end  
    end)

    local _, yieldTime, status= coroutine.resume(response) -- 上次的暂停时间
    while yieldTime do 
        local curTime = getTime() --当前时间
        if os.difftime(curTime, yieldTime) > 5 then
            _, yieldTime = coroutine.resume(response)
        end
    end
end

delayResponse(function()
    print("delay run")
end)