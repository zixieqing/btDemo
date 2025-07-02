local function useOfPackorUnpack()
    local packed = table.pack(1, 2, 3, "hello")
    print(packed.n)  -- 输出: 4
    print(packed[1]) -- 输出: 1
    print(packed[2]) -- 输出: 2

    local myTable = {1, 2, 3, "hello"}
    local a, b, c, d = table.unpack(myTable)
    print(a) -- 输出: 1
    print(b) -- 输出: 2
    print(c) -- 输出: 3
    print(d) -- 输出: hello
end
useOfPackorUnpack()