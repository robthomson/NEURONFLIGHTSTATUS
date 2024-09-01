neuronstatus = {}

local arg = {...}

local widgetDir = arg[1].widgetDir
local compile = arg[2]

neuronstatus.wakeupSchedulerUI = os.clock()
neuronstatus.environment = system.getVersion()
neuronstatus.oldsensors = {"refresh", "voltage", "rpm", "current", "temp_esc", "fuel", "mah", "rssi"}
neuronstatus.loopCounter = 0
neuronstatus.sensors = nil
neuronstatus.supportedRADIO = false
neuronstatus.gfx_model = nil
neuronstatus.gfx_default = nil
neuronstatus.sensors = {}
neuronstatus.sensordisplay = {}
neuronstatus.lvTimer = false
neuronstatus.lvTimerStart = nil
neuronstatus.lvannounceTimer = false
neuronstatus.lvannounceTimerStart = nil
neuronstatus.lvaudioannounceCounter = 0
neuronstatus.lvAudioAlertCounter = 0
neuronstatus.timerAlarmPlay = true
neuronstatus.lfTimer = false
neuronstatus.lfTimerStart = nil
neuronstatus.lfannounceTimer = false
neuronstatus.lfannounceTimerStart = nil
neuronstatus.lfaudioannounceCounter = 0
neuronstatus.lfAudioAlertCounter = 0
neuronstatus.rpmTimer = false
neuronstatus.rpmTimerStart = nil
neuronstatus.rpmannounceTimer = false
neuronstatus.rpmannounceTimerStart = nil
neuronstatus.rpmaudioannounceCounter = 0
neuronstatus.currentTimer = false
neuronstatus.currentTimerStart = nil
neuronstatus.capacityParam = nil
neuronstatus.currentannounceTimer = false
neuronstatus.currentannounceTimerStart = nil
neuronstatus.currentaudioannounceCounter = 0
neuronstatus.lqTimer = false
neuronstatus.lqTimerStart = nil
neuronstatus.lqannounceTimer = false
neuronstatus.lqannounceTimerStart = nil
neuronstatus.lqaudioannounceCounter = 0
neuronstatus.fuelTimer = false
neuronstatus.fuelTimerStart = nil
neuronstatus.fuelannounceTimer = false
neuronstatus.fuelannounceTimerStart = nil
neuronstatus.fuelaudioannounceCounter = 0
neuronstatus.escTimer = false
neuronstatus.escTimerStart = nil
neuronstatus.escannounceTimer = false
neuronstatus.escannounceTimerStart = nil
neuronstatus.escaudioannounceCounter = 0
neuronstatus.mcuTimer = false
neuronstatus.mcuTimerStart = nil
neuronstatus.mcuannounceTimer = false
neuronstatus.mcuannounceTimerStart = nil
neuronstatus.mcuaudioannounceCounter = 0
neuronstatus.timerTimer = false
neuronstatus.timerTimerStart = nil
neuronstatus.timerannounceTimer = false
neuronstatus.timerannounceTimerStart = nil
neuronstatus.timeraudioannounceCounter = 0
neuronstatus.linkUP = 0
neuronstatus.refresh = true
neuronstatus.isInConfiguration = false
neuronstatus.stopTimer = true
neuronstatus.startTimer = false
neuronstatus.voltageIsLow = false
neuronstatus.fuelIsLow = false
neuronstatus.showLOGS = false
neuronstatus.readLOGS = false
neuronstatus.readLOGSlast = {}
neuronstatus.linkUPTime = 0
neuronstatus.tempconvertParamESC = 1
neuronstatus.miniBoxParam = 0
neuronstatus.lowvoltagStickParam = 0
neuronstatus.lowvoltagStickCutoffParam = 70
neuronstatus.fmsrcParam = 0
neuronstatus.btypeParam = 0
neuronstatus.lowfuelParam = 20
neuronstatus.alertintParam = 5
neuronstatus.alrthptcParam = 1
neuronstatus.maxminParam = true
neuronstatus.titleParam = true
neuronstatus.cellsParam = 6
neuronstatus.lowVoltageGovernorParam = true
neuronstatus.sagParam = 5
neuronstatus.announceVoltageSwitchParam = nil
neuronstatus.announceRPMSwitchParam = nil
neuronstatus.announceCurrentSwitchParam = nil
neuronstatus.announceFuelSwitchParam = nil
neuronstatus.announceLQSwitchParam = nil
neuronstatus.announceESCSwitchParam = nil
neuronstatus.announceTimerSwitchParam = nil
neuronstatus.filteringParam = 1
neuronstatus.lowvoltagsenseParam = 2
neuronstatus.announceIntervalParam = 30
neuronstatus.alertonParam = 0
neuronstatus.calcfuelParam = true
neuronstatus.idleupSwitchParam = nil
neuronstatus.armSwitchParam = nil
neuronstatus.timeralarmVibrateParam = true
neuronstatus.timeralarmParam = 210
neuronstatus.timerWASActive = false
neuronstatus.motorWasActive = false
neuronstatus.maxMinSaved = false
neuronstatus.simPreSPOOLUP = false
neuronstatus.simDoSPOOLUP = false
neuronstatus.simDODISARM = false
neuronstatus.simDoSPOOLUPCount = 0
neuronstatus.actTime = nil
neuronstatus.maxminFinals1 = nil
neuronstatus.maxminFinals2 = nil
neuronstatus.maxminFinals3 = nil
neuronstatus.maxminFinals4 = nil
neuronstatus.maxminFinals5 = nil
neuronstatus.maxminFinals6 = nil
neuronstatus.maxminFinals7 = nil
neuronstatus.maxminFinals8 = nil
neuronstatus.noTelemTimer = 0
neuronstatus.closeButtonX = 0
neuronstatus.closeButtonY = 0
neuronstatus.closeButtonW = 0
neuronstatus.closeButtonH = 0
neuronstatus.sensorVoltageMax = 0
neuronstatus.sensorVoltageMin = 0
neuronstatus.sensorFuelMin = 0
neuronstatus.sensorFuelMax = 0
neuronstatus.sensorRPMMin = 0
neuronstatus.sensorRPMMax = 0
neuronstatus.sensorCurrentMin = 0
neuronstatus.sensorCurrentMax = 0
neuronstatus.sensorTempESCMin = 0
neuronstatus.sensorTempESCMax = 0
neuronstatus.sensorRSSIMin = 0
neuronstatus.sensorRSSIMax = 0
neuronstatus.lastMaxMin = 0
neuronstatus.voltageNoiseQ = 100
neuronstatus.fuelNoiseQ = 100
neuronstatus.rpmNoiseQ = 100
neuronstatus.temp_mcuNoiseQ = 100
neuronstatus.temp_escNoiseQ = 100
neuronstatus.rssiNoiseQ = 100
neuronstatus.currentNoiseQ = 100
neuronstatus.armSwitchParam = nil
neuronstatus.idleupSwitchParam = nil
neuronstatus.layoutOptions = {
    {"TIMER", 1}, {"VOLTAGE", 2}, {"FUEL", 3}, {"CURRENT", 4}, {"MAH", 5}, {"RPM", 6}, {"LQ", 7}, {"FM", 8}, {"T.ESC", 9}, {"IMAGE", 10}, {"IMAGE,FM", 11}, {"VOLTAGE,FUEL", 12},
    {"VOLTAGE,CURRENT", 13}, {"VOLTAGE,MAH", 14}, {"TIMER,T.ESC,LQ", 15}
}
neuronstatus.layoutBox1Param = 11 -- IMAGE, FM
neuronstatus.layoutBox2Param = 2 -- VOLTAGE
neuronstatus.layoutBox3Param = 3 -- FUEL
neuronstatus.layoutBox4Param = 15 -- ESC,LQ,TIMER
neuronstatus.layoutBox5Param = 4 -- CURRENT
neuronstatus.layoutBox6Param = 6 -- RPM
neuronstatus.armState = false
neuronstatus.idleState = false

function neuronstatus.create(widget)
    neuronstatus.gfx_model = lcd.loadBitmap(model.bitmap())
    neuronstatus.gfx_default = lcd.loadBitmap(widgetDir .. "gfx/default.png")
    neuronstatus.gfx_close = lcd.loadBitmap(widgetDir .. "gfx/close.png")
    neuronstatus.rssiSensor = neuronstatus.getRssiSensor()

    if tonumber(neuronstatus.sensorMakeNumber(neuronstatus.environment.version)) < 152 then
        neuronstatus.screenError("ETHOS < V1.5.2")
        return
    end

    return {
        fmsrc = 0,
        btype = 0,
        lowfuel = 20,
        alertint = 5,
        alrthptc = 1,
        maxmin = 1,
        title = 1,
        cells = 6,
        announceswitchvltg = nil,
        rpmalerts = 0,
        rpmaltp = 2.5,
        announceswitchrpm = nil,
        announceswitchcrnt = nil,
        announceswitchfuel = nil,
        announceswitchlq = nil,
        announceswitchesc = nil,
        announceswitchmcu = nil,
        announceswitchtmr = nil,
        filtering = 1,
        sag = 5,
        lvsense = 2,
        announceint = 30,
        alerton = 0,
        tempconvertesc = 1,
        capacity = 1000
    }
end

function neuronstatus.configure(widget)
    neuronstatus.isInConfiguration = true

    triggerpanel = form.addExpansionPanel("Triggers")
    triggerpanel:open(false)

    line = triggerpanel:addLine("Arm switch")
    form.addSwitchField(line, form.getFieldSlots(line)[0], function()
        return neuronstatus.armSwitchParam
    end, function(value)
        neuronstatus.armSwitchParam = value
    end)

    line = triggerpanel:addLine("Idleup switch")
    form.addSwitchField(line, form.getFieldSlots(line)[0], function()
        return neuronstatus.idleupSwitchParam
    end, function(value)
        neuronstatus.idleupSwitchParam = value
    end)

    line = triggerpanel:addLine("    Delay before active")
    field = form.addNumberField(line, nil, 5, 60, function()
        return idleupdelayParam
    end, function(value)
        idleupdelayParam = value
    end)
    field:default(5)
    field:suffix("s")

    batterypanel = form.addExpansionPanel("Battery configuration")
    batterypanel:open(false)

    -- CELLS
    line = batterypanel:addLine("Type")
    form.addChoiceField(line, nil, {{"LiPo", 0}, {"LiHv", 1}, {"Lion", 2}, {"LiFe", 3}, {"NiMh", 4}}, function()
        return neuronstatus.btypeParam
    end, function(newValue)
        neuronstatus.btypeParam = newValue
    end)

    -- BATTERY CAPACITY
    line = batterypanel:addLine("Capacity")
    field = form.addNumberField(line, nil, 0, 20000, function()
        return neuronstatus.capacityParam
    end, function(value)
        neuronstatus.capacityParam = value
    end)
    field:default(1000)
    field:suffix("mAh")

    -- BATTERY CELLS
    line = batterypanel:addLine("Cells")
    field = form.addNumberField(line, nil, 0, 14, function()
        return neuronstatus.cellsParam
    end, function(value)
        neuronstatus.cellsParam = value
    end)
    field:default(6)

    -- LOW FUEL announce
    line = batterypanel:addLine("Low fuel%")
    field = form.addNumberField(line, nil, 0, 50, function()
        return neuronstatus.lowfuelParam
    end, function(value)
        neuronstatus.lowfuelParam = value
    end)
    field:default(20)
    field:suffix("%")

    -- ALERT ON
    line = batterypanel:addLine("Play alert on")
    form.addChoiceField(line, nil, {{"Low voltage", 0}, {"Low fuel", 1}, {"Low fuel & Low voltage", 2}, {"Disabled", 3}}, function()
        return neuronstatus.alertonParam
    end, function(newValue)
        if newValue == 3 then
            plalrtint:enable(false)
            plalrthap:enable(false)
        else
            plalrtint:enable(true)
            plalrthap:enable(true)
        end
        neuronstatus.alertonParam = newValue
    end)

    -- ALERT INTERVAL
    line = batterypanel:addLine("     Interval")
    plalrtint = form.addChoiceField(line, nil, {{"5S", 5}, {"10S", 10}, {"15S", 15}, {"20S", 20}, {"30S", 30}}, function()
        return neuronstatus.alertintParam
    end, function(newValue)
        neuronstatus.alertintParam = newValue
    end)
    if neuronstatus.alertonParam == 3 then
        plalrtint:enable(false)
    else
        plalrtint:enable(true)
    end

    -- HAPTIC
    line = batterypanel:addLine("     Vibrate")
    plalrthap = form.addBooleanField(line, nil, function()
        return alrthptParam
    end, function(newValue)
        alrthptParam = newValue
    end)
    if neuronstatus.alertonParam == 3 then
        plalrthap:enable(false)
    else
        plalrthap:enable(true)
    end

    timerpanel = form.addExpansionPanel("Timer configuration")
    timerpanel:open(false)

    timeTable = {
        {"Disabled", 0}, {"00:30", 30}, {"01:00", 60}, {"01:30", 90}, {"02:00", 120}, {"02:30", 150}, {"03:00", 180}, {"03:30", 210}, {"04:00", 240}, {"04:30", 270}, {"05:00", 300}, {"05:30", 330},
        {"06:00", 360}, {"06:30", 390}, {"07:00", 420}, {"07:30", 450}, {"08:00", 480}, {"08:30", 510}, {"09:00", 540}, {"09:30", 570}, {"10:00", 600}, {"10:30", 630}, {"11:00", 660}, {"11:30", 690},
        {"12:00", 720}, {"12:30", 750}, {"13:00", 780}, {"13:30", 810}, {"14:00", 840}, {"14:30", 870}, {"15:00", 900}, {"15:30", 930}, {"16:00", 960}, {"16:30", 990}, {"17:00", 1020},
        {"17:30", 1050}, {"18:00", 1080}, {"18:30", 1110}, {"19:00", 1140}, {"19:30", 1170}, {"20:00", 1200}
    }

    line = timerpanel:addLine("Play alarm at")
    form.addChoiceField(line, nil, timeTable, function()
        return neuronstatus.timeralarmParam
    end, function(newValue)
        neuronstatus.timeralarmParam = newValue
    end)

    line = timerpanel:addLine("Vibrate")
    form.addBooleanField(line, nil, function()
        return neuronstatus.timeralarmVibrateParam
    end, function(newValue)
        neuronstatus.timeralarmVibrateParam = newValue
    end)

    announcepanel = form.addExpansionPanel("Telemetry announcements")
    announcepanel:open(false)

    -- announce VOLTAGE READING
    line = announcepanel:addLine("Voltage")
    form.addSwitchField(line, form.getFieldSlots(line)[0], function()
        return neuronstatus.announceVoltageSwitchParam
    end, function(value)
        neuronstatus.announceVoltageSwitchParam = value
    end)

    -- announce RPM READING
    line = announcepanel:addLine("Rpm")
    form.addSwitchField(line, nil, function()
        return neuronstatus.announceRPMSwitchParam
    end, function(value)
        neuronstatus.announceRPMSwitchParam = value
    end)

    -- announce CURRENT READING
    line = announcepanel:addLine("Current")
    form.addSwitchField(line, nil, function()
        return neuronstatus.announceCurrentSwitchParam
    end, function(value)
        neuronstatus.announceCurrentSwitchParam = value
    end)

    -- announce FUEL READING
    line = announcepanel:addLine("Fuel")
    form.addSwitchField(line, form.getFieldSlots(line)[0], function()
        return neuronstatus.announceFuelSwitchParam
    end, function(value)
        neuronstatus.announceFuelSwitchParam = value
    end)

    -- announce LQ READING
    line = announcepanel:addLine("LQ")
    form.addSwitchField(line, form.getFieldSlots(line)[0], function()
        return neuronstatus.announceLQSwitchParam
    end, function(value)
        neuronstatus.announceLQSwitchParam = value
    end)

    -- announce LQ READING
    line = announcepanel:addLine("Temperature")
    form.addSwitchField(line, form.getFieldSlots(line)[0], function()
        return neuronstatus.announceESCSwitchParam
    end, function(value)
        neuronstatus.announceESCSwitchParam = value
    end)

    -- announce TIMER READING
    line = announcepanel:addLine("Timer")
    form.addSwitchField(line, form.getFieldSlots(line)[0], function()
        return neuronstatus.announceTimerSwitchParam
    end, function(value)
        neuronstatus.announceTimerSwitchParam = value
    end)

    displaypanel = form.addExpansionPanel("Customise display")
    displaypanel:open(false)

    line = displaypanel:addLine("Box1")
    form.addChoiceField(line, nil, neuronstatus.layoutOptions, function()
        return neuronstatus.layoutBox1Param
    end, function(newValue)
        neuronstatus.layoutBox1Param = newValue
    end)

    line = displaypanel:addLine("Box2")
    form.addChoiceField(line, nil, neuronstatus.layoutOptions, function()
        return neuronstatus.layoutBox2Param
    end, function(newValue)
        neuronstatus.layoutBox2Param = newValue
    end)

    line = displaypanel:addLine("Box3")
    form.addChoiceField(line, nil, neuronstatus.layoutOptions, function()
        return neuronstatus.layoutBox3Param
    end, function(newValue)
        neuronstatus.layoutBox3Param = newValue
    end)

    line = displaypanel:addLine("Box4")
    form.addChoiceField(line, nil, neuronstatus.layoutOptions, function()
        return neuronstatus.layoutBox4Param
    end, function(newValue)
        neuronstatus.layoutBox4Param = newValue
    end)

    line = displaypanel:addLine("Box5")
    form.addChoiceField(line, nil, neuronstatus.layoutOptions, function()
        return neuronstatus.layoutBox5Param
    end, function(newValue)
        neuronstatus.layoutBox5Param = newValue
    end)

    line = displaypanel:addLine("Box6")
    form.addChoiceField(line, nil, neuronstatus.layoutOptions, function()
        return neuronstatus.layoutBox6Param
    end, function(newValue)
        neuronstatus.layoutBox6Param = newValue
    end)

    -- TITLE DISPLAY
    line = displaypanel:addLine("Title")
    form.addBooleanField(line, nil, function()
        return neuronstatus.titleParam
    end, function(newValue)
        neuronstatus.titleParam = newValue
    end)

    -- MAX MIN DISPLAY
    line = displaypanel:addLine("Max/Min")
    form.addBooleanField(line, nil, function()
        return neuronstatus.maxminParam
    end, function(newValue)
        neuronstatus.maxminParam = newValue
    end)

    advpanel = form.addExpansionPanel("Advanced")
    advpanel:open(false)

    line = advpanel:addLine("Temp. Conversion")
    form.addChoiceField(line, nil, {{"Disable", 1}, {"°C -> °F", 2}, {"°F -> °C", 3}}, function()
        return neuronstatus.tempconvertParamESC
    end, function(newValue)
        neuronstatus.tempconvertParamESC = newValue
    end)

    line = form.addLine("Voltage", advpanel)

    -- LVannounce DISPLAY
    line = advpanel:addLine("    Sensitivity")
    form.addChoiceField(line, nil, {{"HIGH", 1}, {"MEDIUM", 2}, {"LOW", 3}}, function()
        return neuronstatus.lowvoltagsenseParam
    end, function(newValue)
        neuronstatus.lowvoltagsenseParam = newValue
    end)

    line = advpanel:addLine("    Sag compensation")
    field = form.addNumberField(line, nil, 0, 10, function()
        return neuronstatus.sagParam
    end, function(value)
        neuronstatus.sagParam = value
    end)
    field:default(5)
    field:suffix("s")
    -- field:decimals(1)

    -- FILTER
    -- MAX MIN DISPLAY
    line = advpanel:addLine("Telemetry filtering")
    form.addChoiceField(line, nil, {{"LOW", 1}, {"MEDIUM", 2}, {"HIGH", 3}}, function()
        return neuronstatus.filteringParam
    end, function(newValue)
        neuronstatus.filteringParam = newValue
    end)

    -- LVannounce DISPLAY
    line = advpanel:addLine("Announcement interval")
    form.addChoiceField(line, nil, {
        {"5s", 5}, {"10s", 10}, {"15s", 15}, {"20s", 20}, {"25s", 25}, {"30s", 30}, {"35s", 35}, {"40s", 40}, {"45s", 45}, {"50s", 50}, {"55s", 55}, {"60s", 60}, {"No repeat", 50000}
    }, function()
        return neuronstatus.announceIntervalParam
    end, function(newValue)
        neuronstatus.announceIntervalParam = newValue
    end)

    neuronstatus.resetALL()

    return widget
