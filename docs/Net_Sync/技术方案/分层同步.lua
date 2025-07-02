--[[
  分层同步
  假设我们正在开发一个传奇类MMO游戏,其中包含以下几种状态:

    核心状态:

    玩家血量、魔法值等关键数值
    技能释放、战斗行为等关键动作
    次要状态:

    玩家位置、朝向等状态
    场景物品的位置、状态等
    在分层同步方案中,我们可以这样处理:

    核心状态同步:

    采用传统的状态同步方式,客户端和服务器保持实时同步。
    确保这些关键状态的一致性和准确性。


    次要状态同步:

    对于次要状态,可以采用预测同步或帧内插值的方式。
    客户端负责预测这些状态的变化,服务器只需要校正预测误差。
    或者客户端使用插值算法,根据服务器发送的关键状态点进行插值计算。

【优点】：这种分层同步的方式可以在保证关键状态一致性的同时,降低网络开销和服务器压力,从而提高整体的游戏性能。
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

    -- 广播次要状态变化
    broadcast_secondary_state_delta(game_state.secondary_states)
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

-- 客户端代码
local local_state = {
    core_states = {},
    secondary_states = {}
}

function game_update()
    -- 检查是否有新的核心状态
    local new_core_state = receive_core_state_from_server()
    if new_core_state then
        local_state.core_states = new_core_state
    end

    -- 检查是否有次要状态变化
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
    -- 根据次要状态变化更新本地状态
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
