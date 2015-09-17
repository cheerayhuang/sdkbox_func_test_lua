local MyPluginMgr = class("MyPluginMgr")

function MyPluginMgr:ctor()
    print("MyPluginMgr")

    -- AdColony
    sdkbox.PluginAdColony:init()
    sdkbox.PluginAdColony:setListener(function(args)
        if "onAdColonyChange" == args.name then
            local info = args.info  -- sdkbox::AdColonyAdInfo
            local available = args.available -- boolean
            dump(info, "onAdColonyChange:")
            print("available:", available)
        elseif "onAdColonyReward" ==  args.name then
            local info = args.info  -- sdkbox::AdColonyAdInfo
            local currencyName = args.currencyName -- string
            local amount = args.amount -- int
            local success = args.success -- boolean
            dump(info, "onAdColonyReward:")
            print("currencyName:", currencyName)
            print("amount:", amount)
            print("success:", success)
        elseif "onAdColonyStarted" ==  args.name then
            local info = args.info  -- sdkbox::AdColonyAdInfo
            dump(info, "onAdColonyStarted:")
        elseif "onAdColonyFinished" ==  args.name then
            local info = args.info  -- sdkbox::AdColonyAdInfo
            dump(info, "onAdColonyFinished:")
        end
    end)

    -- Chartboost
    sdkbox.PluginChartboost:init()
    sdkbox.PluginChartboost:setListener(function(args)
        if "onChartboostCached" == args.func then
            local name = args.name -- string
            print("onChartboostCached")
            print("name:", args.name)
        elseif "onChartboostShouldDisplay" == args.func then
            local name = args.name -- string
            print("onChartboostShouldDisplay")
            print("name:", args.name)
        elseif "onChartboostDisplay" == args.func then
            local name = args.name -- string
            print("onChartboostDisplay")
            print("name:", args.name)
        elseif "onChartboostDismiss" == args.func then
            local name = args.name -- string
            print("onChartboostDismiss")
            print("name:", args.name)
        elseif "onChartboostClose" == args.func then
            local name = args.name -- string
            print("onChartboostClose")
            print("name:", args.name)
        elseif "onChartboostClick" == args.func then
            local name = args.name -- string
            print("onChartboostClick")
            print("name:", args.name)
        elseif "onChartboostReward" == args.func then
            local name = args.name -- string
            local reward = args.reward -- int
            print("onChartboostReward")
            print("name:", args.name)
            print("reward:", reward)
        elseif "onChartboostFailedToLoad" == args.func then
            local name = args.name -- string
            local e = args.e -- int
            print("onChartboostFailedToLoad")
            print("name:", args.name)
            print("error:", e)
        elseif "onChartboostFailToRecordClick" == args.func then
            local name = args.name -- string
            local e = args.e -- int
            print("onChartboostFailToRecordClick")
            print("name:", args.name)
            print("error:", e)
        elseif "onChartboostConfirmation" == args.func then
            local name = args.name -- string
            print("onChartboostConfirmation")
        elseif "onChartboostCompleteStore" == args.func then
            local name = args.name -- string
            print("onChartboostCompleteStore")
        end
    end)


    -- Flurry
    sdkbox.PluginFlurryAnalytics:init()
    sdkbox.PluginFlurryAnalytics:setListener(function(data)
        local ret = json.decode(data)
        print("apiKey:", ret.apiKey, "sessionId:", ret.sessionId)
        -- check session state
        print("Flurry analytics session exist: ", sdkbox.PluginFlurryAnalytics:activeSessionExists())
        print("Flurry analytics session: ", sdkbox.PluginFlurryAnalytics:getSessionID())
        local eventName = "test event1"
        sdkbox.PluginFlurryAnalytics:logEvent(eventName);
    end)


    -- Google Analytics
    --sdkbox.PluginGoogleAnalytics:init()


    -- IAP
    sdkbox.IAP:init()

    sdkbox.IAP:setListener(function(args)
        if "onSuccess" == args.event then
            local product = args.product
            dump(product, "onSuccess:")
        elseif "onFailure" == args.event then
            local product = args.product
            local msg = args.msg
            dump(product, "onFailure:")
            print("msg:", msg)
        elseif "onCanceled" == args.event then
            local product = args.product
            dump(product, "onCanceled:")
        elseif "onRestored" == args.event then
            local product = args.product
            dump(product, "onRestored:")
        elseif "onProductRequestSuccess" == args.event then
            local products = args.products
            dump(products, "onProductRequestSuccess:")
        elseif "onProductRequestFailure" == args.event then
            local msg = args.msg
            print("msg:", msg)
        else
            print("unknow event ", args.event)
        end
    end)

    -- Kochava
    --sdkbox.PluginKochava:init()

    -- Tune
    sdkbox.PluginTune:init()
    sdkbox.PluginTune:setPackageName("org.cocos2dx.tune")
    sdkbox.PluginTune:setListener(function(eventName, eventData)
        print(eventName, eventData)
    end)
    sdkbox.PluginTune:measureSession()

    -- Vungle
    sdkbox.PluginVungle:init()
    sdkbox.PluginVungle:setListener(function(name, isComplete)
        if "onVungleCacheAvailable" == name then
            print("onVungleCacheAvailable")
        elseif "onVungleStarted" ==  name then
            print("onVungleStarted")
        elseif "onVungleFinished" ==  name then
            print("onVungleFinished")
        elseif "onVungleAdViewed" ==  name then
            print("onVungleAdViewed:", isComplete)
        end
    end)

    -- Facebook
    sdkbox.PluginFacebook:init()
    sdkbox.PluginFacebook:setListener(function(event)
        print("PluginFacebook callback")
        print(event)
    end)

    -- AgeCheq
    sdkbox.PluginAgeCheq:init()
    sdkbox.PluginAgeCheq:setListener(function(data)
        print("PluginAgeCheq callback")
        if "checkResponse" == data.event then
            print(data)
        elseif "associateDataResponse" == data.event then
            print(data)
        end
    end)

    sdkbox.PluginFyber:init()
    sdkbox.PluginFyber:setListener(function(args)
        if "onVirtualCurrencyConnectorFailed" == args.name then
            dump(args, "onVirtualCurrencyConnectorFailed:")
        elseif "onVirtualCurrencyConnectorSuccess" == args.name then
            dump(args, "onVirtualCurrencyConnectorSuccess:")
        elseif "onCanShowInterstitial" == args.name then
            dump(args, "onCanShowInterstitial")

        elseif "onInterstitialDidShow" == args.name then
            dump(args, "onInterstitialDidShow")
        elseif "onInterstitialDismiss" == args.name then
            dump(args, "onInterstitialDismiss")
        elseif "onInterstitialFailed" == args.name then
            dump(args, "onInterstitialFailed:")
        elseif "onBrandEngageClientReceiveOffers" == args.name then
            dump(args, "onBrandEngageClientReceiveOffers:")
        elseif "onBrandEngageClientChangeStatus" == args.name then
            dump(args, "onBrandEngageClientChangeStatus:")
        elseif "onOfferWallFinish" == args.name then
            dump(args, "onOfferWallFinish")
        else
            print("unknow event ", args.name)
        end
    end)