end

function neuronstatus.getRssiSensor()
    if neuronstatus.environment.simulation then return 100 end

    local rssiNames = {"RSSI", "RSSI Int", "RSSI Ext", "RSSI 2.4G", "RSSI 900M", "Rx RSSI1", "Rx RSSI2"}
    for i, name in ipairs(rssiNames) do
        neuronstatus.rssiSensor = system.getSource(name)
        if neuronstatus.rssiSensor then return neuronstatus.rssiSensor end
    end
end

function neuronstatus.getRSSI()
    if neuronstatus.environment.simulation == true then return 100 end
    if neuronstatus.rssiSensor ~= nil and neuronstatus.rssiSensor:state() then return neuronstatus.rssiSensor:value() end
    return 0
end

function neuronstatus.screenError(msg)
    local w, h = lcd.getWindowSize()
    isDARKMODE = lcd.darkMode()
    lcd.font(FONT_STD)
    str = msg
    tsizeW, tsizeH = lcd.getTextSize(str)

    if isDARKMODE then
        -- dark theme
        lcd.color(lcd.RGB(255, 255, 255, 1))
    else
        -- light theme
        lcd.color(lcd.RGB(90, 90, 90))
    end
    lcd.drawText((w / 2) - tsizeW / 2, (h / 2) - tsizeH / 2, str)
    return
end

function neuronstatus.resetALL()
    neuronstatus.showLOGS = false
    neuronstatus.sensorVoltageMax = 0
    neuronstatus.sensorVoltageMin = 0
    neuronstatus.sensorFuelMin = 0
    neuronstatus.sensorFuelMax = 0
    neuronstatus.sensorRPMMin = 0
    neuronstatus.sensorRPMMax = 0
    neuronstatus.sensorCurrentMin = 0
    neuronstatus.sensorCurrentMax = 0
    neuronstatus.sensorTempESCMin = 0
    neuronstatus.sensorTempESCMax = 0
end

function neuronstatus.noTelem()

    lcd.font(FONT_STD)
    str = "NO DATA"

    local theme = neuronstatus.getThemeInfo()
    local w, h = lcd.getWindowSize()
    boxW = math.floor(w / 2)
    boxH = 45
    tsizeW, tsizeH = lcd.getTextSize(str)

    -- draw the backgneuronstatus.round
    if isDARKMODE then
        lcd.color(lcd.RGB(40, 40, 40))
    else
        lcd.color(lcd.RGB(240, 240, 240))
    end
    lcd.drawFilledRectangle(w / 2 - boxW / 2, h / 2 - boxH / 2, boxW, boxH)

    -- draw the border
    if isDARKMODE then
        -- dark theme
        lcd.color(lcd.RGB(255, 255, 255, 1))
    else
        -- light theme
        lcd.color(lcd.RGB(90, 90, 90))
    end
    lcd.drawRectangle(w / 2 - boxW / 2, h / 2 - boxH / 2, boxW, boxH)

    if isDARKMODE then
        -- dark theme
        lcd.color(lcd.RGB(255, 255, 255, 1))
    else
        -- light theme
        lcd.color(lcd.RGB(90, 90, 90))
    end
    lcd.drawText((w / 2) - tsizeW / 2, (h / 2) - tsizeH / 2, str)
    return
end

function neuronstatus.getThemeInfo()
    neuronstatus.environment = system.getVersion()
    local w, h = lcd.getWindowSize()

    -- this is just to force height calc to end up on whole numbers to avoid
    -- scaling issues
    h = (math.floor((h / 4)) * 4)
    w = (math.floor((w / 6)) * 6)

    if neuronstatus.environment.board == "XES" or neuronstatus.environment.board == "XE" or neuronstatus.environment.board == "X20" or neuronstatus.environment.board == "X20S" or
        neuronstatus.environment.board == "X20PRO" or neuronstatus.environment.board == "X20PROAW" or neuronstatus.environment.board == "X20R" or neuronstatus.environment.board == "X20RS" then
        ret = {
            supportedRADIO = true,
            colSpacing = 4,
            fullBoxW = 262,
            fullBoxH = h / 2,
            smallBoxSensortextOFFSET = -5,
            title_fm = "FLIGHT MODE",
            title_voltage = "VOLTAGE",
            title_fuel = "FUEL",
            title_rpm = "RPM",
            title_current = "CURRENT",
            title_mah = "MAH",
            title_tempESC = "ESC",
            title_time = "TIMER",
            title_rssi = "LQ",
            fontSENSOR = FONT_XXL,
            fontSENSORSmallBox = FONT_STD,
            fontTITLE = FONT_XS,
            fontPopupTitle = FONT_S,
            widgetTitleOffset = 20,
            logsCOL1w = 75,
            logsCOL2w = 135,
            logsCOL3w = 135,
            logsCOL4w = 185,
            logsCOL5w = 125,
            logsCOL6w = 105,
            logsHeaderOffset = 5

        }
    end

    if neuronstatus.environment.board == "X18" or neuronstatus.environment.board == "X18S" then
        ret = {
            supportedRADIO = true,
            colSpacing = 2,
            fullBoxW = 158,
            fullBoxH = 97,
            smallBoxSensortextOFFSET = -8,
            title_fm = "FLIGHT MODE",
            title_voltage = "VOLTAGE",
            title_fuel = "FUEL",
            title_rpm = "RPM",
            title_current = "CURRENT",
            title_mah = "MAH",
            title_tempESC = "ESC",
            title_time = "TIMER",
            title_rssi = "LQ",
            fontSENSOR = FONT_XXL,
            fontSENSORSmallBox = FONT_STD,
            fontTITLE = 768,
            fontPopupTitle = FONT_S,
            widgetTitleOffset = 20,
            logsCOL1w = 50,
            logsCOL2w = 100,
            logsCOL3w = 100,
            logsCOL4w = 140,
            logsCOL5w = 0,
            logsCOL6w = 0,
            logsCOL7w = 75,
            logsHeaderOffset = 5
        }
    end

    if neuronstatus.environment.board == "X14" or neuronstatus.environment.board == "X14S" then
        ret = {
            supportedRADIO = true,
            colSpacing = 3,
            fullBoxW = 210,
            fullBoxH = 120,
            smallBoxSensortextOFFSET = -10,
            title_fm = "FLIGHT MODE",
            title_voltage = "VOLTAGE",
            title_fuel = "FUEL",
            title_rpm = "RPM",
            title_current = "CURRENT",
            title_mah = "MAH",
            title_tempESC = "ESC",
            title_time = "TIMER",
            title_rssi = "LQ",
            fontSENSOR = FONT_XXL,
            fontSENSORSmallBox = FONT_STD,
            fontTITLE = 768,
            fontPopupTitle = FONT_S,
            widgetTitleOffset = 20,
            logsCOL1w = 70,
            logsCOL2w = 140,
            logsCOL3w = 120,
            logsCOL4w = 170,
            logsCOL5w = 0,
            logsCOL6w = 0,
            logsCOL7w = 120,
            logsHeaderOffset = 5
        }
    end

    if neuronstatus.environment.board == "TWXLITE" or neuronstatus.environment.board == "TWXLITES" then
        ret = {
            supportedRADIO = true,
            colSpacing = 2,
            fullBoxW = 158,
            fullBoxH = 96,
            smallBoxSensortextOFFSET = -10,
            title_fm = "FLIGHT MODE",
            title_voltage = "VOLTAGE",
            title_fuel = "FUEL",
            title_rpm = "RPM",
            title_mah = "MAH",
            title_current = "CURRENT",
            title_tempESC = "ESC",
            title_time = "TIMER",
            title_rssi = "LQ",
            fontSENSOR = FONT_XXL,
            fontSENSORSmallBox = FONT_STD,
            fontTITLE = 768,
            fontPopupTitle = FONT_S,
            widgetTitleOffset = 20,
            logsCOL1w = 50,
            logsCOL2w = 100,
            logsCOL3w = 100,
            logsCOL4w = 140,
            logsCOL5w = 0,
            logsCOL6w = 0,
            logsCOL7w = 75,
            logsHeaderOffset = 5
        }
    end

    if neuronstatus.environment.board == "X10EXPRESS" or neuronstatus.environment.board == "X10" or neuronstatus.environment.board == "X10S" or neuronstatus.environment.board == "X12" or
        neuronstatus.environment.board == "X12S" then
        ret = {
            supportedRADIO = true,
            colSpacing = 2,
            fullBoxW = 158,
            fullBoxH = 79,
            smallBoxSensortextOFFSET = -10,
            title_fm = "FLIGHT MODE",
            title_voltage = "VOLTAGE",
            title_fuel = "FUEL",
            title_rpm = "RPM",
            title_mah = "MAH",
            title_current = "CURRENT",
            title_tempESC = "ESC",
            title_time = "TIMER",
            title_rssi = "LQ",
            fontSENSOR = FONT_XXL,
            fontSENSORSmallBox = FONT_STD,
            fontTITLE = FONT_XS,
            fontPopupTitle = FONT_S,
            widgetTitleOffset = 20,
            logsCOL1w = 50,
            logsCOL2w = 100,
            logsCOL3w = 100,
            logsCOL4w = 140,
            logsCOL5w = 0,
            logsCOL6w = 0,
            logsCOL7w = 75,
            logsHeaderOffset = 5
        }
    end

    return ret
end

