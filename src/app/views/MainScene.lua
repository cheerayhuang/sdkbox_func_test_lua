
local CURRENT_MODULE_NAME = ...

local printf = release_print

local MainScene = class("MainScene", cc.load("mvc").ViewBase)

--local plugins = {'chartboost', 'vungle', 'adcolony', 'agecheq', 'facebook', 'flurryanalytics', 'googleanalytics', 'iap', 'tune', 'kochava'}

-- local plugins = {'facebook'}
local plugins = {'chartboost', 'vungle', 'adcolony', 'googleanalytics', 'tune', 'kochava', 'agecheq'}

MainScene.RESOURCE_FILENAME = "MainScene.csb"

function MainScene:onCreate()
    local mgr = import(".MyPluginMgr", CURRENT_MODULE_NAME).new()
    local handler = nil
    local delayTime = 2.0
    local handlers = {}

    for _, plugin in pairs(plugins) do
        handlers[plugin] = cc.Director:getInstance():getScheduler():scheduleScriptFunc(
                    function()
                        self:test(plugin, mgr, handlers[plugin])
                    end,
                    delayTime,
                    false
        )
        delayTime = delayTime + 2
    end

end

function MainScene:test(plugin, tester, handler)
    printf("Test " .. plugin .. " Begin")
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

    printf("Test " .. plugin .. " End")
end

return MainScene
