--[[
    结果同步：
    【概念】
    客户端在本地执行操作,并保存操作结果。
    客户端将操作指令发送到服务器。
    服务器接收客户端的操作指令,并执行相应的逻辑,得到最终的游戏状态。
    服务器将最终状态广播给所有客户端。
    客户端接收到服务器广播的状态后,将其与本地保存的结果进行对比和校正
    【应用场景】回合制卡牌
    结果同步往往比较简单，位置即使全部错乱或者延迟很久都没有关系，因为游戏过程完全不在乎位置，【只在乎最后的结果】，
    比如《梦幻西游》这样的“回合制 RPG” 游戏，屏幕上的人走到哪里确实无所谓，所有操作都是要点击或者选择菜单来下命令，象这样的游戏背后其实是文字游戏，只是加了一个图形的壳。
    游戏表面上看起来是动作/RTS 游戏，但是没有玩家直接协作和对抗，都是单机游戏，并不需要同步什么东西，服务端只要监测下结果离谱即可，延迟检测都没关系。
    基本是 PVE，而且无协作。即使是 PVP也就是打一下别人的离线数据，和无同步回合制游戏并无本质上的区别。
--]]


-- 服务端代码
local game_state = {}
local current_tick = 0

function server_update()
    -- 处理客户端发送的操作指令
    for client_id, actions in pairs(receive_client_actions()) do
        apply_actions(game_state, actions)
    end

    -- 更新游戏状态
    update_game_state(game_state)
    current_tick = current_tick + 1

    -- 广播最新的游戏状态
    broadcast_game_state(current_tick, game_state)
end

function apply_actions(state, actions)
    -- 根据操作指令更新游戏状态
    -- ...
end

function update_game_state(state)
    -- 根据游戏逻辑更新状态
    -- ...
end

function broadcast_game_state(tick, state)
    -- 将当前游戏状态广播给所有客户端
    for client_id, _ in pairs(connected_clients) do
        send_state_to_client(client_id, tick, state)
    end
end

-- 客户端代码
local local_state = {}
local local_tick = 0
local action_history = {}

function game_update()
    -- 检查是否有新的游戏状态
    local new_state = receive_state_from_server()
    if new_state then
        local new_tick = new_state.tick
        local new_state_data = new_state.state

        -- 将服务器状态与本地状态进行校正
        local_tick = new_tick
        local_state = new_state_data

        -- 执行游戏逻辑
        update_game_logic(local_state)
    end

    -- 将本地操作发送给服务器
    if should_send_actions() then
        send_actions_to_server(action_history)
    end
end

function should_send_actions()
    -- 判断是否需要向服务器发送当前的操作
    -- 可以根据时间间隔或操作数量来决定
    return true
end

function send_actions_to_server(actions)
    -- 将本地操作发送给服务器
    send_to_server(actions)
end

function update_game_logic(state)
    -- 根据游戏状态更新游戏逻辑
    -- ...

    -- 记录本地操作
    table.insert(action_history, latest_action)
end