function neuronstatus.telemetryBox(x, y, w, h, title, value, unit, smallbox, alarm, minimum, maximum)

    isVisible = lcd.isVisible()
    isDARKMODE = lcd.darkMode()
    local theme = neuronstatus.getThemeInfo()

    if isDARKMODE then
        lcd.color(lcd.RGB(40, 40, 40))
    else
        lcd.color(lcd.RGB(240, 240, 240))
    end

    -- draw box backgneuronstatus.round	
    lcd.drawFilledRectangle(x, y, w, h)

    -- color	
    if isDARKMODE then
        lcd.color(lcd.RGB(255, 255, 255, 1))
    else
        lcd.color(lcd.RGB(90, 90, 90))
    end

    -- draw sensor text
    if value ~= nil then

        if smallbox == nil or smallbox == false then
            lcd.font(theme.fontSENSOR)
        else
            lcd.font(theme.fontSENSORSmallBox)
        end

        str = value .. unit

        if unit == "°" then
            tsizeW, tsizeH = lcd.getTextSize(value .. ".")
        else
            tsizeW, tsizeH = lcd.getTextSize(str)
        end

        sx = (x + w / 2) - (tsizeW / 2)
        if smallbox == nil or smallbox == false then
            sy = (y + h / 2) - (tsizeH / 2)
        else
            if neuronstatus.maxminParam == false and neuronstatus.titleParam == false then
                sy = (y + h / 2) - (tsizeH / 2)
            else
                sy = (y + h / 2) - (tsizeH / 2) + theme.smallBoxSensortextOFFSET
            end
        end

        if alarm == true then lcd.color(lcd.RGB(255, 0, 0, 1)) end

        lcd.drawText(sx, sy, str)

        if alarm == true then
            if isDARKMODE then
                lcd.color(lcd.RGB(255, 255, 255, 1))
            else
                lcd.color(lcd.RGB(90, 90, 90))
            end
        end

    end

    if title ~= nil and neuronstatus.titleParam == true then
        lcd.font(theme.fontTITLE)
        str = title
        tsizeW, tsizeH = lcd.getTextSize(str)

        sx = (x + w / 2) - (tsizeW / 2)
        sy = (y + h) - (tsizeH) - theme.colSpacing

        lcd.drawText(sx, sy, str)
    end

    if neuronstatus.maxminParam == true then

        if minimum ~= nil then

            lcd.font(theme.fontTITLE)

            if tostring(minimum) ~= "-" then lastMin = minimum end

            if tostring(minimum) == "-" then
                str = minimum
            else
                str = minimum .. unit
            end

            if unit == "°" then
                tsizeW, tsizeH = lcd.getTextSize(minimum .. ".")
            else
                tsizeW, tsizeH = lcd.getTextSize(str)
            end

            sx = (x + theme.colSpacing)
            sy = (y + h) - (tsizeH) - theme.colSpacing

            lcd.drawText(sx, sy, str)
        end

        if maximum ~= nil then
            lcd.font(theme.fontTITLE)

            if tostring(maximum) == "-" then
                str = maximum
            else
                str = maximum .. unit
            end
            if unit == "°" then
                tsizeW, tsizeH = lcd.getTextSize(maximum .. ".")
            else
                tsizeW, tsizeH = lcd.getTextSize(str)
            end

            sx = (x + w) - tsizeW - theme.colSpacing
            sy = (y + h) - (tsizeH) - theme.colSpacing

            lcd.drawText(sx, sy, str)
        end

    end

end

function neuronstatus.logsBOX()

    if neuronstatus.readLOGS == false then
        local history = neuronstatus.readHistory()
        neuronstatus.readLOGSlast = history
        neuronstatus.readLOGS = true
    else
        history = neuronstatus.readLOGSlast
    end

    local theme = neuronstatus.getThemeInfo()
    local w, h = lcd.getWindowSize()
    if w < 500 then
        boxW = w
    else
        boxW = w - math.floor((w * 2) / 100)
    end
    if h < 200 then
        boxH = h - 2
    else
        boxH = h - math.floor((h * 4) / 100)
    end

    -- draw the backgneuronstatus.round
    if isDARKMODE then
        lcd.color(lcd.RGB(40, 40, 40, 50))
    else
        lcd.color(lcd.RGB(240, 240, 240, 50))
    end
    lcd.drawFilledRectangle(w / 2 - boxW / 2, h / 2 - boxH / 2, boxW, boxH)

    -- draw the border
    lcd.color(lcd.RGB(248, 176, 56))
    lcd.drawRectangle(w / 2 - boxW / 2, h / 2 - boxH / 2, boxW, boxH)

    -- draw the title
    lcd.color(lcd.RGB(248, 176, 56))
    lcd.drawFilledRectangle(w / 2 - boxW / 2, h / 2 - boxH / 2, boxW, boxH / 9)

    if isDARKMODE then
        -- dark theme
        lcd.color(lcd.RGB(0, 0, 0, 1))
    else
        -- light theme
        lcd.color(lcd.RGB(255, 255, 255))
    end
    str = "Log History"
    lcd.font(theme.fontPopupTitle)
    tsizeW, tsizeH = lcd.getTextSize(str)

    boxTh = boxH / 9
    boxTy = h / 2 - boxH / 2
    boxTx = w / 2 - boxW / 2
    lcd.drawText((w / 2) - tsizeW / 2, boxTy + (boxTh / 2) - tsizeH / 2, str)

    -- close button
    lcd.drawBitmap(boxTx + boxW - boxTh, boxTy, neuronstatus.gfx_close, boxTh, boxTh)
    neuronstatus.closeButtonX = math.floor(boxTx + boxW - boxTh)
    neuronstatus.closeButtonY = math.floor(boxTy) + theme.widgetTitleOffset
    neuronstatus.closeButtonW = math.floor(boxTh)
    neuronstatus.closeButtonH = math.floor(boxTh)

    lcd.color(lcd.RGB(255, 255, 255))

    --[[ header column format 
		TIME VOLTAGE AMPS RPM LQ MCU ESC
	]] --
    colW = boxW / 7

    col1x = boxTx
    col2x = boxTx + theme.logsCOL1w
    col3x = boxTx + theme.logsCOL1w + theme.logsCOL2w
    col4x = boxTx + theme.logsCOL1w + theme.logsCOL2w + theme.logsCOL3w
    col5x = boxTx + theme.logsCOL1w + theme.logsCOL2w + theme.logsCOL3w + theme.logsCOL4w
    col6x = boxTx + theme.logsCOL1w + theme.logsCOL2w + theme.logsCOL3w + theme.logsCOL4w + theme.logsCOL5w

    lcd.color(lcd.RGB(90, 90, 90))

    -- LINES
    lcd.drawLine(boxTx + boxTh / 2, boxTy + (boxTh * 2), boxTx + boxW - (boxTh / 2), boxTy + (boxTh * 2))

    lcd.drawLine(col2x, boxTy + boxTh + boxTh / 2, col2x, boxTy + boxH - (boxTh / 2))
    lcd.drawLine(col3x, boxTy + boxTh + boxTh / 2, col3x, boxTy + boxH - (boxTh / 2))
    lcd.drawLine(col4x, boxTy + boxTh + boxTh / 2, col4x, boxTy + boxH - (boxTh / 2))
    lcd.drawLine(col5x, boxTy + boxTh + boxTh / 2, col5x, boxTy + boxH - (boxTh / 2))
    lcd.drawLine(col6x, boxTy + boxTh + boxTh / 2, col6x, boxTy + boxH - (boxTh / 2))

    -- HEADER text
    if isDARKMODE then
        -- dark theme
        lcd.color(lcd.RGB(255, 255, 255, 1))
    else
        -- light theme
        lcd.color(lcd.RGB(0, 0, 0))
    end
    lcd.font(theme.fontPopupTitle)

    if theme.logsCOL1w ~= 0 then
        str = "TIME"
        tsizeW, tsizeH = lcd.getTextSize(str)
        lcd.drawText(col1x + (theme.logsCOL1w / 2) - (tsizeW / 2), theme.logsHeaderOffset + (boxTy + boxTh) + ((boxTh / 2) - (tsizeH / 2)), str)
    end

    if theme.logsCOL2w ~= 0 then
        str = "VOLTAGE"
        tsizeW, tsizeH = lcd.getTextSize(str)
        lcd.drawText((col2x) + (theme.logsCOL2w / 2) - (tsizeW / 2), theme.logsHeaderOffset + (boxTy + boxTh) + (boxTh / 2) - (tsizeH / 2), str)
    end

    if theme.logsCOL3w ~= 0 then
        str = "AMPS"
        tsizeW, tsizeH = lcd.getTextSize(str)
        lcd.drawText((col3x) + (theme.logsCOL3w / 2) - (tsizeW / 2), theme.logsHeaderOffset + (boxTy + boxTh) + (boxTh / 2) - (tsizeH / 2), str)
    end

    if theme.logsCOL4w ~= 0 then
        str = "RPM"
        tsizeW, tsizeH = lcd.getTextSize(str)
        lcd.drawText((col4x) + (theme.logsCOL4w / 2) - (tsizeW / 2), theme.logsHeaderOffset + (boxTy + boxTh) + (boxTh / 2) - (tsizeH / 2), str)
    end

    if theme.logsCOL5w ~= 0 then
        str = "LQ"
        tsizeW, tsizeH = lcd.getTextSize(str)
        lcd.drawText((col5x) + (theme.logsCOL5w / 2) - (tsizeW / 2), theme.logsHeaderOffset + (boxTy + boxTh) + (boxTh / 2) - (tsizeH / 2), str)
    end

    if theme.logsCOL6w ~= 0 then
        str = "ESC"
        tsizeW, tsizeH = lcd.getTextSize(str)
        lcd.drawText((col6x) + (theme.logsCOL6w / 2) - (tsizeW / 2), theme.logsHeaderOffset + (boxTy + boxTh) + (boxTh / 2) - (tsizeH / 2), str)
    end

    c = 0

    if history ~= nil then
        for index, value in ipairs(history) do

            if value ~= nil then
                if value ~= "" and value ~= nil then
                    rowH = c * boxTh

                    local rowData = neuronstatus.explode(value, ",")

                    --[[ rowData is a csv string as follows
				
						theTIME,neuronstatus.sensorVoltageMin,neuronstatus.sensorVoltageMax,neuronstatus.sensorFuelMin,neuronstatus.sensorFuelMax,
						neuronstatus.sensorRPMMin,neuronstatus.sensorRPMMax,neuronstatus.sensorCurrentMin,neuronstatus.sensorCurrentMax,neuronstatus.sensorRSSIMin,
						neuronstatus.sensorRSSIMax,sensorTempMCUMin,sensorTempMCUMax,neuronstatus.sensorTempESCMin,neuronstatus.sensorTempESCMax	
				]] --
                    -- loop of rowData and extract each value bases on idx
                    if rowData ~= nil then

                        for idx, snsr in pairs(rowData) do

                            snsr = snsr:gsub("%s+", "")

                            if snsr ~= nil and snsr ~= "" then
                                -- time
                                if idx == 1 and theme.logsCOL1w ~= 0 then
                                    str = neuronstatus.SecondsToClockAlt(snsr)
                                    tsizeW, tsizeH = lcd.getTextSize(str)
                                    lcd.drawText(col1x + (theme.logsCOL1w / 2) - (tsizeW / 2), boxTy + tsizeH / 2 + (boxTh * 2) + rowH, str)
                                end
                                -- voltagemin
                                if idx == 2 then vstr = snsr end
                                -- voltagemax
                                if idx == 3 and theme.logsCOL2w ~= 0 then
                                    str = neuronstatus.round(vstr / 100, 1) .. 'v / ' .. neuronstatus.round(snsr / 100, 1) .. 'v'
                                    tsizeW, tsizeH = lcd.getTextSize(str)
                                    lcd.drawText(col2x + (theme.logsCOL2w / 2) - (tsizeW / 2), boxTy + tsizeH / 2 + (boxTh * 2) + rowH, str)
                                end
                                -- fuelmin
                                if idx == 4 then local logFUELmin = snsr end
                                -- fuelmax
                                if idx == 5 then local logFUELmax = snsr end
                                -- rpmmin
                                if idx == 6 then rstr = snsr end
                                -- rpmmax
                                if idx == 7 and theme.logsCOL4w ~= 0 then
                                    str = rstr .. 'rpm / ' .. snsr .. 'rpm'
                                    tsizeW, tsizeH = lcd.getTextSize(str)
                                    lcd.drawText(col4x + (theme.logsCOL4w / 2) - (tsizeW / 2), boxTy + tsizeH / 2 + (boxTh * 2) + rowH, str)
                                end
                                -- currentmin
                                if idx == 8 then cstr = snsr end
                                -- currentmax
                                if idx == 9 and theme.logsCOL3w ~= 0 then
                                    str = neuronstatus.round(cstr / 10, 1) .. 'A / ' .. neuronstatus.round(snsr / 10, 1) .. 'A'
                                    tsizeW, tsizeH = lcd.getTextSize(str)
                                    lcd.drawText(col3x + (theme.logsCOL3w / 2) - (tsizeW / 2), boxTy + tsizeH / 2 + (boxTh * 2) + rowH, str)
                                end
                                -- rssimin
                                if idx == 10 then lqstr = snsr end
                                -- rssimax
                                if idx == 11 and theme.logsCOL5w ~= 0 then
                                    str = lqstr .. '% / ' .. snsr .. '%'
                                    tsizeW, tsizeH = lcd.getTextSize(str)
                                    lcd.drawText(col5x + (theme.logsCOL5w / 2) - (tsizeW / 2), boxTy + tsizeH / 2 + (boxTh * 2) + rowH, str)
                                end
                                -- escmin
                                if idx == 12 then escstr = snsr end
                                -- escmax
                                if idx == 13 and theme.logsCOL6w ~= 0 then
                                    str = neuronstatus.round(escstr / 100, 0) .. '° / ' .. neuronstatus.round(snsr / 100, 0) .. '°'
                                    strf = neuronstatus.round(escstr / 100, 0) .. '. / ' .. neuronstatus.round(snsr / 100, 0) .. '.'
                                    tsizeW, tsizeH = lcd.getTextSize(strf)
                                    lcd.drawText(col6x + (theme.logsCOL6w / 2) - (tsizeW / 2), boxTy + tsizeH / 2 + (boxTh * 2) + rowH, str)
                                end
                            end
                            -- end loop of each storage line		
                        end
                        c = c + 1

                        if h < 200 then
                            if c > 5 then break end
                        else
                            if c > 6 then break end
                        end
                        -- end of each log storage slot
                    end
                end
            end
        end
    end
    -- lcd.drawText((w / 2) - tsizeW / 2, (h / 2) - tsizeH / 2, str)
    return
end

function neuronstatus.telemetryBoxImage(x, y, w, h, gfx)

    isVisible = lcd.isVisible()
    isDARKMODE = lcd.darkMode()
    local theme = neuronstatus.getThemeInfo()

    if isDARKMODE then
        lcd.color(lcd.RGB(40, 40, 40))
    else
        lcd.color(lcd.RGB(240, 240, 240))
    end

    -- draw box backgneuronstatus.round	
    lcd.drawFilledRectangle(x, y, w, h)

    lcd.drawBitmap(x, y, gfx, w - theme.colSpacing, h - theme.colSpacing)

end

