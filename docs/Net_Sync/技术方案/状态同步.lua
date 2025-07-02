--[[
    状态同步：@Deprecated 被废弃
    【概念】状态同步法(State Synchronization)是较早期网络游戏中使用的一种同步技术,它的基本思路是:
    客户端定期将自己的游戏状态发送给服务器。
    服务器收集所有客户端的状态,计算出最终状态。
    服务器将最终状态广播给所有客户端。
    客户端根据服务器下发的状态更新自己的游戏状态。

    【缺点】：
    网络延迟导致的同步滞后问题。玩家操作到状态更新会有一定延迟,影响游戏体验。
    服务器压力大。服务器需要收集所有客户端状态并计算最终状态,随着玩家增多压力会非常大。
    需要客户端和服务端完全同步。任何状态差异都会导致游戏出错
--]]

-- 服务端代码
local game_state = {}
local current_tick = 0

function server_update()
    -- 更新游戏状态
    update_game_state(game_state)
    current_tick = current_tick + 1

    -- 收集所有客户端的状态
    local client_states = {}
    for client_id, _ in pairs(connected_clients) do
        local client_state = receive_state_from_client(client_id)
        client_states[client_id] = client_state
    end

    -- 计算最终状态
    game_state = compute_final_state(client_states)

    -- 向所有客户端广播最终状态
    broadcast_game_state(current_tick, game_state)
end

function update_game_state(state)
    -- 更新游戏状态的逻辑
    -- ...
end

function compute_final_state(client_states)
    -- 根据所有客户端的状态计算最终状态
    -- ...
    return final_state
end

function broadcast_game_state(tick, state)
    -- 将当前游戏状态广播给所有客户端
    for client_id, _ in pairs(connected_clients) do
        send_state_to_client(client_id, tick, state)
    end
end

-- 客户端代码
local local_state = {}
local server_tick = 0

function game_update()
    -- 检查是否有新的游戏状态
    local new_state = receive_state_from_server()
    if new_state then
        server_tick = new_state.tick
        local_state = new_state.state

        -- 根据新状态更新游戏逻辑
        update_game_logic(local_state)
    end

    -- 定期将当前状态发送给服务器
    if should_send_state() then
        send_state_to_server(local_state)
    end
end

function update_game_logic(state)
    -- 根据收到的游戏状态更新游戏逻辑
    -- ...
end

function should_send_state()
    -- 判断是否需要向服务器发送当前状态
    -- 可以根据时间间隔或状态变化程度来决定
    return true
end

function send_state_to_server(state)
    -- 将当前状态发送给服务器
    send_to_server(state)
end
