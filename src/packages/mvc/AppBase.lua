
local AppBase = class("AppBase")

AppBase.APP_ENTER_BACKGROUND_EVENT = "APP_ENTER_BACKGROUND_EVENT"
AppBase.APP_ENTER_FOREGROUND_EVENT = "APP_ENTER_FOREGROUND_EVENT"

AppBase._customListenerBg = nil
AppBase._customListenerFg = nil

function AppBase:ctor(configs)
    cc.load("event").new():bind(self)

    self.configs_ = {
        viewsRoot  = "app.views",
        modelsRoot = "app.models",
        defaultSceneName = "MainScene",
    }

    for k, v in pairs(configs or {}) do
        self.configs_[k] = v
    end

    if type(self.configs_.viewsRoot) ~= "table" then
        self.configs_.viewsRoot = {self.configs_.viewsRoot}
    end
    if type(self.configs_.modelsRoot) ~= "table" then
        self.configs_.modelsRoot = {self.configs_.modelsRoot}
    end

    if DEBUG > 1 then
        dump(self.configs_, "AppBase configs")
    end

    if CC_SHOW_FPS then
        cc.Director:getInstance():setDisplayStats(true)
    end

    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    self._customListenerBg = cc.EventListenerCustom:create(AppBase.APP_ENTER_BACKGROUND_EVENT, handler(self, self.onEnterBackground))
    eventDispatcher:addEventListenerWithFixedPriority(self._customListenerBg, 1)
    self._customListenerFg = cc.EventListenerCustom:create(AppBase.APP_ENTER_FOREGROUND_EVENT, handler(self, self.onEnterForeground))
    eventDispatcher:addEventListenerWithFixedPriority(self._customListenerFg, 1)

    -- event
    self:onCreate()
end

function AppBase:clear()
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    eventDispatcher:removeEventListener(self._customListenerBg)
    eventDispatcher:removeEventListener(self._customListenerFg)
end

function AppBase:run(initSceneName)
    initSceneName = initSceneName or self.configs_.defaultSceneName
    self:enterScene(initSceneName)
end

function AppBase:enterScene(sceneName, transition, time, more)
    local view = self:createView(sceneName)
    view:showWithScene(transition, time, more)
    return view
end

function AppBase:createView(name)
    for _, root in ipairs(self.configs_.viewsRoot) do
        local packageName = string.format("%s.%s", root, name)
        local status, view = xpcall(function()
                return require(packageName)
            end, function(msg)
            if not string.find(msg, string.format("'%s' not found:", packageName)) then
                print("load view error: ", msg)
            end
        end)
        local t = type(view)
        if status and (t == "table" or t == "userdata") then
            return view:create(self, name)
        end
    end
    error(string.format("AppBase:createView() - not found view \"%s\" in search paths \"%s\"",
        name, table.concat(self.configs_.viewsRoot, ",")), 0)
end

function AppBase:onCreate()
end

function AppBase:onEnterBackground()
    self:dispatchEvent({name = AppBase.APP_ENTER_BACKGROUND_EVENT})
end

function AppBase:onEnterForeground()
    self:dispatchEvent({name = AppBase.APP_ENTER_FOREGROUND_EVENT})
end

return AppBase