function neuronstatus.paint(widget)

    isVisible = lcd.isVisible()
    isDARKMODE = lcd.darkMode()

    neuronstatus.isInConfiguration = false

    -- voltage detection
    if neuronstatus.btypeParam ~= nil then
        if neuronstatus.btypeParam == 0 then
            -- LiPo
            cellVoltage = 3.6
        elseif neuronstatus.btypeParam == 1 then
            -- LiHv
            cellVoltage = 3.6
        elseif neuronstatus.btypeParam == 2 then
            -- Lion
            cellVoltage = 3
        elseif neuronstatus.btypeParam == 3 then
            -- LiFe
            cellVoltage = 2.9
        elseif neuronstatus.btypeParam == 4 then
            -- NiMh
            cellVoltage = 1.1
        else
            -- LiPo (default)
            cellVoltage = 3.6
        end

        if neuronstatus.sensors.voltage ~= nil then
            -- we use neuronstatus.lowvoltagsenseParam is use to raise or lower sensitivity
            if neuronstatus.lowvoltagsenseParam == 1 then
                zippo = 0.2
            elseif neuronstatus.lowvoltagsenseParam == 2 then
                zippo = 0.1
            else
                zippo = 0
            end
            if neuronstatus.sensors.voltage / 100 < ((cellVoltage * neuronstatus.cellsParam) + zippo) then
                neuronstatus.voltageIsLow = true
            else
                neuronstatus.voltageIsLow = false
            end
        else
            neuronstatus.voltageIsLow = false
        end
    end

    -- fuel detection
    if neuronstatus.sensors.voltage ~= nil then
        if neuronstatus.sensors.fuel < neuronstatus.lowfuelParam then
            neuronstatus.fuelIsLow = true
        else
            neuronstatus.fuelIsLow = false
        end
    else
        neuronstatus.fuelIsLow = false
    end

    -- -----------------------------------------------------------------------------------------------
    -- write values to boxes
    -- -----------------------------------------------------------------------------------------------

    local theme = neuronstatus.getThemeInfo()
    local w, h = lcd.getWindowSize()

    if isVisible then
        -- blank out display
        if isDARKMODE then
            -- dark theme
            lcd.color(lcd.RGB(16, 16, 16))
        else
            -- light theme
            lcd.color(lcd.RGB(209, 208, 208))
        end
        lcd.drawFilledRectangle(0, 0, w, h)

        -- hard error
        if theme.supportedRADIO ~= true then
            neuronstatus.screenError("UNKNOWN " .. neuronstatus.environment.board)
            return
        end

        -- widget size
        if neuronstatus.environment.board == "V20" or neuronstatus.environment.board == "XES" or neuronstatus.environment.board == "X20" or neuronstatus.environment.board == "X20S" or
            neuronstatus.environment.board == "X20PRO" or neuronstatus.environment.board == "X20PROAW" then
            if w ~= 784 and h ~= 294 then
                neuronstatus.screenError("DISPLAY SIZE INVALID")
                return
            end
        end
        if neuronstatus.environment.board == "X18" or neuronstatus.environment.board == "X18S" then
            smallTEXT = true
            if w ~= 472 and h ~= 191 then
                neuronstatus.screenError("DISPLAY SIZE INVALID")
                return
            end
        end
        if neuronstatus.environment.board == "X14" or neuronstatus.environment.board == "X14S" then
            if w ~= 630 and h ~= 236 then
                neuronstatus.screenError("DISPLAY SIZE INVALID")
                return
            end
        end
        if neuronstatus.environment.board == "TWXLITE" or neuronstatus.environment.board == "TWXLITES" then
            if w ~= 472 and h ~= 191 then
                neuronstatus.screenError("DISPLAY SIZE INVALID")
                return
            end
        end
        if neuronstatus.environment.board == "X10EXPRESS" or neuronstatus.environment.board == "X10" or neuronstatus.environment.board == "X10S" or neuronstatus.environment.board == "X12" or
            neuronstatus.environment.board == "X12S" then
            if w ~= 472 and h ~= 158 then
                neuronstatus.screenError("DISPLAY SIZE INVALID")
                return
            end
        end

        boxW = theme.fullBoxW - theme.colSpacing
        boxH = theme.fullBoxH - theme.colSpacing

        boxHs = theme.fullBoxH / 2 - theme.colSpacing
        boxWs = theme.fullBoxW / 2 - theme.colSpacing

        -- FUEL
        if neuronstatus.sensors.fuel ~= nil then

            sensorUNIT = "%"
            sensorWARN = false
            smallBOX = false

            if neuronstatus.fuelIsLow then sensorWARN = true end

            sensorVALUE = neuronstatus.sensors.fuel

            if neuronstatus.sensors.fuel < 5 then sensorVALUE = "0" end

            if neuronstatus.titleParam == true then
                sensorTITLE = "FUEL"
            else
                sensorTITLE = ""
            end

            if neuronstatus.sensorFuelMin == 0 or neuronstatus.sensorFuelMin == nil or theTIME == 0 then
                sensorMIN = "-"
            else
                sensorMIN = neuronstatus.sensorFuelMin
            end

            if neuronstatus.sensorFuelMax == 0 or neuronstatus.sensorFuelMax == nil or theTIME == 0 then
                sensorMAX = "-"
            else
                sensorMAX = neuronstatus.sensorFuelMax
            end

            local sensorTGT = 'fuel'
            neuronstatus.sensordisplay[sensorTGT] = {}
            neuronstatus.sensordisplay[sensorTGT]['title'] = sensorTITLE
            neuronstatus.sensordisplay[sensorTGT]['value'] = sensorVALUE
            neuronstatus.sensordisplay[sensorTGT]['warn'] = sensorWARN
            neuronstatus.sensordisplay[sensorTGT]['min'] = sensorMIN
            neuronstatus.sensordisplay[sensorTGT]['max'] = sensorMAX
            neuronstatus.sensordisplay[sensorTGT]['unit'] = sensorUNIT
        end

        -- GOV MODE
        sensorUNIT = ""
        sensorWARN = false
        smallBOX = true
        sensorMIN = nil
        sensorMAX = nil

        str = neuronstatus.sensors.fm
        sensorTITLE = theme.title_fm

        sensorVALUE = str

        if neuronstatus.titleParam ~= true then sensorTITLE = "" end

        local sensorTGT = 'governor'
        neuronstatus.sensordisplay[sensorTGT] = {}
        neuronstatus.sensordisplay[sensorTGT]['title'] = sensorTITLE
        neuronstatus.sensordisplay[sensorTGT]['value'] = sensorVALUE
        neuronstatus.sensordisplay[sensorTGT]['warn'] = sensorWARN
        neuronstatus.sensordisplay[sensorTGT]['min'] = sensorMIN
        neuronstatus.sensordisplay[sensorTGT]['max'] = sensorMAX
        neuronstatus.sensordisplay[sensorTGT]['unit'] = sensorUNIT

        -- RPM
        if neuronstatus.sensors.rpm ~= nil then

            posX = boxW + theme.colSpacing + boxW + theme.colSpacing
            posY = boxH + (theme.colSpacing * 2)
            sensorUNIT = "rpm"
            sensorWARN = false
            smallBOX = false

            sensorVALUE = neuronstatus.sensors.rpm

            if neuronstatus.sensors.rpm < 5 then sensorVALUE = 0 end

            if neuronstatus.titleParam == true then
                sensorTITLE = theme.title_rpm
            else
                sensorTITLE = ""
            end

            if neuronstatus.sensorRPMMin == 0 or neuronstatus.sensorRPMMin == nil or theTIME == 0 then
                sensorMIN = "-"
            else
                sensorMIN = neuronstatus.sensorRPMMin
            end

            if neuronstatus.sensorRPMMax == 0 or neuronstatus.sensorRPMMax == nil or theTIME == 0 then
                sensorMAX = "-"
            else
                sensorMAX = neuronstatus.sensorRPMMax
            end

            local sensorTGT = 'rpm'
            neuronstatus.sensordisplay[sensorTGT] = {}
            neuronstatus.sensordisplay[sensorTGT]['title'] = sensorTITLE
            neuronstatus.sensordisplay[sensorTGT]['value'] = sensorVALUE
            neuronstatus.sensordisplay[sensorTGT]['warn'] = sensorWARN
            neuronstatus.sensordisplay[sensorTGT]['min'] = sensorMIN
            neuronstatus.sensordisplay[sensorTGT]['max'] = sensorMAX
            neuronstatus.sensordisplay[sensorTGT]['unit'] = sensorUNIT
        end

        -- VOLTAGE
        if neuronstatus.sensors.voltage ~= nil then

            sensorUNIT = "v"
            sensorWARN = false
            smallBOX = false

            if neuronstatus.voltageIsLow then sensorWARN = true end

            sensorVALUE = neuronstatus.sensors.voltage / 100

            if sensorVALUE < 1 then sensorVALUE = 0 end

            if neuronstatus.titleParam == true then
                sensorTITLE = theme.title_voltage
            else
                sensorTITLE = ""
            end

            if neuronstatus.sensorVoltageMin == 0 or neuronstatus.sensorVoltageMin == nil or theTIME == 0 then
                sensorMIN = "-"
            else
                sensorMIN = neuronstatus.sensorVoltageMin / 100
            end

            if neuronstatus.sensorVoltageMax == 0 or neuronstatus.sensorVoltageMax == nil or theTIME == 0 then
                sensorMAX = "-"
            else
                sensorMAX = neuronstatus.sensorVoltageMax / 100
            end

            local sensorTGT = 'voltage'
            neuronstatus.sensordisplay[sensorTGT] = {}
            neuronstatus.sensordisplay[sensorTGT]['title'] = sensorTITLE
            neuronstatus.sensordisplay[sensorTGT]['value'] = sensorVALUE
            neuronstatus.sensordisplay[sensorTGT]['warn'] = sensorWARN
            neuronstatus.sensordisplay[sensorTGT]['min'] = sensorMIN
            neuronstatus.sensordisplay[sensorTGT]['max'] = sensorMAX
            neuronstatus.sensordisplay[sensorTGT]['unit'] = sensorUNIT
        end

        -- CURRENT
        if neuronstatus.sensors.current ~= nil then

            sensorUNIT = "A"
            sensorWARN = false
            smallBOX = false

            sensorVALUE = neuronstatus.sensors.current / 10
            if neuronstatus.linkUP == 0 then
                sensorVALUE = 0
            else
                if sensorVALUE == 0 then
                    local fakeC
                    if neuronstatus.sensors.rpm > 5 then
                        fakeC = 1
                    elseif neuronstatus.sensors.rpm > 50 then
                        fakeC = 2
                    elseif neuronstatus.sensors.rpm > 100 then
                        fakeC = 3
                    elseif neuronstatus.sensors.rpm > 200 then
                        fakeC = 4
                    elseif neuronstatus.sensors.rpm > 500 then
                        fakeC = 5
                    elseif neuronstatus.sensors.rpm > 1000 then
                        fakeC = 6
                    else
                        fakeC = math.random(1, 3) / 10
                    end
                    sensorVALUE = fakeC
                end
            end

            if neuronstatus.titleParam == true then
                sensorTITLE = theme.title_current
            else
                sensorTITLE = ""
            end

            if neuronstatus.sensorCurrentMin == 0 or neuronstatus.sensorCurrentMin == nil or theTIME == 0 then
                sensorMIN = "-"
            else
                sensorMIN = neuronstatus.sensorCurrentMin / 10
            end

            if neuronstatus.sensorCurrentMax == 0 or neuronstatus.sensorCurrentMax == nil or theTIME == 0 then
                sensorMAX = "-"
            else
                sensorMAX = neuronstatus.sensorCurrentMax / 10
            end

            local sensorTGT = 'current'
            neuronstatus.sensordisplay[sensorTGT] = {}
            neuronstatus.sensordisplay[sensorTGT]['title'] = sensorTITLE
            neuronstatus.sensordisplay[sensorTGT]['value'] = sensorVALUE
            neuronstatus.sensordisplay[sensorTGT]['warn'] = sensorWARN
            neuronstatus.sensordisplay[sensorTGT]['min'] = sensorMIN
            neuronstatus.sensordisplay[sensorTGT]['max'] = sensorMAX
            neuronstatus.sensordisplay[sensorTGT]['unit'] = sensorUNIT
        end

        -- TEMP ESC
        if neuronstatus.sensors.temp_esc ~= nil and neuronstatus.miniBoxParam == 0 then

            sensorUNIT = "°"
            sensorWARN = false
            smallBOX = true

            sensorVALUE = neuronstatus.round(neuronstatus.sensors.temp_esc / 100, 0)

            if sensorVALUE < 1 then sensorVALUE = 0 end

            if neuronstatus.titleParam == true then
                sensorTITLE = theme.title_tempESC
            else
                sensorTITLE = ""
            end

            if neuronstatus.sensorTempESCMin == 0 or neuronstatus.sensorTempESCMin == nil or theTIME == 0 then
                sensorMIN = "-"
            else
                sensorMIN = neuronstatus.round(neuronstatus.sensorTempESCMin / 100, 0)
            end

            if neuronstatus.sensorTempESCMax == 0 or neuronstatus.sensorTempESCMax == nil or theTIME == 0 then
                sensorMAX = "-"
            else
                sensorMAX = neuronstatus.round(neuronstatus.sensorTempESCMax / 100, 0)
            end

            local sensorTGT = 'temp_esc'
            neuronstatus.sensordisplay[sensorTGT] = {}
            neuronstatus.sensordisplay[sensorTGT]['title'] = sensorTITLE
            neuronstatus.sensordisplay[sensorTGT]['value'] = sensorVALUE
            neuronstatus.sensordisplay[sensorTGT]['warn'] = sensorWARN
            neuronstatus.sensordisplay[sensorTGT]['min'] = sensorMIN
            neuronstatus.sensordisplay[sensorTGT]['max'] = sensorMAX
            neuronstatus.sensordisplay[sensorTGT]['unit'] = sensorUNIT
        end

        -- RSSI
        if neuronstatus.sensors.rssi ~= nil then

            sensorUNIT = "%"
            sensorWARN = false
            smallBOX = true
            thisBoxW = boxWs
            thisBoxH = boxHs

            sensorVALUE = neuronstatus.sensors.rssi

            if sensorVALUE < 1 then sensorVALUE = 0 end

            if neuronstatus.titleParam == true then
                sensorTITLE = theme.title_rssi
            else
                sensorTITLE = ""
            end

            if neuronstatus.sensorRSSIMin == 0 or neuronstatus.sensorRSSIMin == nil or theTIME == 0 then
                sensorMIN = "-"
            else
                sensorMIN = neuronstatus.sensorRSSIMin
            end

            if neuronstatus.sensorRSSIMax == 0 or neuronstatus.sensorRSSIMax == nil or theTIME == 0 then
                sensorMAX = "-"
            else
                sensorMAX = neuronstatus.sensorRSSIMax
            end

            local sensorTGT = 'rssi'
            neuronstatus.sensordisplay[sensorTGT] = {}
            neuronstatus.sensordisplay[sensorTGT]['title'] = sensorTITLE
            neuronstatus.sensordisplay[sensorTGT]['value'] = sensorVALUE
            neuronstatus.sensordisplay[sensorTGT]['warn'] = sensorWARN
            neuronstatus.sensordisplay[sensorTGT]['min'] = sensorMIN
            neuronstatus.sensordisplay[sensorTGT]['max'] = sensorMAX
            neuronstatus.sensordisplay[sensorTGT]['unit'] = sensorUNIT
        end

        -- mah
        if neuronstatus.sensors.mah ~= nil then

            sensorVALUE = neuronstatus.sensors.mah

            if sensorVALUE < 1 then sensorVALUE = 0 end

            if neuronstatus.titleParam == true then
                sensorTITLE = theme.title_mah
            else
                sensorTITLE = ""
            end

            if sensorMAHMin == 0 or sensorMAHMin == nil then
                sensorMIN = "-"
            else
                sensorMIN = sensorMAHMin
            end

            if sensorMAHMax == 0 or sensorMAHMax == nil then
                sensorMAX = "-"
            else
                sensorMAX = sensorMAHMax
            end

            sensorUNIT = ""
            sensorWARN = false

            local sensorTGT = 'mah'
            neuronstatus.sensordisplay[sensorTGT] = {}
            neuronstatus.sensordisplay[sensorTGT]['title'] = sensorTITLE
            neuronstatus.sensordisplay[sensorTGT]['value'] = sensorVALUE
            neuronstatus.sensordisplay[sensorTGT]['warn'] = sensorWARN
            neuronstatus.sensordisplay[sensorTGT]['min'] = sensorMIN
            neuronstatus.sensordisplay[sensorTGT]['max'] = sensorMAX
            neuronstatus.sensordisplay[sensorTGT]['unit'] = sensorUNIT
        end

        -- TIMER

        posX = 0
        posY = boxH + (theme.colSpacing * 2)
        sensorUNIT = ""
        sensorWARN = false
        smallBOX = true
        thisBoxW = boxW
        thisBoxH = boxHs

        sensorMIN = nil
        sensorMAX = nil

        if theTIME ~= nil or theTIME == 0 then
            str = neuronstatus.SecondsToClock(theTIME)
        else
            str = "00:00:00"
        end

        if neuronstatus.titleParam == true then
            sensorTITLE = theme.title_time
        else
            sensorTITLE = ""
        end

        sensorVALUE = str

        local sensorTGT = 'timer'
        neuronstatus.sensordisplay[sensorTGT] = {}
        neuronstatus.sensordisplay[sensorTGT]['title'] = sensorTITLE
        neuronstatus.sensordisplay[sensorTGT]['value'] = sensorVALUE
        neuronstatus.sensordisplay[sensorTGT]['warn'] = sensorWARN
        neuronstatus.sensordisplay[sensorTGT]['min'] = sensorMIN
        neuronstatus.sensordisplay[sensorTGT]['max'] = sensorMAX
        neuronstatus.sensordisplay[sensorTGT]['unit'] = sensorUNIT

        -- loop throught 6 box and link into neuronstatus.sensordisplay to choose where to put things
        local c = 1
        while c <= 6 do

            -- reset all values
            sensorVALUE = nil
            sensorUNIT = nil
            sensorMIN = nil
            sensorMAX = nil
            sensorWARN = nil
            sensorTITLE = nil
            sensorTGT = nil
            smallBOX = false

            -- column positions and tgt
            if c == 1 then
                posX = 0
                posY = theme.colSpacing
                sensorTGT = neuronstatus.layoutBox1Param
            end
            if c == 2 then
                posX = 0 + theme.colSpacing + boxW
                posY = theme.colSpacing
                sensorTGT = neuronstatus.layoutBox2Param
            end
            if c == 3 then
                posX = 0 + theme.colSpacing + boxW + theme.colSpacing + boxW
                posY = theme.colSpacing
                sensorTGT = neuronstatus.layoutBox3Param
            end
            if c == 4 then
                posX = 0
                posY = theme.colSpacing + boxH + theme.colSpacing
                sensorTGT = neuronstatus.layoutBox4Param
            end
            if c == 5 then
                posX = 0 + theme.colSpacing + boxW
                posY = theme.colSpacing + boxH + theme.colSpacing
                sensorTGT = neuronstatus.layoutBox5Param
            end
            if c == 6 then
                posX = 0 + theme.colSpacing + boxW + theme.colSpacing + boxW
                posY = theme.colSpacing + boxH + theme.colSpacing
                sensorTGT = neuronstatus.layoutBox6Param
            end

            -- remap sensorTGT
            if sensorTGT == 1 then sensorTGT = 'timer' end
            if sensorTGT == 2 then sensorTGT = 'voltage' end
            if sensorTGT == 3 then sensorTGT = 'fuel' end
            if sensorTGT == 4 then sensorTGT = 'current' end
            if sensorTGT == 5 then sensorTGT = 'mah' end
            if sensorTGT == 6 then sensorTGT = 'rpm' end
            if sensorTGT == 7 then sensorTGT = 'rssi' end
            if sensorTGT == 9 then sensorTGT = 'temp_esc' end
            if sensorTGT == 10 then sensorTGT = 'temp_mcu' end
            if sensorTGT == 11 then sensorTGT = 'image__gov' end
            if sensorTGT == 12 then sensorTGT = 'voltage__fuel' end
            if sensorTGT == 13 then sensorTGT = 'voltage__current' end
            if sensorTGT == 14 then sensorTGT = 'voltage__mah' end
            if sensorTGT == 15 then sensorTGT = 'timer__t_esc__rssi' end

            -- set sensor values based on sensorTGT
            if neuronstatus.sensordisplay[sensorTGT] ~= nil then
                -- all std values.  =
                sensorVALUE = neuronstatus.sensordisplay[sensorTGT]['value']
                sensorUNIT = neuronstatus.sensordisplay[sensorTGT]['unit']
                sensorMIN = neuronstatus.sensordisplay[sensorTGT]['min']
                sensorMAX = neuronstatus.sensordisplay[sensorTGT]['max']
                sensorWARN = neuronstatus.sensordisplay[sensorTGT]['warn']
                sensorTITLE = neuronstatus.sensordisplay[sensorTGT]['title']
                neuronstatus.telemetryBox(posX, posY, boxW, boxH, sensorTITLE, sensorVALUE, sensorUNIT, smallBOX, sensorWARN, sensorMIN, sensorMAX)
            else

                if sensorTGT == 'image' then
                    -- IMAGE
                    if neuronstatus.gfx_model ~= nil then
                        neuronstatus.telemetryBoxImage(posX, posY, boxW, boxH, neuronstatus.gfx_model)
                    else
                        neuronstatus.telemetryBoxImage(posX, posY, boxW, boxH, neuronstatus.gfx_default)
                    end
                end

                if sensorTGT == 'image__gov' then
                    -- IMAGE + GOVERNOR
                    if neuronstatus.gfx_model ~= nil then
                        neuronstatus.telemetryBoxImage(posX, posY, boxW, boxH / 2 - (theme.colSpacing / 2), neuronstatus.gfx_model)
                    else
                        neuronstatus.telemetryBoxImage(posX, posY, boxW, boxH / 2 - (theme.colSpacing / 2), neuronstatus.gfx_default)
                    end

                    sensorTGT = "governor"
                    sensorVALUE = neuronstatus.sensordisplay[sensorTGT]['value']
                    sensorUNIT = neuronstatus.sensordisplay[sensorTGT]['unit']
                    sensorMIN = neuronstatus.sensordisplay[sensorTGT]['min']
                    sensorMAX = neuronstatus.sensordisplay[sensorTGT]['max']
                    sensorWARN = neuronstatus.sensordisplay[sensorTGT]['warn']
                    sensorTITLE = neuronstatus.sensordisplay[sensorTGT]['title']

                    smallBOX = true
                    neuronstatus.telemetryBox(posX, posY + boxH / 2 + (theme.colSpacing / 2), boxW, boxH / 2 - theme.colSpacing / 2, sensorTITLE, sensorVALUE, sensorUNIT, smallBOX, sensorWARN,
                                              sensorMIN, sensorMAX)

                end

                if sensorTGT == 'voltage__fuel' then

                    sensorTGT = "voltage"
                    sensorVALUE = neuronstatus.sensordisplay[sensorTGT]['value']
                    sensorUNIT = neuronstatus.sensordisplay[sensorTGT]['unit']
                    sensorMIN = neuronstatus.sensordisplay[sensorTGT]['min']
                    sensorMAX = neuronstatus.sensordisplay[sensorTGT]['max']
                    sensorWARN = neuronstatus.sensordisplay[sensorTGT]['warn']
                    sensorTITLE = neuronstatus.sensordisplay[sensorTGT]['title']

                    smallBOX = true
                    neuronstatus.telemetryBox(posX, posY, boxW, boxH / 2 - (theme.colSpacing / 2), sensorTITLE, sensorVALUE, sensorUNIT, smallBOX, sensorWARN, sensorMIN, sensorMAX)

                    sensorTGT = "fuel"
                    sensorVALUE = neuronstatus.sensordisplay[sensorTGT]['value']
                    sensorUNIT = neuronstatus.sensordisplay[sensorTGT]['unit']
                    sensorMIN = neuronstatus.sensordisplay[sensorTGT]['min']
                    sensorMAX = neuronstatus.sensordisplay[sensorTGT]['max']
                    sensorWARN = neuronstatus.sensordisplay[sensorTGT]['warn']
                    sensorTITLE = neuronstatus.sensordisplay[sensorTGT]['title']

                    smallBOX = true
                    neuronstatus.telemetryBox(posX, posY + boxH / 2 + (theme.colSpacing / 2), boxW, boxH / 2 - theme.colSpacing / 2, sensorTITLE, sensorVALUE, sensorUNIT, smallBOX, sensorWARN,
                                              sensorMIN, sensorMAX)

                end

                if sensorTGT == 'voltage__current' then

                    sensorTGT = "voltage"
                    sensorVALUE = neuronstatus.sensordisplay[sensorTGT]['value']
                    sensorUNIT = neuronstatus.sensordisplay[sensorTGT]['unit']
                    sensorMIN = neuronstatus.sensordisplay[sensorTGT]['min']
                    sensorMAX = neuronstatus.sensordisplay[sensorTGT]['max']
                    sensorWARN = neuronstatus.sensordisplay[sensorTGT]['warn']
                    sensorTITLE = neuronstatus.sensordisplay[sensorTGT]['title']

                    smallBOX = true
                    neuronstatus.telemetryBox(posX, posY, boxW, boxH / 2 - (theme.colSpacing / 2), sensorTITLE, sensorVALUE, sensorUNIT, smallBOX, sensorWARN, sensorMIN, sensorMAX)

                    sensorTGT = "current"
                    sensorVALUE = neuronstatus.sensordisplay[sensorTGT]['value']
                    sensorUNIT = neuronstatus.sensordisplay[sensorTGT]['unit']
                    sensorMIN = neuronstatus.sensordisplay[sensorTGT]['min']
                    sensorMAX = neuronstatus.sensordisplay[sensorTGT]['max']
                    sensorWARN = neuronstatus.sensordisplay[sensorTGT]['warn']
                    sensorTITLE = neuronstatus.sensordisplay[sensorTGT]['title']

                    smallBOX = true
                    neuronstatus.telemetryBox(posX, posY + boxH / 2 + (theme.colSpacing / 2), boxW, boxH / 2 - theme.colSpacing / 2, sensorTITLE, sensorVALUE, sensorUNIT, smallBOX, sensorWARN,
                                              sensorMIN, sensorMAX)

                end

                if sensorTGT == 'voltage__mah' then

                    sensorTGT = "voltage"
                    sensorVALUE = neuronstatus.sensordisplay[sensorTGT]['value']
                    sensorUNIT = neuronstatus.sensordisplay[sensorTGT]['unit']
                    sensorMIN = neuronstatus.sensordisplay[sensorTGT]['min']
                    sensorMAX = neuronstatus.sensordisplay[sensorTGT]['max']
                    sensorWARN = neuronstatus.sensordisplay[sensorTGT]['warn']
                    sensorTITLE = neuronstatus.sensordisplay[sensorTGT]['title']

                    smallBOX = true
                    neuronstatus.telemetryBox(posX, posY, boxW, boxH / 2 - (theme.colSpacing / 2), sensorTITLE, sensorVALUE, sensorUNIT, smallBOX, sensorWARN, sensorMIN, sensorMAX)

                    sensorTGT = "mah"
                    sensorVALUE = neuronstatus.sensordisplay[sensorTGT]['value']
                    sensorUNIT = neuronstatus.sensordisplay[sensorTGT]['unit']
                    sensorMIN = neuronstatus.sensordisplay[sensorTGT]['min']
                    sensorMAX = neuronstatus.sensordisplay[sensorTGT]['max']
                    sensorWARN = neuronstatus.sensordisplay[sensorTGT]['warn']
                    sensorTITLE = neuronstatus.sensordisplay[sensorTGT]['title']

                    smallBOX = true
                    neuronstatus.telemetryBox(posX, posY + boxH / 2 + (theme.colSpacing / 2), boxW, boxH / 2 - theme.colSpacing / 2, sensorTITLE, sensorVALUE, sensorUNIT, smallBOX, sensorWARN,
                                              sensorMIN, sensorMAX)

                end

                if sensorTGT == 'timer__t_esc__rssi' then

                    sensorTGT = "timer"
                    sensorVALUE = neuronstatus.sensordisplay[sensorTGT]['value']
                    sensorUNIT = neuronstatus.sensordisplay[sensorTGT]['unit']
                    sensorMIN = neuronstatus.sensordisplay[sensorTGT]['min']
                    sensorMAX = neuronstatus.sensordisplay[sensorTGT]['max']
                    sensorWARN = neuronstatus.sensordisplay[sensorTGT]['warn']
                    sensorTITLE = neuronstatus.sensordisplay[sensorTGT]['title']

                    smallBOX = true
                    neuronstatus.telemetryBox(posX, posY, boxW, boxH / 2 - (theme.colSpacing / 2), sensorTITLE, sensorVALUE, sensorUNIT, smallBOX, sensorWARN, sensorMIN, sensorMAX)

                    sensorTGT = "temp_esc"

                    if neuronstatus.sensordisplay[sensorTGT] ~= nil then
                        sensorVALUE = neuronstatus.sensordisplay[sensorTGT]['value']
                        sensorUNIT = neuronstatus.sensordisplay[sensorTGT]['unit']
                        sensorMIN = neuronstatus.sensordisplay[sensorTGT]['min']
                        sensorMAX = neuronstatus.sensordisplay[sensorTGT]['max']
                        sensorWARN = neuronstatus.sensordisplay[sensorTGT]['warn']
                        sensorTITLE = neuronstatus.sensordisplay[sensorTGT]['title']

                        smallBOX = true
                        neuronstatus.telemetryBox(posX, posY + boxH / 2 + (theme.colSpacing / 2), boxW / 2 - (theme.colSpacing / 2), boxH / 2 - (theme.colSpacing / 2), sensorTITLE, sensorVALUE,
                                                  sensorUNIT, smallBOX, sensorWARN, sensorMIN, sensorMAX)
                    end

                    sensorTGT = "rssi"
                    if neuronstatus.sensordisplay[sensorTGT] ~= nil then
                        sensorVALUE = neuronstatus.sensordisplay[sensorTGT]['value']
                        sensorUNIT = neuronstatus.sensordisplay[sensorTGT]['unit']
                        sensorMIN = neuronstatus.sensordisplay[sensorTGT]['min']
                        sensorMAX = neuronstatus.sensordisplay[sensorTGT]['max']
                        sensorWARN = neuronstatus.sensordisplay[sensorTGT]['warn']
                        sensorTITLE = neuronstatus.sensordisplay[sensorTGT]['title']

                        smallBOX = true
                        neuronstatus.telemetryBox(posX + boxW / 2 + (theme.colSpacing / 2), posY + boxH / 2 + (theme.colSpacing / 2), boxW / 2 - (theme.colSpacing / 2),
                                                  boxH / 2 - (theme.colSpacing / 2), sensorTITLE, sensorVALUE, sensorUNIT, smallBOX, sensorWARN, sensorMIN, sensorMAX)
                    end
                end

            end

            c = c + 1
        end

        -- if neuronstatus.linkUP == 0 then
        if neuronstatus.linkUP == 0 then neuronstatus.noTelem() end

        if neuronstatus.showLOGS then neuronstatus.logsBOX() end

    end

	-- moved from here

