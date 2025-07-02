-- 游戏对象的状态
local GameObject = {
    x = 0,
    y = 0,
    velocity = 1,
    last_update_time = 0
}

function GameObject:new(x, y, velocity)
    local obj = {
        x = x,
        y = y,
        velocity = velocity,
        last_update_time = os.time()
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function GameObject:update(dt, new_x, new_y)
    self.last_update_time = os.time()
    self.x = new_x
    self.y = new_y
end





-- 客户端
local Client = {
    game_object = nil,
    server_game_object = nil
}

function Client:new(game_object)
    local obj = {
        game_object = game_object,
        server_game_object = GameObject:new(game_object.x, game_object.y, game_object.velocity)
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Client:send_input()
    -- 向服务器发送输入信息
    server:receive_input(self.game_object.x, self.game_object.y)
end

function Client:receive_update(new_x, new_y)
    -- 接收服务器的状态更新
    self.server_game_object:update(os.time() - self.server_game_object.last_update_time, new_x, new_y)
end

function Client:update(dt)
    -- 进行帧插值
    local interp_x = self.server_game_object.x + (self.game_object.x - self.server_game_object.x) * (dt / (os.time() - self.server_game_object.last_update_time))
    local interp_y = self.server_game_object.y + (self.game_object.y - self.server_game_object.y) * (dt / (os.time() - self.server_game_object.last_update_time))
    self.game_object:update(dt, interp_x, interp_y)
end

-- 服务器
local Server = {
    clients = {}
}

function Server:receive_input(x, y)
    -- 接收客户端输入
    for _, client in ipairs(self.clients) do
        -- 更新游戏世界状态
        client.game_object:update(os.time() - client.game_object.last_update_time, x, y)
    end
    -- 将状态广播给所有客户端
    self:broadcast_update(x, y)
end

function Server:broadcast_update(x, y)
    -- 将游戏世界状态广播给所有客户端
    for _, client in ipairs(self.clients) do
        client:receive_update(x, y)
    end
end

-- 使用示例
local server = Server
local client = Client:new(GameObject:new(0, 0, 1))
table.insert(server.clients, client)

while true do
    -- 客户端发送输入
    client:send_input()

    -- 服务器更新游戏世界状态
    server:update()

    -- 客户端进行帧插值
    client:update(1/60)  --假设帧率为60FPS

    -- 渲染游戏画面
    print(string.format("Object position: (%.2f, %.2f)", client.game_object.x, client.game_object.y))

    os.execute("sleep 0.016667")  --假设每帧时间为 1/60 秒
end