end


function MyPluginMgr:adcolonyFunc()
    print("AdColony: show video")
    sdkbox.PluginAdColony:show("video")
    print("AdColony: show v4vc")
    sdkbox.PluginAdColony:show("v4vc")
end

function MyPluginMgr:chartboostFunc()
    print("Chartboost: show default")
    sdkbox.PluginChartboost:show("Default")
    print("Chartboost: show LC")
    sdkbox.PluginChartboost:show("Level Complete")
end

function MyPluginMgr:flurrySendData()
    sdkbox.PluginFlurryAnalytics:startSession()

    local ret = sdkbox.PluginFlurryAnalytics:activeSessionExists()
    if not ret then
        print("session not exist return");
        return false;
    end

    ret = sdkbox.PluginFlurryAnalytics:getSessionID();
    print("Flurry analytics session : ", tostring(ret));

    local origin = "this is origin name";
    local originVersion = "origin version";
    sdkbox.PluginFlurryAnalytics:addOrigin(origin, originVersion);

    origin = "other origin";
    originVersion = "other origin version";
    local params = {}
    params['key1'] = 'value1'
    params['key2'] = 'value2'
    sdkbox.PluginFlurryAnalytics:addOrigin(origin, originVersion, params);

    ret = "test event1";
    sdkbox.PluginFlurryAnalytics:logEvent(ret);

    ret = "test event2";
    params = {}
    parmas['ekey1'] = 'eval1'
    parmas['ekey2'] = 'eval2'
    sdkbox.PluginFlurryAnalytics:logEvent(ret, params);

    ret = "test event3";
    sdkbox.PluginFlurryAnalytics:logEvent(ret, true);
    sdkbox.PluginFlurryAnalytics:endTimedEvent(ret);

    ret = "test event4";
    params = {}
    parmas['ekey3'] = 'eval3'
    parmas['ekey4'] = 'eval4'
    sdkbox.PluginFlurryAnalytics:logEvent(ret, params, true);
    sdkbox.PluginFlurryAnalytics:endTimedEvent(ret, params);

    ret = "error test";
    local msg = "log errror msg";
    local ifno = "log error info";
    sdkbox.PluginFlurryAnalytics:logError(ret, msg, ifno);

    sdkbox.PluginFlurryAnalytics:logPageView();

    ret = "this is user id";
    sdkbox.PluginFlurryAnalytics:setUserID(ret);
    sdkbox.PluginFlurryAnalytics:setAge(11);
    ret = "m";
    sdkbox.PluginFlurryAnalytics:setGender(ret);

    sdkbox.PluginFlurryAnalytics:pauseBackgroundSession();

    sdkbox.PluginFlurryAnalytics:setReportLocation(true);

    sdkbox.PluginFlurryAnalytics:clearLocation();

    --chendu, sichuan, china
    sdkbox.PluginFlurryAnalytics:setLatitude(104.06, 30.67, 0, 0);

    sdkbox.PluginFlurryAnalytics:setSessionReportsOnCloseEnabled(true);
    sdkbox.PluginFlurryAnalytics:setSessionReportsOnPauseEnabled(true);
    sdkbox.PluginFlurryAnalytics:setBackgroundSessionEnabled(true);

    sdkbox.PluginFlurryAnalytics:setEventLoggingEnabled(true);
    sdkbox.PluginFlurryAnalytics:setPulseEnabled(true);

    sdkbox.PluginFlurryAnalytics:endSession();

    print("Flurry analytics send data finish");