end

function neuronstatus.ReverseTable(t)
    local reversedTable = {}
    local itemCount = #t
    for k, v in ipairs(t) do reversedTable[itemCount + 1 - k] = v end
    return reversedTable
end

function neuronstatus.getChannelValue(ich)
    local src = system.getSource({category = CATEGORY_CHANNEL, member = (ich - 1), options = 0})
    return math.floor((src:value() / 10.24) + 0.5)
end

function neuronstatus.getSensors()
    if neuronstatus.isInConfiguration == true then return neuronstatus.oldsensors end

    lcd.resetFocusTimeout()

    if neuronstatus.environment.simulation == true then

        tv = math.random(2100, 2274)
        voltage = tv
        temp_esc = math.random(500, 2250) * 10
        rpm = 0
        mah = math.random(0, 10)
        current = math.random(10, 22)
        fuel = 0
        fm = "DISABLED"
        rssi = math.random(90, 100)
        adjsource = 0
        adjvalue = 0

        if neuronstatus.idleupSwitchParam ~= nil and neuronstatus.armSwitchParam ~= nil then
            if neuronstatus.idleupSwitchParam:state() == true and neuronstatus.armSwitchParam:state() == true then
                current = math.random(100, 120)
                rpm = math.random(90, 100)
            else
                current = 0
                rpm = 0
            end
        end

    elseif neuronstatus.linkUP ~= 0 then

        local telemetrySOURCE = system.getSource("Rx RSSI1")

        -- we are run sport	
        -- set sources for everthing below
        -- print("SPORT")

        voltageSOURCE = system.getSource("ESC voltage")
        rpmSOURCE = system.getSource("ESC RPM")
        currentSOURCE = system.getSource("ESC current")
        temp_escSOURCE = system.getSource("ESC temp")
        mahSOURCE = system.getSource("ESC consumption")

        -- we dont actually have a fuel sensor; so we calculate one

        -- voltageSOURCE = system.getSource("VFAS")
        if voltageSOURCE ~= nil then
            voltage = voltageSOURCE:value()
            if voltage ~= nil then
                voltage = voltage * 100
            else
                voltage = 0
            end
        else
            voltage = 0
        end

        if rpmSOURCE ~= nil then
            rpm = rpmSOURCE:value()
            if rpm ~= nil then
                rpm = rpm
            else
                rpm = 0
            end
        else
            rpm = 0
        end

        if currentSOURCE ~= nil then
            current = currentSOURCE:value()
            if current ~= nil then
                current = current * 10
            else
                current = 0
            end
        else
            current = 0
        end

        if temp_escSOURCE ~= nil then
            temp_esc = temp_escSOURCE:value()
            if temp_esc ~= nil then
                temp_esc = temp_esc * 100
            else
                temp_esc = 0
            end
        else
            temp_esc = 0
        end

        if mahSOURCE ~= nil then
            mah = mahSOURCE:value()
            if mah ~= nil then
                mah = mah
            else
                mah = 0
            end
        else
            mah = 0
        end

        rssi = neuronstatus.linkUP

    else
        -- we have no link.  do something
        -- print("NO LINK")
        -- keep looking for new sensor
        neuronstatus.rssiSensor = neuronstatus.getRssiSensor()

        voltage = 0
        rpm = 0
        current = 0
        temp_esc = 0
        temp_mcu = 0
        fuel = 0
        mah = 0
        rssi = neuronstatus.linkUP

    end

    -- convert from C to F
    -- Divide by 5, then multiply by 9, then add 32
    if neuronstatus.tempconvertParamESC == 2 then
        temp_esc = ((temp_esc / 5) * 9) + 32
        temp_esc = neuronstatus.round(temp_esc, 0)
    end
    -- convert from F to C
    -- Deduct 32, then multiply by 5, then divide by 9
    if neuronstatus.tempconvertParamESC == 3 then
        temp_esc = ((temp_esc - 32) * 5) / 9
        temp_esc = neuronstatus.round(temp_esc, 0)
    end

    -- set flag to neuronstatus.refresh screen or not

    voltage = neuronstatus.kalmanVoltage(voltage, neuronstatus.oldsensors.voltage)
    voltage = neuronstatus.round(voltage, 0)

    rpm = neuronstatus.kalmanRPM(rpm, neuronstatus.oldsensors.rpm)
    rpm = neuronstatus.round(rpm, 0)

    temp_esc = neuronstatus.kalmanTempESC(temp_esc, neuronstatus.oldsensors.temp_esc)
    temp_esc = neuronstatus.round(temp_esc, 0)

    current = neuronstatus.kalmanCurrent(current, neuronstatus.oldsensors.current)
    current = neuronstatus.round(current, 0)

    rssi = neuronstatus.kalmanRSSI(rssi, neuronstatus.oldsensors.rssi)
    rssi = neuronstatus.round(rssi, 0)

    -- intercept flight mode governor 
    if neuronstatus.armSwitchParam ~= nil or neuronstatus.idleupSwitchParam ~= nil then

        if neuronstatus.armSwitchParam:state() == true then
            fm = "ARMED"
        else
            fm = "DISARMED"
        end

        if neuronstatus.armSwitchParam:state() == true then
            if neuronstatus.idleupSwitchParam:state() == true then
                fm = "ACTIVE"
            else
                fm = "THR-OFF"
            end

        end
    end

    -- calc fuel as this is based on pack capacity
    if neuronstatus.capacityParam ~= nil then
        -- used percentage is
        local percentUsed = (mah / neuronstatus.capacityParam) * 100
        local percentLeft = 100 - percentUsed
        fuel = neuronstatus.round(percentLeft, 0)

    else
        fuel = 0
    end

    if neuronstatus.linkUP == 0 then fuel = 0 end

    if neuronstatus.oldsensors.voltage ~= voltage then neuronstatus.refresh = true end
    if neuronstatus.oldsensors.rpm ~= rpm then neuronstatus.refresh = true end
    if neuronstatus.oldsensors.current ~= current then neuronstatus.refresh = true end
    if neuronstatus.oldsensors.temp_esc ~= temp_esc then neuronstatus.refresh = true end

    if neuronstatus.oldsensors.fuel ~= fuel then neuronstatus.refresh = true end
    if neuronstatus.oldsensors.mah ~= mah then neuronstatus.refresh = true end
    if neuronstatus.oldsensors.rssi ~= rssi then neuronstatus.refresh = true end

    ret = {fm = fm, voltage = voltage, rpm = rpm, current = current, temp_esc = temp_esc, fuel = fuel, mah = mah, rssi = rssi}
    neuronstatus.oldsensors = ret

    return ret
