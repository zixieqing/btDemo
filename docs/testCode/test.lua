print("hello lua")
print(math.ceil(72/26))
-- local bit32 = require("testCode.bit32")
local bit64 = require("testCode.bit64_2")
-- local function bytes_to_int64(bytes)
--     if #bytes ~= 2 then
--         error("Input must be 2 bytes")
--     end
--     local value = (bytes[1] * 256) + bytes[2]

  
--     if bit.band(value, 0x8000) ~= 0 then
--         value = value - 0x10000
--         value = bit.bor(value, 0xFFFFFFFFFFFF0000) -- 使用 bit.bor() 进行
--     end

--     return value
-- end
-- local function bytes_to_int64(b1, b2)
--     local value = bit.lshift(b1, 8) | b2
--     if bit.band(value, 0x8000) ~= 0 then
--         value = bit.bor(value, 0xFFFFFFFFFFFF0000) -- 扩展符号位
--     end

--     return value
-- end

function bytes_to_int64(bytes)
    if #bytes ~= 2 then
        error("Input must be 2 bytes")
    end

    local value = 0
    for i = 1, 2 do
        value = (value << 8) + bytes[i]
    end

    -- 判断符号位并扩展符号
    if bit32.band(value, 0x8000) ~= 0 then
        value = bit32.bor(value, 0xFFFF0000)
    end
  
    return value
end



-- function bytes_to_int64(bytes)
--     if #bytes ~= 2 then
--         error("Input must be 2 bytes")
--     end

--     local value = (bytes[1] * 256) + bytes[2]

--     -- 判断符号位并扩展符号
--     if bit.band(value, 0x8000) ~= 0 then
--         value = bit.bor(bit.lshift(value, 48), 0xFFFF000000000000)
--     end

--     -- 将 16 位整数填充为 8 个字节
--     local int64_str = string.pack("i8", value)
--     local int64 = string.unpack("i8", int64_str)
--     return int64
-- end


-- function bytes_to_int64(bytes)
--     if #bytes ~= 2 then
--         error("Input must be 2 bytes")
--     end

--     local value = (bytes[1] * 256) + bytes[2]

--     -- 判断符号位并扩展符号
--     if bit.band(value, 0x8000) ~= 0 then
--         value = bit.bor(bit.arshift(value, 16), 0xFFFF0000)
--     end

--     -- 将 16 位整数填充为 8 个字节
--     local int64_str = string.pack("i8", value)
--     local int64 = string.unpack("i8", int64_str)
--     return int64
-- end


-- function bytes_to_int64(bytes)
--     if #bytes ~= 2 then
--         error("Input must be 2 bytes")
--     end

--     local value = (bytes[1] * 256) + bytes[2]

--     -- 判断符号位并扩展符号
--     if bit.band(value, 0x8000) ~= 0 then
--         value = value - 0x10000
--     end

--     -- 将 16 位整数转换为 64 位整数
--     local int64 = string.unpack("i8", string.pack("i2", value))
--     return int64
-- end


-- function bytes_to_int64(bytes)
--     if #bytes ~= 2 then
--         error("Input must be 2 bytes")
--     end

--     local value = (bytes[1] * 256) + bytes[2]

--     -- 判断符号位并扩展符号
--     if bit64.i64_band(value, 0x8000) ~= 0 then
--         value = value - 0x10000
--     end

--     -- 将 16 位整数转换为 64 位整数
--     local int64 = string.unpack("l", string.pack("h", value))
--     return int64
-- end




local byte1 = 0xF0
local byte2 = 0x34
local int64 = bytes_to_int64({byte1, byte2})
print(int64) -- 输出: -13260



-- local byte1 = 0x12
-- local byte1 = 0xF0
-- local byte2 = 0x34
-- local int64 = bytes_to_int64(byte1, byte2)
-- print(int64)


-------------------------------------------------------------
-- -- 打包有符号的2字节整数
-- local num = -12345
-- local bytes = string.pack("h", num)
-- print(#bytes) -- 输出: 2

-- -- 从字节序列中解包有符号的2字节整数
-- local unpacked_num = string.unpack("h", bytes)
-- print(unpacked_num) -- 输出: -12345
-- --------------------------------------------------------------

-- -- 打包 64 位无符号整数
-- local value = 18446744073709551615 -- 2^64 - 1
-- local packed_data = string.pack("L", value)
-- print("Packed data:", packed_data)

-- -- 解包 64 位无符号整数
-- local unpacked_value = string.unpack("L", packed_data)
-- print("Unpacked value:", unpacked_value)
