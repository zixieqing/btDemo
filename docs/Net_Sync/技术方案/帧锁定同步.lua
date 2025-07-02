
--[[
    帧锁定同步:
    【概念】：这个算法的关键在于要等待所有玩家都完成某个步骤,才能进入下一个步骤

    【适用游戏】：格斗游戏，RTS和足球（FIFA类）、篮球（NBA）等体育和动作游戏大量使用
    
    【缺点】：网速慢的玩家会卡到网速快的玩家，老游戏：经常一个角色断网，所有人就在那里等待

    【为什么会出现这样的问题】：如果网速慢的玩家在这一步迟迟没有将控制数据发送给服务器,那么服务器就无法计算出下一个关键帧的更新数据,其他玩家也会被卡住。

    【后续优化】：乐观帧锁定，

]]

-- 客户端代码
local currentFrame = 0
local currentKeyFrame = 1
local keyFrameData = {}
local inputData = {}

function game_update()
    currentFrame = currentFrame + 1

    -- 检查是否是关键帧
    if currentFrame % 5 == 0 then
        currentKeyFrame = currentKeyFrame + 1

        -- 如果没有收到服务器的更新数据, 等待
        if not keyFrameData[currentKeyFrame] then
            return
        end

        -- 从服务器更新数据中获取输入数据
        inputData = keyFrameData[currentKeyFrame].inputData

        -- 采集当前输入并发送给服务器
        local ctrlData = collect_input()
        send_to_server({ currentKeyFrame, ctrlData })
    end

    -- 使用输入数据进行游戏逻辑
    update_game_state(inputData)
end






-- 服务器代码
local clientCtrlData = {}
local currentKeyFrame = 1
local nextKeyFrame = 2

function server_update()
    -- 收集所有客户端本关键帧的输入数据
    for i, ctrlData in ipairs(clientCtrlData) do
        local keyFrameNum, inputData = unpack(ctrlData)
        if keyFrameNum == currentKeyFrame then
            clientCtrlData[i] = nil
            table.insert(keyFrameData, { keyFrameNum, inputData })
        end
    end

    -- 计算下一个关键帧的数据 ===========================》 卡住
    local updateData = calculate_update(keyFrameData)
    broadcast_to_clients(updateData)

    currentKeyFrame = nextKeyFrame
    nextKeyFrame = nextKeyFrame + 1
end

function receive_from_client(ctrlData)
    table.insert(clientCtrlData, ctrlData)
end

-- 辅助函数
function collect_input()
    -- 采集当前的输入数据
    return { mouse_x, mouse_y, key_pressed }
end

function update_game_state(inputData)
    -- 使用从服务器获取的输入数据更新游戏状态
    -- ...
end

function calculate_update(keyFrameData)
    -- 根据关键帧数据计算下一个关键帧的更新内容
    -- ...
    return updateData
end

function broadcast_to_clients(updateData)
    -- 将更新数据广播给所有客户端
    -- ...
end