end

function neuronstatus.sensorsMAXMIN(sensors)

    if idleupdelayParam == nil then idleupdelayParam = 1 end

    if neuronstatus.linkUP ~= 0 and theTIME ~= nil and theTIME ~= nil and idleupdelayParam ~= nil then

        -- hold back - to early to get a reading
        if theTIME <= idleupdelayParam then
            neuronstatus.sensorVoltageMin = 0
            neuronstatus.sensorVoltageMax = 0
            neuronstatus.sensorFuelMin = 0
            neuronstatus.sensorFuelMax = 0
            neuronstatus.sensorRPMMin = 0
            neuronstatus.sensorRPMMax = 0
            neuronstatus.sensorCurrentMin = 0
            neuronstatus.sensorCurrentMax = 0
            neuronstatus.sensorRSSIMin = 0
            neuronstatus.sensorRSSIMax = 0
            neuronstatus.sensorTempESCMin = 0
            neuronstatus.sensorTempESCMax = 0
        end

        -- prob put in a screen/audio alert for initialising
        if theTIME >= 1 and theTIME < idleupdelayParam then end

        if theTIME >= idleupdelayParam then

            local idleupdelayOFFSET = 2

            if theTIME >= idleupdelayParam and theTIME <= (idleupdelayParam + idleupdelayOFFSET) then
                neuronstatus.sensorVoltageMin = sensors.voltage
                neuronstatus.sensorVoltageMax = sensors.voltage
                neuronstatus.sensorFuelMin = sensors.fuel
                neuronstatus.sensorFuelMax = sensors.fuel
                neuronstatus.sensorRPMMin = sensors.rpm
                neuronstatus.sensorRPMMax = sensors.rpm
                if neuronstatus.current == 0 then
                    neuronstatus.sensorCurrentMin = 1
                else
                    neuronstatus.sensorCurrentMin = sensors.current
                end
                neuronstatus.sensorCurrentMax = sensors.current

                neuronstatus.sensorRSSIMin = sensors.rssi
                neuronstatus.sensorRSSIMax = sensors.rssi
                neuronstatus.sensorTempESCMin = sensors.temp_esc
                neuronstatus.sensorTempESCMax = sensors.temp_esc
                motorNearlyActive = 0
            end

            if theTIME >= (idleupdelayParam + idleupdelayOFFSET) and neuronstatus.idleupSwitchParam:state() == true then

                if sensors.voltage < neuronstatus.sensorVoltageMin then neuronstatus.sensorVoltageMin = sensors.voltage end
                if sensors.voltage > neuronstatus.sensorVoltageMax then neuronstatus.sensorVoltageMax = sensors.voltage end

                if sensors.fuel < neuronstatus.sensorFuelMin then neuronstatus.sensorFuelMin = sensors.fuel end
                if sensors.fuel > neuronstatus.sensorFuelMax then neuronstatus.sensorFuelMax = sensors.fuel end

                if sensors.rpm < neuronstatus.sensorRPMMin then neuronstatus.sensorRPMMin = sensors.rpm end
                if sensors.rpm > neuronstatus.sensorRPMMax then neuronstatus.sensorRPMMax = sensors.rpm end
                if sensors.current < neuronstatus.sensorCurrentMin then
                    neuronstatus.sensorCurrentMin = sensors.current
                    if neuronstatus.sensorCurrentMin == 0 then neuronstatus.sensorCurrentMin = 1 end
                end
                if nsensors.current > neuronstatus.sensorCurrentMax then neuronstatus.sensorCurrentMax = sensors.current end
                if nsensors.rssi < neuronstatus.sensorRSSIMin then neuronstatus.sensorRSSIMin = sensors.rssi end
                if nsensors.rssi > neuronstatus.sensorRSSIMax then neuronstatus.sensorRSSIMax = sensors.rssi end
                if sensors.temp_esc < neuronstatus.sensorTempESCMin then neuronstatus.sensorTempESCMin = temp_esc end
                if sensors.temp_esc > neuronstatus.sensorTempESCMax then neuronstatus.sensorTempESCMax = sensors.temp_esc end
                neuronstatus.motorWasActive = true
            end

        end

        -- store the last values
        if neuronstatus.motorWasActive and neuronstatus.idleupSwitchParam:state() == false then

            neuronstatus.motorWasActive = false

            neuronstatus.maxminFinals = neuronstatus.readHistory()

            if neuronstatus.sensorCurrentMin == 0 then
                neuronstatus.sensorCurrentMinAlt = 1
            else
                neuronstatus.sensorCurrentMinAlt = neuronstatus.sensorCurrentMin
            end
            if neuronstatus.sensorCurrentMax == 0 then
                neuronstatus.sensorCurrentMaxAlt = 1
            else
                neuronstatus.sensorCurrentMaxAlt = neuronstatus.sensorCurrentMax
            end

            local maxminRow =
                theTIME .. "," .. neuronstatus.sensorVoltageMin .. "," .. neuronstatus.sensorVoltageMax .. "," .. neuronstatus.sensorFuelMin .. "," .. neuronstatus.sensorFuelMax .. "," ..
                    neuronstatus.sensorRPMMin .. "," .. neuronstatus.sensorRPMMax .. "," .. neuronstatus.sensorCurrentMinAlt .. "," .. neuronstatus.sensorCurrentMaxAlt .. "," ..
                    neuronstatus.sensorRSSIMin .. "," .. neuronstatus.sensorRSSIMax .. "," .. neuronstatus.sensorTempESCMin .. "," .. neuronstatus.sensorTempESCMax

            -- print("Last data: ".. maxminRow )

            table.insert(neuronstatus.maxminFinals, 1, maxminRow)
            if tablelength(neuronstatus.maxminFinals) >= 9 then table.remove(neuronstatus.maxminFinals, 9) end

            name = string.gsub(model.name(), "%s+", "_")
            name = string.gsub(name, "%W", "_")

            file = widgetDir .. "logs/" .. name .. ".log"
            f = io.open(file, 'w')
            f:write("")
            io.close(f)

            -- print("Writing history to: " .. file)

            f = io.open(file, 'a')
            for k, v in ipairs(neuronstatus.maxminFinals) do
                if v ~= nil then
                    v = v:gsub("%s+", "")
                    -- if v ~= "" then
                    -- print(v)
                    f:write(v .. "\n")
                    -- end
                end
            end
            io.close(f)

            neuronstatus.readLOGS = false

        end

    else
        neuronstatus.sensorVoltageMax = 0
        neuronstatus.sensorVoltageMin = 0
        neuronstatus.sensorFuelMin = 0
        neuronstatus.sensorFuelMax = 0
        neuronstatus.sensorRPMMin = 0
        neuronstatus.sensorRPMMax = 0
        neuronstatus.sensorCurrentMin = 0
        neuronstatus.sensorCurrentMax = 0
        neuronstatus.sensorTempESCMin = 0
        neuronstatus.sensorTempESCMax = 0
    end

end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function print_r(arr, indentLevel)
    local str = ""
    local indentStr = "#"

    if (indentLevel == nil) then
        print(print_r(arr, 0))
        return
    end

    for i = 0, indentLevel do indentStr = indentStr .. "\t" end

    for index, value in ipairs(arr) do
        if type(value) == "table" then
            str = str .. indentStr .. index .. ": \n" .. print_r(value, (indentLevel + 1))
        else
            str = str .. indentStr .. index .. ": " .. value .. "\n"
        end
    end
    return str
end

function neuronstatus.updateFILTERING()
    if neuronstatus.filteringParam == 2 then
        -- print("Filtering: medium")
        neuronstatus.voltageNoiseQ = 150
        neuronstatus.fuelNoiseQ = 150
        neuronstatus.rpmNoiseQ = 150
        neuronstatus.temp_mcuNoiseQ = 150
        neuronstatus.temp_escNoiseQ = 150
        neuronstatus.rssiNoiseQ = 150
        neuronstatus.currentNoiseQ = 150
    elseif neuronstatus.filteringParam == 3 then
        -- print("Filtering: high")
        neuronstatus.voltageNoiseQ = 200
        neuronstatus.fuelNoiseQ = 200
        neuronstatus.rpmNoiseQ = 200
        neuronstatus.temp_mcuNoiseQ = 200
        neuronstatus.temp_escNoiseQ = 200
        neuronstatus.rssiNoiseQ = 200
        neuronstatus.currentNoiseQ = 200
    else
        -- print("Filtering: low")
        neuronstatus.voltageNoiseQ = 100
        neuronstatus.fuelNoiseQ = 100
        neuronstatus.rpmNoiseQ = 100
        neuronstatus.temp_mcuNoiseQ = 100
        neuronstatus.temp_escNoiseQ = 100
        neuronstatus.rssiNoiseQ = 100
        neuronstatus.currentNoiseQ = 100
    end
