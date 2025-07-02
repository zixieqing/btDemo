local tbl = {
    CLI_GG_Login_REQ  = 22,
    CLI_GG_Login_REQ2 = 23
}
print("tbl",tbl["CLI_GG_Login_REQ2"])


local function printArgs(...)
    local args = {...}  -- 将可变参数转换为表
    print("第一个参数:", args[1])
    print("参数数量:", #args)
end

printArgs("Hello", "World")

-- Lua 5.1 示例
print("第一个参数:", arg[1])
print("参数数量:", arg.n)
