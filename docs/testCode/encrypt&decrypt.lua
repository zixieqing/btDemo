---协议加密解密


-- local zlib = require("zlib")  -- 确保你有 zlib 库可用
local bit = require("testCode.bit32")     -- 确保你有 bit 库可用


local gnNetMsgHeaderSize = 7  -- 假设头部大小为 7 字节

-- 加密函数
local function YHEncode(data, base, seed)
    local encrypted = {}
    for i = 1, #data do
        local byte = data:byte(i)
        local encodedByte = bit.bxor(byte, base[(i - 1) % #base + 1] + seed)
        table.insert(encrypted, string.char(encodedByte))
    end
    return table.concat(encrypted)
end

-- 解密函数
local function YHDecode(data, base, seed)
    local decrypted = {}
    for i = 1, #data do
        local byte = data:byte(i)
        local decodedByte = bit.bxor(byte, base[(i - 1) % #base + 1] + seed)
        table.insert(decrypted, string.char(decodedByte))
    end
    return table.concat(decrypted)
end

-- 加密数据
local function encryptData(msgID, data, base, seed)
    local header = {
        wMsgID = msgID,
        wDataLen = #data,
        byChecksum = 0,
        byCompress = 0
    }

    -- 进行加密
    local encryptedData = YHEncode(data, base, seed)

    -- 计算校验和
    local checksum = 0
    for i = 1, #encryptedData do
        checksum = bit.bxor(checksum, encryptedData:byte(i))
    end
    header.byChecksum = checksum

    -- 创建最终数据包
    local packet = string.pack(">H", header.wMsgID) ..
                   string.pack(">H", header.wDataLen) ..
                   string.char(header.byChecksum) ..
                   encryptedData

    return packet
end

-- 解密数据
local function decryptData(packet, base, seed)
    local wMsgID = string.unpack(">H", packet, 1)
    local wDataLen = string.unpack(">H", packet, 3)
    local byChecksum = packet:byte(5)

    local encryptedData = packet:sub(7) -- 数据从第7字节开始

    -- 校验和检查
    local checksum = 0
    for i = 1, #encryptedData do
        checksum = bit.bxor(checksum, encryptedData:byte(i))
    end
    if checksum ~= byChecksum then
        return nil, "Checksum mismatch"
    end

    -- 解密数据
    local decryptedData = YHDecode(encryptedData, base, seed)

    return wMsgID, decryptedData
end

-- 示例用法
local msgID = 1
local data = "Hello, World!"
local base = {1, 2, 3}  -- 示例 base 数组
local seed = 42

-- 加密
local encryptedPacket = encryptData(msgID, data, base, seed)

-- 解密
local wMsgID, decryptedData, err = decryptData(encryptedPacket, base, seed)

if err then
    print(err)
else
    print("Original Data: ", data)
    print("Decrypted Data: ", decryptedData)
end