end

function neuronstatus.kalmanCurrent(new, old)
    if old == nil then old = 0 end
    if new == nil then new = 0 end
    x = old
    local p = 100
    local k = 0
    p = p + 0.05
    k = p / (p + neuronstatus.currentNoiseQ)
    x = x + k * (new - x)
    p = (1 - k) * p
    return x
end

function neuronstatus.kalmanRSSI(new, old)
    if old == nil then old = 0 end
    if new == nil then new = 0 end
    x = old
    local p = 100
    local k = 0
    p = p + 0.05
    k = p / (p + neuronstatus.rssiNoiseQ)
    x = x + k * (new - x)
    p = (1 - k) * p
    return x
end

function neuronstatus.kalmanTempESC(new, old)
    if old == nil then old = 0 end
    if new == nil then new = 0 end
    x = old
    local p = 100
    local k = 0
    p = p + 0.05
    k = p / (p + neuronstatus.temp_escNoiseQ)
    x = x + k * (new - x)
    p = (1 - k) * p
    return x
end

function neuronstatus.kalmanRPM(new, old)
    if old == nil then old = 0 end
    if new == nil then new = 0 end
    x = old
    local p = 100
    local k = 0
    p = p + 0.05
    k = p / (p + neuronstatus.rpmNoiseQ)
    x = x + k * (new - x)
    p = (1 - k) * p
    return x
end

function neuronstatus.kalmanVoltage(new, old)
    if old == nil then old = 0 end
    if new == nil then new = 0 end
    x = old
    local p = 100
    local k = 0
    p = p + 0.05
    k = p / (p + neuronstatus.voltageNoiseQ)
    x = x + k * (new - x)
    p = (1 - k) * p
    return x
end

function neuronstatus.sensorMakeNumber(x)
    if x == nil or x == "" then x = 0 end

    x = string.gsub(x, "%D+", "")
    x = tonumber(x)
    if x == nil or x == "" then x = 0 end

    return x
end

function neuronstatus.round(number, precision)
    local fmtStr = string.format("%%0.%sf", precision)
    number = string.format(fmtStr, number)
    number = tonumber(number)
    return number
end

function neuronstatus.SecondsToClock(seconds)
    local seconds = tonumber(seconds)

    if seconds <= 0 then
        return "00:00:00"
    else
        hours = string.format("%02.f", math.floor(seconds / 3600))
        mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
        secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))
        return hours .. ":" .. mins .. ":" .. secs
    end
end

function neuronstatus.SecondsToClockAlt(seconds)
    local seconds = tonumber(seconds)

    if seconds <= 0 then
        return "00:00"
    else
        hours = string.format("%02.f", math.floor(seconds / 3600))
        mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
        secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))
        return mins .. ":" .. secs
    end
end

function neuronstatus.SecondsFromTime(seconds)
    local seconds = tonumber(seconds)

    if seconds <= 0 then
        return "0"
    else
        hours = string.format("%02.f", math.floor(seconds / 3600))
        mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
        secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))
        return tonumber(secs)
    end
end

function neuronstatus.spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys + 1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a, b)
            return order(t, a, b)
        end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then return keys[i], t[keys[i]] end
    end
end

function neuronstatus.explode(inputstr, sep)
    if sep == nil then sep = "%s" end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do table.insert(t, str) end
    return t
end

function neuronstatus.ReadLine(f, line)
    local i = 1 -- line counter
    for l in f:lines() do -- lines iterator, "l" returns the line
        if i == line then return l end -- we found this line, return it
        i = i + 1 -- counting lines
    end
    return "" -- Doesn't have that line
end

function neuronstatus.readHistory()

    local history = {}
    -- print("Reading history")

    name = string.gsub(model.name(), "%s+", "_")
    name = string.gsub(name, "%W", "_")
    file = widgetDir .. "logs/" .. name .. ".log"
    local f = io.open(file, "rb")

    if f ~= nil then
        -- file exists
        local rData
        c = 0
        tc = 1
        while c <= 10 do
            if c == 0 then
                rData = io.read(f, "l")
            else
                rData = io.read(f, "L")
            end
            if rData ~= "" or rData ~= nil then
                history[tc] = rData
                tc = tc + 1
            end
            c = c + 1
        end
        io.close(f)
    else
        return history
    end

    return history

end

function neuronstatus.read()
    neuronstatus.btypeParam = storage.read("mem1")
    neuronstatus.capacityParam = storage.read("mem2")
    neuronstatus.cellsParam = storage.read("mem3")
    neuronstatus.lowfuelParam = storage.read("mem4")
    neuronstatus.alertonParam = storage.read("mem5")
    neuronstatus.alertintParam = storage.read("mem6")
    alrthptParam = storage.read("mem7")
    neuronstatus.announceVoltageSwitchParam = storage.read("mem8")
    neuronstatus.announceRPMSwitchParam = storage.read("mem9")
    neuronstatus.announceCurrentSwitchParam = storage.read("mem10")
    neuronstatus.announceFuelSwitchParam = storage.read("mem11")
    neuronstatus.announceLQSwitchParam = storage.read("mem12")
    neuronstatus.announceESCSwitchParam = storage.read("mem13")
    neuronstatus.announceTimerSwitchParam = storage.read("mem14")
    neuronstatus.titleParam = storage.read("mem15")
    neuronstatus.maxminParam = storage.read("mem16")
    neuronstatus.tempconvertParamESC = storage.read("mem17")
    neuronstatus.lowvoltagsenseParam = storage.read("mem18")
    neuronstatus.sagParam = storage.read("mem19")
    neuronstatus.filteringParam = storage.read("mem20")
    neuronstatus.announceIntervalParam = storage.read("mem21")
    neuronstatus.armSwitchParam = storage.read("mem22")
    neuronstatus.idleupSwitchParam = storage.read("mem23")
    idleupdelayParam = storage.read("mem24")
    neuronstatus.layoutBox1Param = storage.read("mem25")
    neuronstatus.layoutBox2Param = storage.read("mem26")
    neuronstatus.layoutBox3Param = storage.read("mem27")
    neuronstatus.layoutBox4Param = storage.read("mem28")
    neuronstatus.layoutBox5Param = storage.read("mem29")
    neuronstatus.layoutBox6Param = storage.read("mem30")
    neuronstatus.timeralarmVibrateParam = storage.read("mem31")
    neuronstatus.timeralarmParam = storage.read("mem32")

    if neuronstatus.layoutBox1Param == nil then neuronstatus.layoutBox1Param = 11 end
    if neuronstatus.layoutBox2Param == nil then neuronstatus.layoutBox2Param = 2 end
    if neuronstatus.layoutBox3Param == nil then neuronstatus.layoutBox3Param = 3 end
    if neuronstatus.layoutBox4Param == nil then neuronstatus.layoutBox4Param = 15 end
    if neuronstatus.layoutBox5Param == nil then neuronstatus.layoutBox5Param = 4 end
    if neuronstatus.layoutBox6Param == nil then neuronstatus.layoutBox6Param = 6 end

    neuronstatus.resetALL()
    neuronstatus.updateFILTERING()
end

function neuronstatus.write()

    storage.write("mem1", neuronstatus.btypeParam)
    storage.write("mem2", neuronstatus.capacityParam)
    storage.write("mem3", neuronstatus.cellsParam)
    storage.write("mem4", neuronstatus.lowfuelParam)
    storage.write("mem5", neuronstatus.alertonParam)
    storage.write("mem6", neuronstatus.alertintParam)
    storage.write("mem7", alrthptParam)
    storage.write("mem8", neuronstatus.announceVoltageSwitchParam)
    storage.write("mem9", neuronstatus.announceRPMSwitchParam)
    storage.write("mem10", neuronstatus.announceCurrentSwitchParam)
    storage.write("mem11", neuronstatus.announceFuelSwitchParam)
    storage.write("mem12", neuronstatus.announceLQSwitchParam)
    storage.write("mem13", neuronstatus.announceESCSwitchParam)
    storage.write("mem14", neuronstatus.announceTimerSwitchParam)
    storage.write("mem15", neuronstatus.titleParam)
    storage.write("mem16", neuronstatus.maxminParam)
    storage.write("mem17", neuronstatus.tempconvertParamESC)
    storage.write("mem18", neuronstatus.lowvoltagsenseParam)
    storage.write("mem19", neuronstatus.sagParam)
    storage.write("mem20", neuronstatus.filteringParam)
    storage.write("mem21", neuronstatus.announceIntervalParam)
    storage.write("mem22", neuronstatus.armSwitchParam)
    storage.write("mem23", neuronstatus.idleupSwitchParam)
    storage.write("mem24", idleupdelayParam)
    storage.write("mem25", neuronstatus.layoutBox1Param)
    storage.write("mem26", neuronstatus.layoutBox2Param)
    storage.write("mem27", neuronstatus.layoutBox3Param)
    storage.write("mem28", neuronstatus.layoutBox4Param)
    storage.write("mem29", neuronstatus.layoutBox5Param)
    storage.write("mem30", neuronstatus.layoutBox6Param)
    storage.write("mem31", neuronstatus.timeralarmVibrateParam)
    storage.write("mem32", neuronstatus.timeralarmParam)
    neuronstatus.updateFILTERING()
end

function neuronstatus.playCurrent(widget)
    if neuronstatus.announceCurrentSwitchParam ~= nil then
        if neuronstatus.announceCurrentSwitchParam:state() then
            neuronstatus.currentannounceTimer = true
            currentDoneFirst = false
        else
            neuronstatus.currentannounceTimer = false
            currentDoneFirst = true
        end

        if neuronstatus.isInConfiguration == false then
            if neuronstatus.sensors.current ~= nil then
                if neuronstatus.currentannounceTimer == true then
                    -- start timer
                    if neuronstatus.currentannounceTimerStart == nil and currentDoneFirst == false then
                        neuronstatus.currentannounceTimerStart = os.time()
                        neuronstatus.currentaudioannounceCounter = os.clock()
                        -- print ("Play Current Alert (first)")
                        system.playNumber(neuronstatus.sensors.current / 10, UNIT_AMPERE, 2)
                        currentDoneFirst = true
                    end
                else
                    neuronstatus.currentannounceTimerStart = nil
                end

                if neuronstatus.currentannounceTimerStart ~= nil then
                    if currentDoneFirst == false then
                        if ((tonumber(os.clock()) - tonumber(neuronstatus.currentaudioannounceCounter)) >= neuronstatus.announceIntervalParam) then
                            -- print ("Play Current Alert (repeat)")
                            neuronstatus.currentaudioannounceCounter = os.clock()
                            system.playNumber(neuronstatus.sensors.current / 10, UNIT_AMPERE, 2)
                        end
                    end
                else
                    -- stop timer
                    neuronstatus.currentannounceTimerStart = nil
                end
            end
        end
    end
end

function neuronstatus.playLQ(widget)
    if neuronstatus.announceLQSwitchParam ~= nil then
        if neuronstatus.announceLQSwitchParam:state() then
            neuronstatus.lqannounceTimer = true
            lqDoneFirst = false
        else
            neuronstatus.lqannounceTimer = false
            lqDoneFirst = true
        end

        if neuronstatus.isInConfiguration == false then
            if neuronstatus.sensors.rssi ~= nil then
                if neuronstatus.lqannounceTimer == true then
                    -- start timer
                    if neuronstatus.lqannounceTimerStart == nil and lqDoneFirst == false then
                        neuronstatus.lqannounceTimerStart = os.time()
                        neuronstatus.lqaudioannounceCounter = os.clock()
                        -- print ("Play LQ Alert (first)")
                        system.playFile(widgetDir .. "sounds/alerts/lq.wav")
                        system.playNumber(neuronstatus.sensors.rssi, UNIT_PERCENT, 2)
                        lqDoneFirst = true
                    end
                else
                    neuronstatus.lqannounceTimerStart = nil
                end

                if neuronstatus.lqannounceTimerStart ~= nil then
                    if lqDoneFirst == false then
                        if ((tonumber(os.clock()) - tonumber(neuronstatus.lqaudioannounceCounter)) >= neuronstatus.announceIntervalParam) then
                            neuronstatus.lqaudioannounceCounter = os.clock()
                            -- print ("Play LQ Alert (repeat)")
                            system.playFile(widgetDir .. "sounds/alerts/lq.wav")
                            system.playNumber(neuronstatus.sensors.rssi, UNIT_PERCENT, 2)
                        end
                    end
                else
                    -- stop timer
                    neuronstatus.lqannounceTimerStart = nil
                end
            end
        end
    end
end

function neuronstatus.playESC(widget)
    if neuronstatus.announceESCSwitchParam ~= nil then
        if neuronstatus.announceESCSwitchParam:state() then
            neuronstatus.escannounceTimer = true
            escDoneFirst = false
        else
            neuronstatus.escannounceTimer = false
            escDoneFirst = true
        end

        if neuronstatus.isInConfiguration == false then
            if neuronstatus.sensors.temp_esc ~= nil then
                if neuronstatus.escannounceTimer == true then
                    -- start timer
                    if neuronstatus.escannounceTimerStart == nil and escDoneFirst == false then
                        neuronstatus.escannounceTimerStart = os.time()
                        neuronstatus.escaudioannounceCounter = os.clock()
                        -- print ("Playing ESC (first)")
                        system.playFile(widgetDir .. "sounds/alerts/esc.wav")
                        system.playNumber(neuronstatus.sensors.temp_esc / 100, UNIT_DEGREE, 2)
                        escDoneFirst = true
                    end
                else
                    neuronstatus.escannounceTimerStart = nil
                end

                if neuronstatus.escannounceTimerStart ~= nil then
                    if escDoneFirst == false then
                        if ((tonumber(os.clock()) - tonumber(neuronstatus.escaudioannounceCounter)) >= neuronstatus.announceIntervalParam) then
                            neuronstatus.escaudioannounceCounter = os.clock()
                            -- print ("Playing ESC (repeat)")
                            system.playFile(widgetDir .. "sounds/alerts/esc.wav")
                            system.playNumber(neuronstatus.sensors.temp_esc / 100, UNIT_DEGREE, 2)
                        end
                    end
                else
                    -- stop timer
                    neuronstatus.escannounceTimerStart = nil
                end
            end
        end
    end
end

function neuronstatus.playTIMERALARM(widget)
    if theTIME ~= nil and neuronstatus.timeralarmParam ~= nil and neuronstatus.timeralarmParam ~= 0 then

        -- reset timer Delay
        if theTIME > neuronstatus.timeralarmParam + 2 then neuronstatus.timerAlarmPlay = true end
        -- trigger first timer
        if neuronstatus.timerAlarmPlay == true then
            if theTIME >= neuronstatus.timeralarmParam and theTIME <= neuronstatus.timeralarmParam + 1 then

                system.playFile(widgetDir .. "sounds/alerts/beep.wav")

                hours = string.format("%02.f", math.floor(theTIME / 3600))
                mins = string.format("%02.f", math.floor(theTIME / 60 - (hours * 60)))
                secs = string.format("%02.f", math.floor(theTIME - hours * 3600 - mins * 60))

                system.playFile(widgetDir .. "sounds/alerts/timer.wav")
                if mins ~= "00" then system.playNumber(mins, UNIT_MINUTE, 2) end
                system.playNumber(secs, UNIT_SECOND, 2)

                if neuronstatus.timeralarmVibrateParam == true then system.playHaptic("- - -") end

                neuronstatus.timerAlarmPlay = false
            end
        end

    end
