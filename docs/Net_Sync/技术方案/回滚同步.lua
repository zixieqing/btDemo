--[[
    回滚同步（Roll-back/Roll-forward）
    【适用场景】在网络游戏中,由于网络延迟的存在,有时客户端会先执行一些动作,而服务器收到这些操作指令时可能已经滞后了。这就会导致客户端的本地状态与服务器的游戏状态不一致。
    【概念】这种同步机制的核心思想是,客户端会保留一段时间内的游戏状态记录,当收到服务器的更新数据时,如果发现状态不一致,就会回滚到之前的状态,然后重新执行这段时间内的操作,以达到与服务器状态的一致。
    【缺点】：
    1.性能开销较大:
        客户端需要保留一定时间内的历史状态,并在回滚时重新执行操作,对客户端性能要求较高。
        服务器也需要负责管理和广播所有客户端的状态信息,增加了服务器压力。
    2.延迟敏感:
        由于需要回滚和重播操作,Roll-back/Roll-forward同步对网络延迟较为敏感。
        如果网络延迟较高,会导致回滚的频率增加,从而进一步加重性能开销。
    3.复杂度高:
        实现Roll-back/Roll-forward同步机制需要较为复杂的算法和逻辑,开发和调试成本较高。
]]

-- 服务端代码
local game_state = {}
local current_tick = 0

function server_update()
    -- 更新游戏状态
    update_game_state(game_state)
    current_tick = current_tick + 1

    -- 向所有客户端广播当前状态
    broadcast_game_state(current_tick, game_state)
end

function update_game_state(state)
    -- 根据输入更新游戏状态
    -- ...
    return new_state
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
local state_history = {}

function game_update()
    -- 检查是否有新的游戏状态
    local new_state = receive_state_from_server()
    if new_state then
        local new_tick = new_state.tick
        local new_state_data = new_state.state

        -- 如果收到的状态与本地状态不一致,进行回滚
        if new_tick ~= local_tick + 1 then
            rollback_to_state(new_tick, new_state_data)
        else
            -- 更新本地状态
            local_tick = new_tick
            local_state = new_state_data
            state_history[local_tick] = local_state

            -- 执行游戏逻辑
            update_game_logic(local_state)
        end
    end
end

function rollback_to_state(target_tick, target_state)
    -- 从历史状态中找到目标状态
    local rollback_state = nil
    for tick, state in pairs(state_history) do
        if tick <= target_tick then
            rollback_state = state
        else
            break
        end
    end

    if rollback_state then
        -- 回滚到目标状态
        local_state = rollback_state
        local_tick = target_tick

        -- 重新执行从目标状态到当前状态之间的操作
        for tick = target_tick + 1, current_tick do
            local state = state_history[tick]
            update_game_logic(state)
        end
    else
        -- 如果找不到目标状态,则直接使用服务器发送的状态
        local_state = target_state
        local_tick = target_tick
    end
end

function update_game_logic(state)
    -- 根据游戏状态更新游戏逻辑
    -- ...

    -- 将新的状态加入历史记录
    state_history[local_tick + 1] = local_state
end
