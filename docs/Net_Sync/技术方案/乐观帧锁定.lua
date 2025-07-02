--[[乐观帧锁定

针对传统严格帧锁定算法中网速慢会卡到网速快的问题，实践中线上动作游戏通常用“定时不等待”的乐观方式再每次Interval时钟发生时固定将操作广播给所有用户，不依赖具体每个玩家是否有操作更新：



1. 单个用户当前键盘上下左右攻击跳跃是否按下用一个32位整数描述，服务端描述一局游戏中最多8玩家的键盘操作为：int player_keyboards[8];

2. 服务端每秒钟20-50次向所有客户端发送更新消息（包含所有客户端的操作和递增的帧号）：

update=（FrameID，player_keyboards）

3. 客户端就像播放游戏录像一样不停的播放这些包含每帧所有玩家操作的 update消息。

4. 客户端如果没有update数据了，就必须等待，直到有新的数据到来。

5. 客户端如果一下子收到很多连续的update，则快进播放。

6. 客户端只有按键按下或者放开，就会发送消息给服务端（而不是到每帧开始才采集键盘），消息只包含一个整数。服务端收到以后，改写player_keyboards

————-

虽然网速慢的玩家网络一卡，可能就被网速快的玩家给秒了（其他游戏也差不多）。但是网速慢的玩家不会卡到快的玩家，只会感觉自己操作延迟而已。另一个侧面来说，土豪的网宿一般比较快，我们要照顾。

随机数需要服务端提前将种子发给各个客户端，各个客户端算逻辑时用该种子生成随机数，
另外该例子以键盘操作为例，实际可以以更高级的操作为例，比如“正走向A点”，“正在攻击”等。该方法目前也成功的被应用到了若干实时动作游戏中。
--]]

-- 服务端代码
local MAX_PLAYERS = 8
local player_keyboards = {}
local current_frame_id = 0

function server_update()
    -- 每帧更新玩家输入
    for i = 1, MAX_PLAYERS do
        if player_keyboards[i] then
            -- 更新玩家输入
            update_player_input(i, player_keyboards[i])
        end
    end

    -- 生成帧更新消息并广播
    current_frame_id = current_frame_id + 1
    local update_msg = {current_frame_id, player_keyboards}
    broadcast_update(update_msg)
end

function receive_input_from_client(player_id, keyboard_state)
    player_keyboards[player_id] = keyboard_state
end

function broadcast_update(update_msg)
    -- 将帧更新消息广播给所有客户端
    for i = 1, MAX_PLAYERS do
        send_update_to_client(i, update_msg)
    end
end

-- 客户端代码
local current_frame_id = 0
local player_inputs = {}

function game_update()
    -- 检查是否有新的帧更新消息
    local update_msg = receive_update_from_server()
    if update_msg then
        local frame_id, player_keyboards = unpack(update_msg)

        -- 如果收到的帧号大于当前帧号,快进播放
        if frame_id > current_frame_id then
            current_frame_id = frame_id
            player_inputs = player_keyboards
            fast_forward_game_state(player_inputs)
        end
    else
        -- 如果没有新数据,等待
        return
    end

    -- 更新游戏状态
    update_game_state(player_inputs)
end

function send_input_to_server(keyboard_state)
    -- 将玩家输入发送给服务端
    send_to_server(keyboard_state)
end

function fast_forward_game_state(player_inputs)
    -- 根据收到的所有玩家输入快进游戏状态
    -- ...
end

function update_game_state(player_inputs)
    -- 根据当前帧的所有玩家输入更新游戏状态
    -- ...
end