end

function neuronstatus.playTIMER(widget)
    if neuronstatus.announceTimerSwitchParam ~= nil then

        if neuronstatus.announceTimerSwitchParam:state() then
            neuronstatus.timerannounceTimer = true
            timerDoneFirst = false
        else
            neuronstatus.timerannounceTimer = false
            timerDoneFirst = true
        end

        if neuronstatus.isInConfiguration == false then

            if theTIME == nil then
                alertTIME = 0
            else
                alertTIME = theTIME
            end

            if alertTIME ~= nil then

                hours = string.format("%02.f", math.floor(alertTIME / 3600))
                mins = string.format("%02.f", math.floor(alertTIME / 60 - (hours * 60)))
                secs = string.format("%02.f", math.floor(alertTIME - hours * 3600 - mins * 60))

                if neuronstatus.timerannounceTimer == true then
                    -- start timer
                    if neuronstatus.timerannounceTimerStart == nil and timerDoneFirst == false then
                        neuronstatus.timerannounceTimerStart = os.time()
                        neuronstatus.timeraudioannounceCounter = os.clock()
                        -- print ("Playing TIMER (first)" .. alertTIME)

                        if mins ~= "00" then system.playNumber(mins, UNIT_MINUTE, 2) end
                        system.playNumber(secs, UNIT_SECOND, 2)

                        timerDoneFirst = true
                    end
                else
                    neuronstatus.timerannounceTimerStart = nil
                end

                if neuronstatus.timerannounceTimerStart ~= nil then
                    if timerDoneFirst == false then
                        if ((tonumber(os.clock()) - tonumber(neuronstatus.timeraudioannounceCounter)) >= neuronstatus.announceIntervalParam) then
                            neuronstatus.timeraudioannounceCounter = os.clock()
                            -- print ("Playing TIMER (repeat)" .. alertTIME)
                            if mins ~= "00" then system.playNumber(mins, UNIT_MINUTE, 2) end
                            system.playNumber(secs, UNIT_SECOND, 2)
                        end
                    end
                else
                    -- stop timer
                    neuronstatus.timerannounceTimerStart = nil
                end
            end
        end
    end
end

function neuronstatus.playFuel(widget)
    if neuronstatus.announceFuelSwitchParam ~= nil then
        if neuronstatus.announceFuelSwitchParam:state() then
            neuronstatus.fuelannounceTimer = true
            fuelDoneFirst = false
        else
            neuronstatus.fuelannounceTimer = false
            fuelDoneFirst = true
        end

        if neuronstatus.isInConfiguration == false then
            if neuronstatus.sensors.fuel ~= nil then
                if neuronstatus.fuelannounceTimer == true then
                    -- start timer
                    if neuronstatus.fuelannounceTimerStart == nil and fuelDoneFirst == false then
                        neuronstatus.fuelannounceTimerStart = os.time()
                        neuronstatus.fuelaudioannounceCounter = os.clock()
                        -- print("Play fuel alert (first)")
                        system.playFile(widgetDir .. "sounds/alerts/fuel.wav")
                        system.playNumber(neuronstatus.sensors.fuel, UNIT_PERCENT, 2)
                        fuelDoneFirst = true
                    end
                else
                    neuronstatus.fuelannounceTimerStart = nil
                end

                if neuronstatus.fuelannounceTimerStart ~= nil then
                    if fuelDoneFirst == false then
                        if ((tonumber(os.clock()) - tonumber(neuronstatus.fuelaudioannounceCounter)) >= neuronstatus.announceIntervalParam) then
                            neuronstatus.fuelaudioannounceCounter = os.clock()
                            -- print("Play fuel alert (repeat)")
                            system.playFile(widgetDir .. "sounds/alerts/fuel.wav")
                            system.playNumber(neuronstatus.sensors.fuel, UNIT_PERCENT, 2)

                        end
                    end
                else
                    -- stop timer
                    neuronstatus.fuelannounceTimerStart = nil
                end
            end
        end
    end
end

function neuronstatus.playRPM(widget)
    if neuronstatus.announceRPMSwitchParam ~= nil then
        if neuronstatus.announceRPMSwitchParam:state() then
            neuronstatus.rpmannounceTimer = true
            rpmDoneFirst = false
        else
            neuronstatus.rpmannounceTimer = false
            rpmDoneFirst = true
        end

        if neuronstatus.isInConfiguration == false then
            if neuronstatus.sensors.rpm ~= nil then
                if neuronstatus.rpmannounceTimer == true then
                    -- start timer
                    if neuronstatus.rpmannounceTimerStart == nil and rpmDoneFirst == false then
                        neuronstatus.rpmannounceTimerStart = os.time()
                        neuronstatus.rpmaudioannounceCounter = os.clock()
                        -- print("Play rpm alert (first)")
                        system.playNumber(neuronstatus.sensors.rpm, UNIT_RPM, 2)
                        rpmDoneFirst = true
                    end
                else
                    neuronstatus.rpmannounceTimerStart = nil
                end

                if neuronstatus.rpmannounceTimerStart ~= nil then
                    if rpmDoneFirst == false then
                        if ((tonumber(os.clock()) - tonumber(neuronstatus.rpmaudioannounceCounter)) >= neuronstatus.announceIntervalParam) then
                            -- print("Play rpm alert (repeat)")
                            neuronstatus.rpmaudioannounceCounter = os.clock()
                            system.playNumber(neuronstatus.sensors.rpm, UNIT_RPM, 2)
                        end
                    end
                else
                    -- stop timer
                    neuronstatus.rpmannounceTimerStart = nil
                end
            end
        end
    end
end

function neuronstatus.playVoltage(widget)
    if neuronstatus.announceVoltageSwitchParam ~= nil then
        if neuronstatus.announceVoltageSwitchParam:state() then
            neuronstatus.lvannounceTimer = true
            voltageDoneFirst = false
        else
            neuronstatus.lvannounceTimer = false
            voltageDoneFirst = true
        end

        if neuronstatus.isInConfiguration == false then
            if neuronstatus.sensors.voltage ~= nil then
                if neuronstatus.lvannounceTimer == true then
                    -- start timer
                    if neuronstatus.lvannounceTimerStart == nil and voltageDoneFirst == false then
                        neuronstatus.lvannounceTimerStart = os.time()
                        neuronstatus.lvaudioannounceCounter = os.clock()
                        -- print("Play voltage alert (first)")
                        -- system.playFile(widgetDir .. "sounds/alerts/voltage.wav")						
                        system.playNumber(neuronstatus.sensors.voltage / 100, 2, 2)
                        voltageDoneFirst = true
                    end
                else
                    neuronstatus.lvannounceTimerStart = nil
                end

                if neuronstatus.lvannounceTimerStart ~= nil then
                    if voltageDoneFirst == false then
                        if ((tonumber(os.clock()) - tonumber(neuronstatus.lvaudioannounceCounter)) >= neuronstatus.announceIntervalParam) then
                            neuronstatus.lvaudioannounceCounter = os.clock()
                            -- print("Play voltage alert (repeat)")
                            -- system.playFile(widgetDir .. "sounds/alerts/voltage.wav")								
                            system.playNumber(neuronstatus.sensors.voltage / 100, 2, 2)
                        end
                    end
                else
                    -- stop timer
                    neuronstatus.lvannounceTimerStart = nil
                end
            end
        end
    end
end

function neuronstatus.event(widget, category, value, x, y)

    -- print("Event received:", category, value, x, y)

    if closingLOGS then
        if category == EVT_TOUCH and (value == 16640 or value == 16641) then
            closingLOGS = false
            return true
        end

    end

    if neuronstatus.showLOGS then
        if value == 35 then neuronstatus.showLOGS = false end

        if category == EVT_TOUCH and (value == 16640 or value == 16641) then
            if (x >= (neuronstatus.closeButtonX) and (x <= (neuronstatus.closeButtonX + neuronstatus.closeButtonW))) and
                (y >= (neuronstatus.closeButtonY) and (y <= (neuronstatus.closeButtonY + neuronstatus.closeButtonH))) then
                neuronstatus.showLOGS = false
                closingLOGS = true
            end
            return true
        else
            if category == EVT_TOUCH then return true end
        end

    end

end

-- MAIN WAKEUP FUNCTION. THIS SIMPLY FARMS OUT AT DIFFERING SCHEDULES TO SUB FUNCTIONS
function neuronstatus.wakeup(widget)

    local schedulerUI
    if lcd.isVisible() then
        schedulerUI = 0.25
    else
        schedulerUI = 1
    end

    -- keep cpu load down by running UI at reduced interval
    local now = os.clock()
    if (now - neuronstatus.wakeupSchedulerUI) >= schedulerUI then
        neuronstatus.wakeupSchedulerUI = now
        neuronstatus.wakeupUI()
    end

end

function neuronstatus.wakeupUI(widget)
    neuronstatus.refresh = false

    neuronstatus.linkUP = neuronstatus.getRSSI()
    neuronstatus.sensors = neuronstatus.getSensors()

    if neuronstatus.refresh == true then
        neuronstatus.sensorsMAXMIN(neuronstatus.sensors)
        lcd.invalidate()
    end

    if neuronstatus.linkUP == 0 then neuronstatus.linkUPTime = os.clock() end

    if neuronstatus.linkUP ~= 0 then

        if neuronstatus.armSwitchParam ~= nil and neuronstatus.armSwitchParam:state() == true and neuronstatus.armState == false then
            system.playFile(widgetDir .. "sounds/triggers/armed.wav")
            neuronstatus.armState = true
        end
        if neuronstatus.armSwitchParam ~= nil and neuronstatus.armSwitchParam:state() == false and neuronstatus.armState == true then
            system.playFile(widgetDir .. "sounds/triggers/disarmed.wav")
            neuronstatus.armState = false
        end

        if neuronstatus.idleupSwitchParam ~= nil and neuronstatus.idleupSwitchParam:state() == true and neuronstatus.idleState == false then
            system.playFile(widgetDir .. "sounds/triggers/thr-active.wav")
            neuronstatus.idleState = true
        end
        if neuronstatus.idleupSwitchParam ~= nil and neuronstatus.idleupSwitchParam:state() == false and neuronstatus.idleState == true then
            system.playFile(widgetDir .. "sounds/triggers/thr-hold.wav")
            neuronstatus.idleState = false
        end

        if ((tonumber(os.clock()) - tonumber(neuronstatus.linkUPTime)) >= 5) then
            -- voltage alerts
            neuronstatus.playVoltage(widget)
            -- rpm
            neuronstatus.playRPM(widget)
            -- current
            neuronstatus.playCurrent(widget)
            -- fuel
            neuronstatus.playFuel(widget)
            -- lq
            neuronstatus.playLQ(widget)
            -- esc
            neuronstatus.playESC(widget)
            -- timer
            neuronstatus.playTIMER(widget)

            -- timer alarm
            neuronstatus.playTIMERALARM(widget)

			--
			-- TIME		

			if neuronstatus.linkUP ~= 0 then
				if neuronstatus.armSwitchParam ~= nil then
					if neuronstatus.armSwitchParam:state() == false then
						neuronstatus.stopTimer = true
						stopTIME = os.clock()
						timerNearlyActive = 1
						theTIME = 0
					end
				end

				if neuronstatus.idleupSwitchParam ~= nil then
					if neuronstatus.idleupSwitchParam:state() then
						if timerNearlyActive == 1 then
							timerNearlyActive = 0
							startTIME = os.clock()
						end
						if startTIME ~= nil then theTIME = os.clock() - startTIME end
					end
				end

			end

			-- LOW FUEL ALERTS
			-- big conditional to announce neuronstatus.lfTimer if needed

			if neuronstatus.linkUP ~= 0 then
				if neuronstatus.idleupSwitchParam ~= nil then
					if neuronstatus.idleupSwitchParam:state() then
						if (neuronstatus.sensors.fuel <= neuronstatus.lowfuelParam and neuronstatus.alertonParam == 1) then
							neuronstatus.lfTimer = true
						elseif (neuronstatus.sensors.fuel <= neuronstatus.lowfuelParam and neuronstatus.alertonParam == 2) then
							neuronstatus.lfTimer = true
						else
							neuronstatus.lfTimer = false
						end
					else
						neuronstatus.lfTimer = false
					end
				else
					neuronstatus.lfTimer = false
				end
			else
				neuronstatus.lfTimer = false
			end

			if neuronstatus.lfTimer == true then
				-- start timer
				if neuronstatus.lfTimerStart == nil then neuronstatus.lfTimerStart = os.time() end
			else
				neuronstatus.lfTimerStart = nil
			end

			if neuronstatus.lfTimerStart ~= nil then
				-- only announce if we have been on for 5 seconds or more
				if (tonumber(os.clock()) - tonumber(neuronstatus.lfAudioAlertCounter)) >= neuronstatus.alertintParam then
					neuronstatus.lfAudioAlertCounter = os.clock()

					system.playFile(widgetDir .. "sounds/alerts/lowfuel.wav")

					if alrthptParam == true then system.playHaptic("- . -") end

				end
			else
				-- stop timer
				neuronstatus.lfTimerStart = nil
			end

			-- LOW VOLTAGE ALERTS
			-- big conditional to announce neuronstatus.lvTimer if needed
			if neuronstatus.linkUP ~= 0 then
				if neuronstatus.idleupSwitchParam ~= nil then
					if neuronstatus.idleupSwitchParam:state() then
						if (neuronstatus.voltageIsLow and neuronstatus.alertonParam == 0) then
							neuronstatus.lvTimer = true
						elseif (neuronstatus.voltageIsLow and neuronstatus.alertonParam == 2) then
							neuronstatus.lvTimer = true
						else
							neuronstatus.lvTimer = false
						end
					else
						neuronstatus.lvTimer = false
					end
				else
					neuronstatus.lvTimer = false
				end
			else
				neuronstatus.lvTimer = false
			end

			if neuronstatus.lvTimer == true then
				-- start timer
				if neuronstatus.lvTimerStart == nil then neuronstatus.lvTimerStart = os.time() end
			else
				neuronstatus.lvTimerStart = nil
			end

			if neuronstatus.lvTimerStart ~= nil then
				if (os.time() - neuronstatus.lvTimerStart >= neuronstatus.sagParam) then
					-- only announce if we have been on for 5 seconds or more
					if (tonumber(os.clock()) - tonumber(neuronstatus.lvAudioAlertCounter)) >= neuronstatus.alertintParam then
						neuronstatus.lvAudioAlertCounter = os.clock()

						system.playFile(widgetDir .. "sounds/alerts/lowvoltage.wav")
						if alrthptParam == true then system.playHaptic("- . -") end

					end
				end
			else
				-- stop timer
				neuronstatus.lvTimerStart = nil
			end
			--

        else
            adjJUSTUP = true
        end
    end

    return
end

function neuronstatus.viewLogs()
    neuronstatus.showLOGS = true

end

function neuronstatus.menu(widget)

    return {
        {
            "View logs", function()
                neuronstatus.viewLogs()
            end
        }
    }

end

return neuronstatus