end

function MyPluginMgr:flurryanalyticsFunc()
    print("Flurry: test")

    self:flurrySendData()
end

--[[
function MyPluginMgr:googleanalyticsFunc()
    print("googleanalytics: test")
    sdkbox.PluginGoogleAnalytics:logTiming("Startup", 0, "timing name", "timing label")
    sdkbox.PluginGoogleAnalytics:logEvent("EventCategory 1", "EventAction 1", "EventLabel 1", 10)
    sdkbox.PluginGoogleAnalytics:logScreen("Screen1")
    sdkbox.PluginGoogleAnalytics:logEvent("Read", "Press", "Button1", 10)
    sdkbox.PluginGoogleAnalytics:logEvent("Read", "Press", "Button2", 20)
    sdkbox.PluginGoogleAnalytics:logEvent("Dispose", "Release", "Button22", 20)
    sdkbox.PluginGoogleAnalytics:logScreen("Screen2")
    sdkbox.PluginGoogleAnalytics:logSocial("twitter", "retweet", "retweet esto fu.")
    sdkbox.PluginGoogleAnalytics:logException("Algo se ha roto", false)
    sdkbox.PluginGoogleAnalytics:dispatchPeriodically(60)
end
--]]

function MyPluginMgr:iapFunc()
    print("IAP: purchase test")
    sdkbox.IAP:purchase("remove_ads")
    sdkbox.IAP:purchase("coin_package")
end

function MyPluginMgr:kochavaFunc()
    print("Kochava: test")
    sdkbox.PluginKochava:trackEvent("KochavaCustomEvent", "HelloWorld")
    sdkbox.PluginKochava:spatialEvent("test", 100, 101, 102)
end

-- Tune api failed.
function MyPluginMgr:testTuneMeasureEvent()
    -- TODO
end

function MyPluginMgr:tuneFunc()
    print("Tune: test")

    sdkbox.PluginTune:checkForDeferredDeeplinkWithTimeout(60);
    sdkbox.PluginTune:automateIapEventMeasurement(true);
    sdkbox.PluginTune:setCurrencyCode("RMB");
    sdkbox.PluginTune:setUserEmail("natalie@somedomain.com");
    sdkbox.PluginTune:setUserName("natalie123");
    sdkbox.PluginTune:setAge(43);
    sdkbox.PluginTune:setGender(sdkbox.PluginTune.GenderFemale);
    sdkbox.PluginTune:setUserId("US13579");
    sdkbox.PluginTune:setFacebookUserId("321321321321");
    sdkbox.PluginTune:setGoogleUserId("11223344556677");
    sdkbox.PluginTune:setTwitterUserId("1357924680");
    sdkbox.PluginTune:setLatitude(9.142276, -79.724052, 15);
    sdkbox.PluginTune:setAppAdTracking(true);
    sdkbox.PluginTune:measureEventName("login");

    --self:testTuneMeasureEvent()
end

function MyPluginMgr:vungleFunc()
    print("Vungle: show video")
    sdkbox.PluginVungle:show("video")

    print("Vungle: show reward")
    sdkbox.PluginVungle:show("reward")
end

function MyPluginMgr:facebookFunc()

    print("check FacebookCheckStatus")

    print("> permission: ", sdkbox.PluginFacebook:getPermissionList());
    print("> token: ", sdkbox.PluginFacebook:getAccessToken());
    print("> user id: ", sdkbox.PluginFacebook:getUserID());
    print("> FBSDK version:", sdkbox.PluginFacebook:getSDKVersion());

    print("show FacebookShareLink")

    local t = {}
    t.link = "http://www.cocos2d-x.org"
    t.title = "cocos2d-x"
    t.text = "The Best Game Engine"
    t.imageUrl = "http://cocos2d-x.org/images/logo.png"
    sdkbox.PluginFacebook:dialog(t)

    --sdkbox.PluginFacebook:login()
end

function MyPluginMgr:agecheqFunc()
    print("[agecheq] calling agecheq api")
    sdkbox.PluginAgeCheq:check("1426")
    sdkbox.PluginAgeCheq:associateData("1426", "ikfill");
end

function MyPluginMgr:fyberFunc()
    print("[fyber] calling fyber api")

    sdkbox.PluginFyber:requestInterstitial()
    sdkbox.PluginFyber:showOfferWall("rmb")
    sdkbox.PluginFyber:requestOffers("rmb")
    sdkbox.PluginFyber:requestDeltaOfCoins("rmb")

end

return MyPluginMgr
