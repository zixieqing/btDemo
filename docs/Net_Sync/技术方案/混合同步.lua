--[[
   --混合同步  
--]]

-- 服务端代码
local game_state = {
    core_states = {},
    secondary_states = {}
}

function server_update()
    -- 处理客户端发送的操作指令
    for client_id, actions in pairs(receive_client_actions()) do
        apply_core_actions(game_state.core_states, actions.core)
        apply_secondary_actions(game_state.secondary_states, actions.secondary)
    end

    -- 更新核心状态
    update_core_states(game_state.core_states)

    -- 广播核心状态
    broadcast_core_state(game_state.core_states)

    -- 计算并广播次要状态的增量变化
    local secondary_state_delta = calculate_secondary_state_delta(game_state.secondary_states)
    broadcast_secondary_state_delta(secondary_state_delta)
end

function apply_core_actions(core_states, actions)
    -- 根据核心操作指令更新核心状态
    -- ...
end

function apply_secondary_actions(secondary_states, actions)
    -- 根据次要操作指令更新次要状态
    -- ...
end

function update_core_states(core_states)
    -- 根据游戏逻辑更新核心状态
    -- ...
end

function calculate_secondary_state_delta(secondary_states)
    -- 计算次要状态的变化增量
    -- ...
    return delta
end

-- 客户端代码
local local_state = {
    core_states = {},
    secondary_states = {}
}

function game_update()
    -- 接收并更新核心状态
    local new_core_state = receive_core_state_from_server()
    if new_core_state then
        local_state.core_states = new_core_state
    end

    -- 应用次要状态的增量更新
    local secondary_state_delta = receive_secondary_state_delta_from_server()
    if secondary_state_delta then
        apply_secondary_state_delta(local_state.secondary_states, secondary_state_delta)
    end

    -- 根据本地状态更新游戏逻辑
    update_game_logic(local_state)

    -- 发送操作指令给服务器
    send_actions_to_server({
        core = get_core_actions(),
        secondary = get_secondary_actions()
    })
end

function apply_secondary_state_delta(secondary_states, delta)
    -- 根据次要状态变化增量更新本地状态
    -- 可以使用插值算法来平滑动画效果
    -- ...
end

function update_game_logic(state)
    -- 根据核心状态和次要状态更新游戏逻辑
    -- ...
end

function get_core_actions()
    -- 获取当前玩家的核心操作指令
    -- ...
end

function get_secondary_actions()
    -- 获取当前玩家的次要操作指令
    -- ...
end
