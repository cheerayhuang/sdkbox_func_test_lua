
local CURRENT_MODULE_NAME = ...

local MainScene = class("MainScene", cc.load("mvc").ViewBase)

-- 'googleanalytics' and 'kochava' are blocked by patch bugs.
local plugins = {'googleanalytics', 'kochava', 'review', 'fyber', 'facebook', 'flurryanalytics', 'iap', 'chartboost', 'vungle', 'adcolony', 'tune', 'agecheq'}

local INTERVAL = 2.0

MainScene.RESOURCE_FILENAME = "MainScene.csb"

function MainScene:onCreate()
    local mgr = import(".MyPluginMgr", CURRENT_MODULE_NAME).new()
    local handler = nil
    local delayTime = INTERVAL
    local handlers = {}

    for _, plugin in pairs(plugins) do
        handlers[plugin] = cc.Director:getInstance():getScheduler():scheduleScriptFunc(
                    function()
                        self:test(plugin, mgr, handlers[plugin])
                    end,
                    delayTime,
                    false
        )
        delayTime = delayTime + INTERVAL
    end

end

function MainScene:test(plugin, tester, handler)
    print("Test " .. plugin .. " Begin")
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(handler)

    local f = plugin .. 'Func'
    if type(tester[f]) == 'function' then
        tester[f](tester)
    end

    for fname, func in pairs(tester) do
        local pattern = '^' .. plugin .. '%a+' .. 'Func$'
        if string.find(fname, pattern) and type(func) == 'function' then
            func(tester)
        end
    end

    print("Test " .. plugin .. " End")
end

return MainScene
