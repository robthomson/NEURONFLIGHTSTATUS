local environment = system.getVersion()
local oldsensors = {
    "refresh",
    "voltage",
    "rpm",
    "current",
    "temp_esc",
    "fuel",
    "mah",
    "rssi",
}

neuronstatus = {}

local loopCounter = 0
local sensors
local supportedRADIO = false
local gfx_model
local gfx_default

local sensors = {}

local lvTimer = false
local lvTimerStart
local lvannounceTimer = false
local lvannounceTimerStart
local lvaudioannounceCounter = 0
local lvAudioAlertCounter = 0

local lfTimer = false
local lfTimerStart
local lfannounceTimer = false
local lfannounceTimerStart
local lfaudioannounceCounter = 0
local lfAudioAlertCounter = 0


local rpmTimer = false
local rpmTimerStart
local rpmannounceTimer = false
local rpmannounceTimerStart
local rpmaudioannounceCounter = 0

local currentTimer = false
local currentTimerStart
local currentannounceTimer = false
local currentannounceTimerStart
local currentaudioannounceCounter = 0

local lqTimer = false
local lqTimerStart
local lqannounceTimer = false
local lqannounceTimerStart
local lqaudioannounceCounter = 0

local fuelTimer = false
local fuelTimerStart
local fuelannounceTimer = false
local fuelannounceTimerStart
local fuelaudioannounceCounter = 0

local escTimer = false
local escTimerStart
local escannounceTimer = false
local escannounceTimerStart
local escaudioannounceCounter = 0

local mcuTimer = false
local mcuTimerStart
local mcuannounceTimer = false
local mcuannounceTimerStart
local mcuaudioannounceCounter = 0

local timerTimer = false
local timerTimerStart
local timerannounceTimer = false
local timerannounceTimerStart
local timeraudioannounceCounter = 0

local linkUP = 0
local refresh = true
local isInConfiguration = false

local stopTimer = true
local startTimer = false
local voltageIsLow = false
local fuelIsLow = false

local showLOGS=false
local readLOGS=false
local readLOGSlast = {}

local linkUPTime = 0





local miniBoxParam = 0
local lowvoltagStickParam = 0
local lowvoltagStickCutoffParam = 70
local fmsrcParam = 0
local btypeParam = 0
local lowfuelParam = 20
local alertintParam = 5
local alrthptcParam = 1
local maxminParam = true
local titleParam = true
local cellsParam = 6
local lowVoltageGovernorParam = true
local sagParam = 5
local announceVoltageSwitchParam = nil
local announceRPMSwitchParam = nil
local announceCurrentSwitchParam = nil
local announceFuelSwitchParam = nil	
local announceLQSwitchParam = nil
local announceESCSwitchParam = nil
local announceTimerSwitchParam = nil
local filteringParam = 1
local lowvoltagsenseParam = 2
local announceIntervalParam = 30
local alertonParam = 0
local calcfuelParam = true



local timerWASActive = false
local motorWasActive = false
local maxMinSaved = false

local simPreSPOOLUP=false
local simDoSPOOLUP=false
local simDODISARM=false
local simDoSPOOLUPCount = 0
local actTime

local maxminFinals1 = nil
local maxminFinals2 = nil
local maxminFinals3 = nil
local maxminFinals4 = nil
local maxminFinals5 = nil
local maxminFinals6 = nil
local maxminFinals7 = nil
local maxminFinals8 = nil

local noTelemTimer = 0

local closeButtonX = 0
local closeButtonY = 0 
local closeButtonW = 0
local closeButtonH = 0

local sensorVoltageMax = 0
local sensorVoltageMin = 0
local sensorFuelMin = 0
local sensorFuelMax = 0
local sensorRPMMin = 0
local sensorRPMMax = 0
local sensorCurrentMin = 0
local sensorCurrentMax = 0
local sensorTempESCMin = 0
local sensorTempESCMax = 0
local sensorRSSIMin = 0
local sensorRSSIMax = 0
local lastMaxMin = 0

-- defaults... we overwrite these in create
local voltageNoiseQ = 100
local fuelNoiseQ = 100
local rpmNoiseQ = 100
local temp_mcuNoiseQ = 100
local temp_escNoiseQ = 100
local rssiNoiseQ = 100
local currentNoiseQ = 100

local armSwitchParam
local idleupSwitchParam



local function create(widget)
    gfx_model = lcd.loadBitmap(model.bitmap())
    gfx_default = lcd.loadBitmap("/scripts/neuronstatus/gfx/default.png")
	gfx_close = lcd.loadBitmap("/scripts/neuronstatus/gfx/close.png")
    rssiSensor = neuronstatus.getRssiSensor()


    if tonumber(neuronstatus.sensorMakeNumber(environment.version)) < 152 then
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
		capacity = 1000,
    }
end

function loadScriptneuronstatus(script) 
	return loadfile(script) 
end

local function configure(widget)
    isInConfiguration = true


	triggerpanel = form.addExpansionPanel("Triggers")
	triggerpanel:open(false) 

    line = triggerpanel:addLine("Arm switch")
    form.addSwitchField(
        line,
        form.getFieldSlots(line)[0],
        function()
            return armSwitchParam
        end,
        function(value)
            armSwitchParam = value
        end
    )

    line = triggerpanel:addLine("Idleup switch")
    form.addSwitchField(
        line,
        form.getFieldSlots(line)[0],
        function()
            return idleupSwitchParam
        end,
        function(value)
            idleupSwitchParam = value
        end
    )
    


	batterypanel = form.addExpansionPanel("Battery Configuration")
	batterypanel:open(false) 

    -- CELLS
    line = batterypanel:addLine("Type")
    form.addChoiceField(
        line,
        nil,
        {
            {"LiPo", 0},
            {"LiHv", 1},
            {"Lion", 2},
            {"LiFe", 3},
            {"NiMh", 4}
        },
        function()
            return btypeParam
        end,
        function(newValue)
            btypeParam = newValue
        end
    )
	
    -- BATTERY CAPACITY
    line = batterypanel:addLine("Capacity")
    field =
        form.addNumberField(
        line,
        nil,
        0,
        20000,
        function()
            return capacityParam
        end,
        function(value)
            capacityParam = value
        end
    )
    field:default(1000)	
	field:suffix("mAh")


    -- BATTERY CELLS
    line = batterypanel:addLine("Cells")
    field =
        form.addNumberField(
        line,
        nil,
        0,
        14,
        function()
            return cellsParam
        end,
        function(value)
            cellsParam = value
        end
    )
    field:default(6)




   -- LOW FUEL announce
    line = batterypanel:addLine("Low fuel%")
    field =
        form.addNumberField(
        line,
        nil,
        0,
        50,
        function()
            return lowfuelParam
        end,
        function(value)
            lowfuelParam = value
        end
    )
    field:default(20)
	field:suffix("%")

    -- ALERT ON
    line = batterypanel:addLine("Play alert on")
    form.addChoiceField(
        line,
        nil,
        {{"Low voltage", 0}, {"Low fuel", 1},{"Low fuel & Low voltage", 2},{"Disabled", 3}},
        function()
            return alertonParam
        end,
        function(newValue)
			if newValue == 3 then
				plalrtint:enable(false)
				plalrthap:enable(false)
			else
				plalrtint:enable(true)
				plalrthap:enable(true)			
			end
            alertonParam = newValue
        end
    )

    -- ALERT INTERVAL
    line = batterypanel:addLine("     Interval")
    plalrtint = form.addChoiceField(
        line,
        nil,
        {{"5S", 5}, {"10S", 10}, {"15S", 15}, {"20S", 20}, {"30S", 30}},
        function()
            return alertintParam
        end,
        function(newValue)
            alertintParam = newValue
        end
    )
	if alertonParam == 3 then
		plalrtint:enable(false)
	else
		plalrtint:enable(true)	
	end	

    -- HAPTIC
    line = batterypanel:addLine("     Vibrate")
    plalrthap = form.addBooleanField(
        line,
        nil,
        function()
            return alrthptParam
        end,
        function(newValue)
            alrthptParam = newValue
        end
    )	
	if alertonParam == 3 then
		plalrthap:enable(false)
	else
		plalrthap:enable(true)	
	end	

	

	
	announcepanel = form.addExpansionPanel("Telemetry Announcements")
	announcepanel:open(false) 
	
    -- announce VOLTAGE READING
    line = announcepanel:addLine("Voltage")
    form.addSwitchField(
        line,
        form.getFieldSlots(line)[0],
        function()
            return announceVoltageSwitchParam
        end,
        function(value)
            announceVoltageSwitchParam = value
        end
    )

    -- announce RPM READING
    line = announcepanel:addLine("Rpm")
    form.addSwitchField(
        line,
        nil,
        function()
            return announceRPMSwitchParam
        end,
        function(value)
            announceRPMSwitchParam = value
        end
    )

    -- announce CURRENT READING
    line = announcepanel:addLine("Current")
    form.addSwitchField(
        line,
        nil,
        function()
            return announceCurrentSwitchParam
        end,
        function(value)
            announceCurrentSwitchParam = value
        end
    )

    -- announce FUEL READING
    line = announcepanel:addLine("Fuel")
    form.addSwitchField(
        line,
        form.getFieldSlots(line)[0],
        function()
            return announceFuelSwitchParam
        end,
        function(value)
            announceFuelSwitchParam = value
        end
    )

    -- announce LQ READING
    line = announcepanel:addLine("LQ")
    form.addSwitchField(
        line,
        form.getFieldSlots(line)[0],
        function()
            return announceLQSwitchParam
        end,
        function(value)
            announceLQSwitchParam = value
        end
    )

    -- announce LQ READING
    line = announcepanel:addLine("Temperature")
    form.addSwitchField(
        line,
        form.getFieldSlots(line)[0],
        function()
            return announceESCSwitchParam
        end,
        function(value)
            announceESCSwitchParam = value
        end
    )



    -- announce TIMER READING
    line = announcepanel:addLine("Timer")
    form.addSwitchField(
        line,
        form.getFieldSlots(line)[0],
        function()
            return announceTimerSwitchParam
        end,
        function(value)
            announceTimerSwitchParam = value
        end
    )

	displaypanel = form.addExpansionPanel("Customise Display")
	displaypanel:open(false) 



    -- TITLE DISPLAY
    line = displaypanel:addLine("Title")
    form.addBooleanField(
        line,
        nil,
        function()
            return titleParam
        end,
        function(newValue)
            titleParam = newValue
        end
    )

    -- MAX MIN DISPLAY
    line = displaypanel:addLine("Max/Min")
    form.addBooleanField(
        line,
        nil,
        function()
            return maxminParam
        end,
        function(newValue)
            maxminParam = newValue
        end
    )
	
	advpanel = form.addExpansionPanel("Advanced")
	advpanel:open(false) 



    line = advpanel:addLine("Temp. Conversion")
    form.addChoiceField(
        line,
        nil,
        {
			{"Disable", 1}, 
			{"°C -> °F", 2}, 
			{"°F -> °C", 3}, 
		},
        function()
            return tempconvertParamESC
        end,
        function(newValue)
            tempconvertParamESC = newValue
        end
    )
	

    line = form.addLine("Voltage",advpanel)
	
    -- LVannounce DISPLAY
    line = advpanel:addLine("    Sensitivity")
    form.addChoiceField(
        line,
        nil,
        {
			{"HIGH", 1}, 
			{"MEDIUM", 2}, 
			{"LOW", 3}
		},
        function()
            return lowvoltagsenseParam
        end,
        function(newValue)
            lowvoltagsenseParam = newValue
        end
    )

    line = advpanel:addLine("    Sag compensation")
    field =
        form.addNumberField(
        line,
        nil,
        0,
        10,
        function()
            return sagParam
        end,
        function(value)
            sagParam = value
        end
    )
    field:default(5)
	field:suffix("s")
	--field:decimals(1)


    -- FILTER
    -- MAX MIN DISPLAY
    line = advpanel:addLine("Telemetry Filtering")
    form.addChoiceField(
        line,
        nil,
        {
			{"LOW", 1}, 
			{"MEDIUM", 2}, 
			{"HIGH", 3}
		},
        function()
            return filteringParam
        end,
        function(newValue)
            filteringParam = newValue
        end
    )

   -- LVannounce DISPLAY
    line = advpanel:addLine("announce interval")
    form.addChoiceField(
        line,
        nil,
        {
			{"5s", 5}, 
			{"10s", 10}, 
			{"15s", 15}, 
			{"20s", 20}, 
			{"25s", 25}, 
			{"30s", 30},
			{"35s", 35}, 			
			{"40s", 40},
			{"45s", 45},
			{"50s", 50},
			{"55s", 55},
			{"60s", 60},
			{"No repeat", 50000}			
		},
        function()
            return announceIntervalParam
        end,
        function(newValue)
            announceIntervalParam = newValue
        end
    )



	neuronstatus.resetALL()

    return widget
end

function neuronstatus.getRssiSensor()
	if environment.simulation then
		return 100
	end

    local rssiNames = {"RSSI", "RSSI 2.4G", "RSSI 900M", "Rx RSSI1", "Rx RSSI2"}
    for i, name in ipairs(rssiNames) do
        rssiSensor = system.getSource(name)
        if rssiSensor then
            return rssiSensor
        end
    end
end

function neuronstatus.getRSSI()
	if environment.simulation == true then
		return 100
	end
    if rssiSensor ~= nil and rssiSensor:state() then
        return rssiSensor:value()
    end
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
	showLOGS = false
	sensorVoltageMax = 0
	sensorVoltageMin = 0
	sensorFuelMin = 0
	sensorFuelMax = 0
	sensorRPMMin = 0
	sensorRPMMax = 0
	sensorCurrentMin = 0
	sensorCurrentMax = 0
	sensorTempESCMin = 0
	sensorTempESCMax = 0
end

function neuronstatus.noTelem()



	lcd.font(FONT_STD)
	str = "NO DATA"
	
    local theme = neuronstatus.getThemeInfo()
    local w, h = lcd.getWindowSize()	
	boxW = math.floor(w / 2)
	boxH = 45
	tsizeW, tsizeH = lcd.getTextSize(str)

	--draw the backgneuronstatus.round
	if isDARKMODE then
		lcd.color(lcd.RGB(40, 40, 40))
	else
		lcd.color(lcd.RGB(240, 240, 240))
	end
	lcd.drawFilledRectangle(w / 2 - boxW / 2, h / 2 - boxH / 2, boxW, boxH)

	--draw the border
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
    environment = system.getVersion()
    local w, h = lcd.getWindowSize()

	-- this is just to force height calc to end up on whole numbers to avoid
	-- scaling issues
	h = (math.floor((h / 4))*4)
	w = (math.floor((w / 6))*6)

    if
        environment.board == "XES" or environment.board == "X20" or environment.board == "X20S" or
            environment.board == "X20PRO" or
            environment.board == "X20PROAW" or
           environment.board == "X20R" or
           environment.board == "X20RS" 		   
     then
        ret = {
            supportedRADIO = true,
            colSpacing = 4,
            fullBoxW = 262,
            fullBoxH = h / 2,
            smallBoxSensortextOFFSET = -5,
            title_voltage = "VOLTAGE",
            title_fuel = "FUEL",
            title_rpm = "RPM",
            title_current = "CURRENT",
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

    if environment.board == "X18" or environment.board == "X18S" then
        ret = {
            supportedRADIO = true,
            colSpacing = 2,
            fullBoxW = 158,
            fullBoxH = 97,
            smallBoxSensortextOFFSET = -8,
            title_voltage = "VOLTAGE",
            title_fuel = "FUEL",
            title_rpm = "RPM",
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

    if environment.board == "X14" or environment.board == "X14S" then
        ret = {
            supportedRADIO = true,
            colSpacing = 3,
            fullBoxW = 210,
            fullBoxH = 120,
            smallBoxSensortextOFFSET = -10,
            title_voltage = "VOLTAGE",
            title_fuel = "FUEL",
            title_rpm = "RPM",
            title_current = "CURRENT",
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

    if environment.board == "TWXLITE" or environment.board == "TWXLITES" then
        ret = {
            supportedRADIO = true,
            colSpacing = 2,
            fullBoxW = 158,
            fullBoxH = 96,
            smallBoxSensortextOFFSET = -10,
            title_voltage = "VOLTAGE",
            title_fuel = "FUEL",
            title_rpm = "RPM",
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

    if environment.board == "X10EXPRESS" then
        ret = {
            supportedRADIO = true,
            colSpacing = 2,
            fullBoxW = 158,
            fullBoxH = 79,
            smallBoxSensortextOFFSET = -10,
            title_voltage = "VOLTAGE",
            title_fuel = "FUEL",
            title_rpm = "RPM",
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



local function telemetryBox(x,y,w,h,title,value,unit,smallbox,alarm,minimum,maximum)

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
		
		sx = (x + w/2)-(tsizeW/2)
		if smallbox == nil or smallbox == false then
			sy = (y + h/2)-(tsizeH/2)
		else
			if maxminParam == false and titleParam == false then
			sy = (y + h/2)-(tsizeH/2) 	
			else
				sy = (y + h/2)-(tsizeH/2) + theme.smallBoxSensortextOFFSET
			end
		end

		if alarm == true then
			lcd.color(lcd.RGB(255, 0, 0, 1))
		end

		lcd.drawText(sx,sy, str)
		
		if alarm == true then
			if isDARKMODE then
				lcd.color(lcd.RGB(255, 255, 255, 1))
			else
				lcd.color(lcd.RGB(90, 90, 90))
			end		
		end	
		
	end	
	
	if title ~= nil and titleParam == true then
		lcd.font(theme.fontTITLE)
		str = title 
		tsizeW, tsizeH = lcd.getTextSize(str)
		
		sx = (x + w/2)-(tsizeW/2)
		sy = (y + h)-(tsizeH) - theme.colSpacing

		lcd.drawText(sx,sy, str)
	end	


	if maxminParam == true then	

		if minimum ~= nil then
		
			lcd.font(theme.fontTITLE)

			if tostring(minimum) ~= "-" then
					lastMin = minimum
			end

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
			sy = (y + h)-(tsizeH) - theme.colSpacing
			
			lcd.drawText(sx,sy, str)
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
			sy = (y + h)-(tsizeH) - theme.colSpacing

			lcd.drawText(sx,sy, str)
		end	

	end
	
end

function neuronstatus.logsBOX()

	

	if readLOGS == false then
		local history = neuronstatus.readHistory()	
		readLOGSlast = history
		readLOGS = true
	else	
		history = readLOGSlast
	end

    local theme = neuronstatus.getThemeInfo()
    local w, h = lcd.getWindowSize()
	if w < 500 then
		boxW = w
	else
		boxW = w - math.floor((w * 2)/100)	
	end
	if h < 200 then
		boxH = h-2
	else
		boxH = h - math.floor((h * 4)/100)
	end

	--draw the backgneuronstatus.round
	if isDARKMODE then
		lcd.color(lcd.RGB(40, 40, 40,50))
	else
		lcd.color(lcd.RGB(240, 240, 240,50))
	end
	lcd.drawFilledRectangle(w / 2 - boxW / 2, h / 2 - boxH / 2, boxW, boxH)

	--draw the border
	lcd.color(lcd.RGB(248, 176, 56))
	lcd.drawRectangle(w / 2 - boxW / 2, h / 2 - boxH / 2, boxW, boxH)

	--draw the title
	lcd.color(lcd.RGB(248, 176, 56))
	lcd.drawFilledRectangle(w / 2 - boxW / 2, h / 2 - boxH / 2, boxW, boxH/9)

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
	
	boxTh = boxH/9	
	boxTy = h / 2 - boxH / 2
	boxTx = w / 2 - boxW / 2
	lcd.drawText((w / 2) - tsizeW / 2, boxTy + (boxTh / 2) - tsizeH / 2, str)
	
	-- close button
    lcd.drawBitmap(boxTx + boxW - boxTh, boxTy, gfx_close, boxTh, boxTh)	
	closeButtonX = math.floor(boxTx + boxW - boxTh)
	closeButtonY = math.floor(boxTy) + theme.widgetTitleOffset
	closeButtonW = math.floor(boxTh)
	closeButtonH = math.floor(boxTh)

	lcd.color(lcd.RGB(255, 255, 255))
	



	--[[ header column format 
		TIME VOLTAGE AMPS RPM LQ MCU ESC
	]]--
	colW = boxW/7


	col1x = boxTx
	col2x = boxTx + theme.logsCOL1w
	col3x = boxTx + theme.logsCOL1w + theme.logsCOL2w
	col4x = boxTx + theme.logsCOL1w + theme.logsCOL2w + theme.logsCOL3w
	col5x = boxTx + theme.logsCOL1w + theme.logsCOL2w + theme.logsCOL3w + theme.logsCOL4w
	col6x = boxTx + theme.logsCOL1w + theme.logsCOL2w + theme.logsCOL3w + theme.logsCOL4w + theme.logsCOL5w

	
	lcd.color(lcd.RGB(90, 90, 90))

	--LINES
	lcd.drawLine(boxTx + boxTh/2, boxTy + (boxTh*2), boxTx + boxW - (boxTh/2), boxTy + (boxTh*2))
		
	lcd.drawLine(col2x, boxTy + boxTh + boxTh/2, col2x, boxTy + boxH - (boxTh/2))
	lcd.drawLine(col3x, boxTy + boxTh + boxTh/2, col3x, boxTy + boxH - (boxTh/2))		
	lcd.drawLine(col4x, boxTy + boxTh + boxTh/2, col4x, boxTy + boxH - (boxTh/2))
	lcd.drawLine(col5x, boxTy + boxTh + boxTh/2, col5x, boxTy + boxH - (boxTh/2))		
	lcd.drawLine(col6x, boxTy + boxTh + boxTh/2, col6x, boxTy + boxH - (boxTh/2))	

	
	--HEADER text
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
		lcd.drawText(col1x + (theme.logsCOL1w/2) - (tsizeW / 2), theme.logsHeaderOffset +(boxTy + boxTh)  + ((boxTh/2) - (tsizeH / 2)) , str)
	end

	if theme.logsCOL2w ~= 0 then
		str = "VOLTAGE"
		tsizeW, tsizeH = lcd.getTextSize(str)
		lcd.drawText((col2x) + (theme.logsCOL2w/2) - (tsizeW / 2), theme.logsHeaderOffset +(boxTy + boxTh)  + (boxTh/2) - (tsizeH / 2) , str)
	end
	
	if theme.logsCOL3w ~= 0 then	
		str = "AMPS"
		tsizeW, tsizeH = lcd.getTextSize(str)
		lcd.drawText((col3x) + (theme.logsCOL3w/2) - (tsizeW / 2), theme.logsHeaderOffset +(boxTy + boxTh)  + (boxTh/2) - (tsizeH / 2) , str)
	end

	if theme.logsCOL4w ~= 0 then
		str = "RPM"
		tsizeW, tsizeH = lcd.getTextSize(str)
		lcd.drawText((col4x) + (theme.logsCOL4w/2) - (tsizeW / 2), theme.logsHeaderOffset +(boxTy + boxTh)  + (boxTh/2) - (tsizeH / 2) , str)
	end

	if theme.logsCOL5w ~= 0 then
		str = "LQ"
		tsizeW, tsizeH = lcd.getTextSize(str)
		lcd.drawText((col5x) + (theme.logsCOL5w/2) - (tsizeW / 2), theme.logsHeaderOffset +(boxTy + boxTh)  + (boxTh/2) - (tsizeH / 2) , str)
	end


	if theme.logsCOL6w ~= 0 then	
		str = "ESC"
		tsizeW, tsizeH = lcd.getTextSize(str)
		lcd.drawText((col6x) + (theme.logsCOL6w/2) - (tsizeW / 2), theme.logsHeaderOffset +(boxTy + boxTh)  + (boxTh/2) - (tsizeH / 2) , str)
	end
	
	c = 0


	
	for index,value in ipairs(history) do
		

		if value ~= nil then
			if value ~= "" and value ~= nil then
				rowH = c * boxTh


				
				local rowData = neuronstatus.explode(value,",")
	
	
				--[[ rowData is a csv string as follows
				
						theTIME,sensorVoltageMin,sensorVoltageMax,sensorFuelMin,sensorFuelMax,
						sensorRPMMin,sensorRPMMax,sensorCurrentMin,sensorCurrentMax,sensorRSSIMin,
						sensorRSSIMax,sensorTempMCUMin,sensorTempMCUMax,sensorTempESCMin,sensorTempESCMax	
				]]--
				-- loop of rowData and extract each value bases on idx
				if rowData ~= nil then
				
					for idx,snsr in pairs(rowData) do
					
					
						snsr = snsr:gsub("%s+", "")
					
						if snsr ~= nil and snsr ~= "" then			
							-- time
							if idx == 1 and theme.logsCOL1w ~= 0 then
								str = neuronstatus.SecondsToClockAlt(snsr)
								tsizeW, tsizeH = lcd.getTextSize(str)
								lcd.drawText(col1x + (theme.logsCOL1w/2) - (tsizeW / 2), boxTy + tsizeH/2 + (boxTh *2) + rowH , str)
							end
							-- voltagemin
							if idx == 2 then
								vstr = snsr
							end
							-- voltagemax
							if idx == 3 and theme.logsCOL2w ~= 0 then
								str = neuronstatus.round(vstr/100,1) .. 'v / ' .. neuronstatus.round(snsr/100,1) .. 'v'
								tsizeW, tsizeH = lcd.getTextSize(str)
								lcd.drawText(col2x + (theme.logsCOL2w/2) - (tsizeW / 2), boxTy + tsizeH/2 + (boxTh *2) + rowH , str)	
							end			
							-- fuelmin
							if idx == 4 then
								local logFUELmin = snsr
							end					
							-- fuelmax
							if idx == 5 then
								local logFUELmax = snsr
							end					
							-- rpmmin
							if idx == 6 then
								rstr = snsr
							end					
							-- rpmmax
							if idx == 7 and theme.logsCOL4w ~= 0 then
								str = rstr .. 'rpm / ' .. snsr .. 'rpm'
								tsizeW, tsizeH = lcd.getTextSize(str)
								lcd.drawText(col4x + (theme.logsCOL4w/2) - (tsizeW / 2), boxTy + tsizeH/2 + (boxTh *2) + rowH , str)	
							end							
							-- currentmin
							if idx == 8 then
								cstr = snsr
							end					
							-- currentmax
							if idx == 9 and theme.logsCOL3w ~= 0 then
								str = neuronstatus.round(cstr/10,1) .. 'A / ' .. neuronstatus.round(snsr/10,1) .. 'A'
								tsizeW, tsizeH = lcd.getTextSize(str)
								lcd.drawText(col3x + (theme.logsCOL3w/2) - (tsizeW / 2), boxTy + tsizeH/2 + (boxTh *2) + rowH , str)	
							end							
							-- rssimin
							if idx == 10 then
								lqstr = snsr
								
							end					
							-- rssimax
							if idx == 11 and theme.logsCOL5w ~= 0 then
								str = lqstr .. '% / ' .. snsr .. '%'
								tsizeW, tsizeH = lcd.getTextSize(str)
								lcd.drawText(col5x + (theme.logsCOL5w/2) - (tsizeW / 2), boxTy + tsizeH/2 + (boxTh *2) + rowH , str)
							end									
							-- escmin
							if idx == 12 then
								escstr = snsr
							end					
							-- escmax
							if idx == 13 and theme.logsCOL6w ~= 0 then
								str = neuronstatus.round(escstr/100,0) .. '° / ' .. neuronstatus.round(snsr/100,0) .. '°'
								strf = neuronstatus.round(escstr/100,0) .. '. / ' .. neuronstatus.round(snsr/100,0) .. '.'
								tsizeW, tsizeH = lcd.getTextSize(strf)
								lcd.drawText(col6x + (theme.logsCOL6w/2) - (tsizeW / 2), boxTy + tsizeH/2 + (boxTh *2) + rowH , str)
							end
						end	
					-- end loop of each storage line		
					end			
					c = c+1
				
					if h < 200 then
						if c > 5 then
							break
						end						
					else
						if c > 6 then
							break
						end
					end
					--end of each log storage slot
				end
			end	
		end	
	end


	--lcd.drawText((w / 2) - tsizeW / 2, (h / 2) - tsizeH / 2, str)
return
end

local function telemetryBoxImage(x,y,w,h,gfx)

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

    lcd.drawBitmap(x, y, gfx, w-theme.colSpacing, h-theme.colSpacing)


end

local function paint(widget)

	

    isVisible = lcd.isVisible()
	isDARKMODE = lcd.darkMode()

    isInConfiguration = false

    --voltage detection
    if btypeParam ~= nil then
        if btypeParam == 0 then
            --LiPo
            cellVoltage = 3.6
        elseif btypeParam == 1 then
            --LiHv
            cellVoltage = 3.6
        elseif btypeParam == 2 then
            --Lion
            cellVoltage = 3
        elseif btypeParam == 3 then
            --LiFe
            cellVoltage = 2.9
        elseif btypeParam == 4 then
            --NiMh
            cellVoltage = 1.1
        else
            --LiPo (default)
            cellVoltage = 3.6
        end

        if sensors.voltage ~= nil then
			-- we use lowvoltagsenseParam is use to raise or lower sensitivity
			if lowvoltagsenseParam == 1 then
				zippo = 0.2
			elseif lowvoltagsenseParam == 2 then
				zippo = 0.1
			else
				zippo = 0
			end
            if sensors.voltage / 100 < ((cellVoltage * cellsParam)+zippo) then
                voltageIsLow = true
            else
                voltageIsLow = false
            end
        else
            voltageIsLow = false
        end
    end
	
	-- fuel detection
	if sensors.voltage ~= nil then
		if sensors.fuel < lowfuelParam then
			fuelIsLow = true
		else
			fuelIsLow = false
		end
	else
		fuelIsLow = false
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
            neuronstatus.screenError("UNKNOWN " .. environment.board)
            return
        end

        -- widget size
        if
            environment.board == "V20" or environment.board == "XES" or environment.board == "X20" or
                environment.board == "X20S" or
                environment.board == "X20PRO" or
                environment.board == "X20PROAW"
         then
            if w ~= 784 and h ~= 294 then
                neuronstatus.screenError("DISPLAY SIZE INVALID")
                return
            end
        end
        if environment.board == "X18" or environment.board == "X18S" then
            smallTEXT = true
            if w ~= 472 and h ~= 191 then
                neuronstatus.screenError("DISPLAY SIZE INVALID")
                return
            end
        end
        if environment.board == "X14" or environment.board == "X14S" then
            if w ~= 630 and h ~= 236 then
                neuronstatus.screenError("DISPLAY SIZE INVALID")
                return
            end
        end
        if environment.board == "TWXLITE" or environment.board == "TWXLITES" then
            if w ~= 472 and h ~= 191 then
                neuronstatus.screenError("DISPLAY SIZE INVALID")
                return
            end
        end
        if environment.board == "X10EXPRESS" then
            if w ~= 472 and h ~= 158 then
                neuronstatus.screenError("DISPLAY SIZE INVALID")
                return
            end
        end

        boxW = theme.fullBoxW - theme.colSpacing
        boxH = theme.fullBoxH - theme.colSpacing
		
        boxHs = theme.fullBoxH / 2 - theme.colSpacing
        boxWs = theme.fullBoxW / 2 - theme.colSpacing


		--IMAGE
		posX = 0
		posY = theme.colSpacing
		if gfx_model ~= nil then
			telemetryBoxImage(posX,posY,boxW,boxH,gfx_model)
		else
			telemetryBoxImage(posX,posY,boxW,boxH,gfx_default)
		end
		
		--FUEL
		if sensors.fuel ~= nil then
		
			posX =  boxW + theme.colSpacing + boxW + theme.colSpacing
			posY = theme.colSpacing
			sensorUNIT = "%"
			sensorWARN = false	
			smallBOX = false

			if fuelIsLow then
				sensorWARN = true	
			end
		
			sensorVALUE = sensors.fuel
		
			if sensors.fuel < 5 then
				sensorVALUE = "0"
			end
		
			if titleParam == true then
				sensorTITLE = "FUEL"
			else
				sensorTITLE = ""		
			end

			if sensorFuelMin == 0 or sensorFuelMin == nil or theTIME == 0 then
					sensorMIN = "-"
			else 
					sensorMIN = sensorFuelMin
			end
			
			if sensorFuelMax == 0 or sensorFuelMax == nil or theTIME == 0 then
					sensorMAX = "-"
			else 
					sensorMAX = sensorFuelMax
			end

			telemetryBox(posX,posY,boxW,boxH,sensorTITLE,sensorVALUE,sensorUNIT,smallBOX,sensorWARN,sensorMIN,sensorMAX)
		end

		--RPM
		if sensors.rpm ~= nil then
		
			posX = boxW + theme.colSpacing + boxW + theme.colSpacing
			posY = boxH+(theme.colSpacing*2)
			sensorUNIT = "rpm"
			sensorWARN = false
			smallBOX = false

			sensorVALUE = sensors.rpm
			
			if sensors.rpm < 5 then
				sensorVALUE = 0
			end
		
			if titleParam == true then
				sensorTITLE = theme.title_rpm
			else
				sensorTITLE = ""		
			end

			if sensorRPMMin == 0 or sensorRPMMin == nil or theTIME == 0 then
					sensorMIN = "-"
			else 
					sensorMIN = sensorRPMMin
			end
			
			if sensorRPMMax == 0 or sensorRPMMax == nil or theTIME == 0 then
					sensorMAX = "-"
			else 
					sensorMAX = sensorRPMMax
			end
			
			telemetryBox(posX,posY,boxW,boxH,sensorTITLE,sensorVALUE,sensorUNIT,smallBOX,sensorWARN,sensorMIN,sensorMAX)
		end

		--VOLTAGE
		if sensors.voltage ~= nil then
		
			posX = boxW + theme.colSpacing
			posY = theme.colSpacing
			sensorUNIT = "v"
			sensorWARN = false	
			smallBOX = false

			if voltageIsLow then
				sensorWARN = true	
			end
		
			sensorVALUE = sensors.voltage/100
			
			if sensorVALUE < 1 then
				sensorVALUE = 0
			end
		
			if titleParam == true then
				sensorTITLE = theme.title_voltage
			else
				sensorTITLE = ""		
			end

			if sensorVoltageMin == 0 or sensorVoltageMin == nil or theTIME == 0 then
					sensorMIN = "-"
			else 
					sensorMIN = sensorVoltageMin/100
			end
			
			if sensorVoltageMax == 0 or sensorVoltageMax == nil or theTIME == 0 then
					sensorMAX = "-"
			else 
					sensorMAX = sensorVoltageMax/100
			end
			
			telemetryBox(posX,posY,boxW,boxH,sensorTITLE,sensorVALUE,sensorUNIT,smallBOX,sensorWARN,sensorMIN,sensorMAX)
		end
		
		--CURRENT
		if sensors.current ~= nil then
		
		
			posX = boxW + theme.colSpacing
			posY =  boxH+(theme.colSpacing*2)
			sensorUNIT = "A"
			sensorWARN = false	
			smallBOX = false
	
	
			sensorVALUE = sensors.current/10
			if linkUP == 0 then
				sensorVALUE = 0
			else
				if sensorVALUE == 0 then
					sensorVALUE = 0.1
				end
			end
	
			if titleParam == true then
				sensorTITLE = theme.title_current
			else
				sensorTITLE = ""		
			end

			if sensorCurrentMin == 0 or sensorCurrentMin == nil or theTIME == 0 then
					sensorMIN = "-"
			else 
					sensorMIN = sensorCurrentMin/10
			end
			
			if sensorCurrentMax == 0 or sensorCurrentMax == nil or theTIME == 0 then
					sensorMAX = "-"
			else 
					sensorMAX = sensorCurrentMax/10
			end
	
			telemetryBox(posX,posY,boxW,boxH,sensorTITLE,sensorVALUE,sensorUNIT,smallBOX,sensorWARN,sensorMIN,sensorMAX)
		end		

		--TEMP ESC
		if sensors.temp_esc ~= nil and miniBoxParam == 0 then
		
			posX = 0
			posY =  boxH+(theme.colSpacing*2)+boxHs+theme.colSpacing
			sensorUNIT = "°"
			sensorWARN = false
			smallBOX = true	
	
			sensorVALUE = neuronstatus.round(sensors.temp_esc/100,0)
			
			if sensorVALUE < 1 then
				sensorVALUE = 0 
			end
		
			if titleParam == true then
				sensorTITLE = theme.title_tempESC
			else
				sensorTITLE = ""		
			end

			if sensorTempESCMin == 0 or sensorTempESCMin == nil  or theTIME == 0 then
					sensorMIN = "-"
			else 
					sensorMIN = neuronstatus.round(sensorTempESCMin/100,0)
			end
			
			if sensorTempESCMax == 0 or sensorTempESCMax == nil  or theTIME == 0 then
					sensorMAX = "-"
			else 
					sensorMAX = neuronstatus.round(sensorTempESCMax/100,0)
			end
	
			telemetryBox(posX,posY,boxWs,boxHs,sensorTITLE,sensorVALUE,sensorUNIT,smallBOX,sensorWARN,sensorMIN,sensorMAX)
		end	


		--RSSI
		if sensors.rssi ~= nil then
		

			posX = boxWs + theme.colSpacing
			posY =  boxH+(theme.colSpacing*2)+boxHs+theme.colSpacing
			sensorUNIT = "%"
			sensorWARN = false
			smallBOX = true	
			thisBoxW = boxWs
			thisBoxH = boxHs

	
			sensorVALUE = sensors.rssi
			
			if sensorVALUE < 1 then
				sensorVALUE = 0 
			end
			
			if titleParam == true then
				sensorTITLE = theme.title_rssi
			else
				sensorTITLE = ""		
			end

			if sensorRSSIMin == 0 or sensorRSSIMin == nil or theTIME == 0 then
					sensorMIN = "-"
			else 
					sensorMIN = sensorRSSIMin
			end

			if sensorRSSIMax == 0 or sensorRSSIMax == nil or theTIME == 0  then
					sensorMAX = "-"
			else 
					sensorMAX = sensorRSSIMax
			end
	
			telemetryBox(posX,posY,thisBoxW,thisBoxH,sensorTITLE,sensorVALUE,sensorUNIT,smallBOX,sensorWARN,sensorMIN,sensorMAX)
		end	

		-- TIMER

		posX = 0
		posY =  boxH+(theme.colSpacing*2)
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
		
		
		if titleParam == true then
			sensorTITLE = theme.title_time
		else
			sensorTITLE = ""		
		end		
	   
		sensorVALUE = str
	   
		telemetryBox(posX,posY,thisBoxW,thisBoxH,sensorTITLE,sensorVALUE,sensorUNIT,smallBOX,sensorWARN,sensorMIN,sensorMAX)



		--if linkUP == 0 then
        if linkUP == 0 then
			neuronstatus.noTelem()
		end
		
		if showLOGS then
			neuronstatus.logsBOX()
		end
			

	end


    -- TIME		

	if linkUP ~= 0 then
		if armSwitchParam ~= nil then
			if armSwitchParam:state() == false then
				stopTimer = true
				stopTIME = os.clock()
				timerNearlyActive = 1
				theTIME = 0
			end
		end	

		if idleupSwitchParam ~= nil then
			if idleupSwitchParam:state()  then
				if timerNearlyActive == 1 then
					timerNearlyActive = 0
					startTIME = os.clock()
				end
				if startTIME ~= nil then
					theTIME = os.clock() - startTIME
				end	
			end
		end
		
	end



	-- LOW FUEL ALERTS
    -- big conditional to announce lfTimer if needed

    if linkUP ~= 0 then
		if idleupSwitchParam ~= nil then
			if idleupSwitchParam:state() then
				if (sensors.fuel <= lowfuelParam and alertonParam == 1 ) then
					lfTimer = true
				elseif (sensors.fuel <= lowfuelParam and alertonParam == 2 )then
					lfTimer = true
				else
					lfTimer = false
				end
			else
				lfTimer = false
			end
		else
			lfTimer = false
		end
    else
        lfTimer = false
    end
	



    if lfTimer == true then
        --start timer
        if lfTimerStart == nil then
            lfTimerStart = os.time()
        end
    else
        lfTimerStart = nil
    end

    if lfTimerStart ~= nil then
            -- only announce if we have been on for 5 seconds or more
            if (tonumber(os.clock()) - tonumber(lfAudioAlertCounter)) >= alertintParam then
                lfAudioAlertCounter = os.clock()
				
				system.playFile("/scripts/neuronstatus/sounds/alerts/lowfuel.wav")

				if alrthptParam == true then
					system.playHaptic("- . -")
				end

            end
    else
        -- stop timer
        lfTimerStart = nil
    end

	-- LOW VOLTAGE ALERTS
    -- big conditional to announce lvTimer if needed
    if linkUP ~= 0 then
	   if idleupSwitchParam ~= nil then
		   if idleupSwitchParam:state() then
				if (voltageIsLow and alertonParam == 0) then
					lvTimer = true
				elseif 	(voltageIsLow and alertonParam == 2) then
					lvTimer = true
				else
					lvTimer = false
				end
			else
				lvTimer = false
			end
		else
				lvTimer = false
		end
    else
        lvTimer = false
    end

    if lvTimer == true then
        --start timer
        if lvTimerStart == nil then
            lvTimerStart = os.time()
        end
    else
        lvTimerStart = nil
    end

    if lvTimerStart ~= nil then
        if (os.time() - lvTimerStart >= sagParam) then
            -- only announce if we have been on for 5 seconds or more
            if (tonumber(os.clock()) - tonumber(lvAudioAlertCounter)) >= alertintParam then
                lvAudioAlertCounter = os.clock()
				

				system.playFile("/scripts/neuronstatus/sounds/alerts/lowvoltage.wav")
				if alrthptParam == true then
					system.playHaptic("- . -")
				end

	
            end
        end
    else
        -- stop timer
        lvTimerStart = nil
    end
	
	
	
end

function neuronstatus.ReverseTable(t)
    local reversedTable = {}
    local itemCount = #t
    for k, v in ipairs(t) do
        reversedTable[itemCount + 1 - k] = v
    end
    return reversedTable
end

local function getChannelValue(ich)
  local src = system.getSource ({category=CATEGORY_CHANNEL, member=(ich-1), options=0})
  return math.floor ((src:value() / 10.24) +0.5)
end


function neuronstatus.getSensors()
    if isInConfiguration == true then
        return oldsensors
    end

    if environment.simulation == true then
	
		lcd.resetFocusTimeout()	

		tv = math.random(2100, 2274)
		voltage = tv
		temp_esc = math.random(500, 2250)*10
		rpm = math.random(10, 2250)
		mah = math.random(0, 10)
		current = math.random(10, 22)
		fuel = 0
		fm = "DISABLED"
		rssi = math.random(90, 100)	
		adjsource = 0
		adjvalue = 0

		
    elseif linkUP ~= 0 then
	
        local telemetrySOURCE = system.getSource("Rx RSSI1")
		

            -- we are run sport	
			-- set sources for everthing below
			--print("SPORT")

			voltageSOURCE = system.getSource("ESC voltage")
			rpmSOURCE = system.getSource("ESC RPM")
			currentSOURCE = system.getSource("ESC current")
			temp_escSOURCE = system.getSource("ESC temp")
			mahSOURCE = system.getSource("ESC consumption")

			
			-- we dont actually have a fuel sensor; so we calculate one

            --voltageSOURCE = system.getSource("VFAS")
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

            rssi = linkUP
						
    else
        -- we have no link.  do something
		--print("NO LINK")
		-- keep looking for new sensor
		rssiSensor = neuronstatus.getRssiSensor()
		
        voltage = 0
        rpm = 0
        current = 0
        temp_esc = 0
        temp_mcu = 0
        fuel = 0
        mah = 0
        rssi = linkUP

    end


	-- convert from C to F
	-- Divide by 5, then multiply by 9, then add 32
	if tempconvertParamESC == 2 then
		temp_esc = ((temp_esc/5) * 9) + 32
		temp_esc = neuronstatus.round(temp_esc,0)
	end
	-- convert from F to C
	-- Deduct 32, then multiply by 5, then divide by 9
	if tempconvertParamESC == 3 then
		temp_esc = ((temp_esc - 32) * 5)/9
		temp_esc = neuronstatus.round(temp_esc,0)	
	end	


    -- set flag to refresh screen or not

    voltage = neuronstatus.kalmanVoltage(voltage, oldsensors.voltage)
    voltage = neuronstatus.round(voltage, 0)

    rpm = neuronstatus.kalmanRPM(rpm, oldsensors.rpm)
    rpm = neuronstatus.round(rpm, 0)

    temp_esc = neuronstatus.kalmanTempESC(temp_esc, oldsensors.temp_esc)
    temp_esc = neuronstatus.round(temp_esc, 0)

    current = neuronstatus.kalmanCurrent(current, oldsensors.current)
    current = neuronstatus.round(current, 0)

    rssi = neuronstatus.kalmanRSSI(rssi, oldsensors.rssi)
    rssi = neuronstatus.round(rssi, 0)
	
	
	--calc fuel as this is based on pack capacity
	if capacityParam ~= nil then
		-- used percentage is
		local percentUsed = (mah /capacityParam) * 100
		local percentLeft = 100 - percentUsed
		fuel = neuronstatus.round(percentLeft,0)
		
	else
		fuel = 0
	end
	
	if linkUP == 0 then
		fuel = 0
	end

    if oldsensors.voltage ~= voltage then
        refresh = true
    end
    if oldsensors.rpm ~= rpm then
        refresh = true
    end
    if oldsensors.current ~= current then
        refresh = true
    end
    if oldsensors.temp_esc ~= temp_esc then
        refresh = true
    end

    if oldsensors.fuel ~= fuel then
        refresh = true
    end
    if oldsensors.mah ~= mah then
        refresh = true
    end
    if oldsensors.rssi ~= rssi then
        refresh = true
    end



    ret = {
        fm = fm,
        voltage = voltage,
        rpm = rpm,
        current = current,
        temp_esc = temp_esc,
        fuel = fuel,
        mah = mah,
        rssi = rssi,
    }
    oldsensors = ret

    return ret
end




local function sensorsMAXMIN(sensors)


    if linkUP ~= 0 and theTIME ~= nil then

		if  theTIME <= 5 then
			sensorVoltageMin = 0
			sensorVoltageMax = 0
			sensorFuelMin = 0
			sensorFuelMax = 0
			sensorRPMMin = 0
			sensorRPMMax = 0
			sensorCurrentMin = 0
			sensorCurrentMax = 0
			sensorRSSIMin = 0
			sensorRSSIMax = 0
			sensorTempESCMin = 0
			sensorTempESCMax = 0
		end
	
        if theTIME > 5 then


			if theTIME >= 5 and theTIME <= 10 then
				sensorVoltageMin = sensors.voltage
				sensorVoltageMax = sensors.voltage
				sensorFuelMin = sensors.fuel
				sensorFuelMax = sensors.fuel
				sensorRPMMin = sensors.rpm
				sensorRPMMax = sensors.rpm
				if sensors.current == 0 then
					sensorCurrentMin = 1
				else
					sensorCurrentMin = sensors.current
				end
				sensorCurrentMax = sensors.current

				sensorRSSIMin = sensors.rssi
				sensorRSSIMax = sensors.rssi
				sensorTempESCMin = sensors.temp_esc
				sensorTempESCMax = sensors.temp_esc
				motorNearlyActive = 0
			end
			

			if theTIME >= 10 and idleupSwitchParam:state() == true then

				if sensors.voltage < sensorVoltageMin then
					sensorVoltageMin = sensors.voltage
				end
				if sensors.voltage > sensorVoltageMax then
					sensorVoltageMax = sensors.voltage
				end

				if sensors.fuel < sensorFuelMin then
					sensorFuelMin = sensors.fuel
				end
				if sensors.fuel > sensorFuelMax then
					sensorFuelMax = sensors.fuel
				end

				if sensors.rpm < sensorRPMMin then
					sensorRPMMin = sensors.rpm
				end
				if sensors.rpm > sensorRPMMax then
					sensorRPMMax = sensors.rpm
				end
				if sensors.current < sensorCurrentMin then
					sensorCurrentMin = sensors.current
					if sensorCurrentMin == 0 then
						sensorCurrentMin = 1
					end
				end
				if sensors.current > sensorCurrentMax then
					sensorCurrentMax = sensors.current
				end
				if sensors.rssi < sensorRSSIMin then
					sensorRSSIMin = sensors.rssi
				end
				if sensors.rssi > sensorRSSIMax then
					sensorRSSIMax = sensors.rssi
				end
				if sensors.temp_esc < sensorTempESCMin then
					sensorTempESCMin = sensors.temp_esc
				end
				if sensors.temp_esc > sensorTempESCMax then
					sensorTempESCMax = sensors.temp_esc
				end
				motorWasActive = true
			end	
				
				
        end
		

	
		
		-- store the last values
		if motorWasActive and idleupSwitchParam:state() == false then
		
		
			motorWasActive = false	

			local maxminFinals = neuronstatus.readHistory()	

			if sensorCurrentMin == 0 then
				sensorCurrentMinAlt = 1
			else
				sensorCurrentMinAlt = sensorCurrentMin
			end
			if sensorCurrentMax == 0 then
				sensorCurrentMaxAlt = 1
			else
				sensorCurrentMaxAlt = sensorCurrentMax
			end			

			local maxminRow = theTIME .. "," 
						.. sensorVoltageMin .. "," 
						.. sensorVoltageMax .. ","
						.. sensorFuelMin .. ","
						.. sensorFuelMax .. ","
						.. sensorRPMMin .. ","
						.. sensorRPMMax .. ","
						.. sensorCurrentMinAlt .. ","
						.. sensorCurrentMaxAlt .. ","
						.. sensorRSSIMin .. ","
						.. sensorRSSIMax .. ","
						.. sensorTempESCMin .. ","
						.. sensorTempESCMax
		
			--print("Last data: ".. maxminRow )

			table.insert(maxminFinals,1,maxminRow)
			if tablelength(maxminFinals) >= 9 then
				table.remove(maxminFinals,9)			
			end



			name = string.gsub(model.name(), "%s+", "_")	
			name = string.gsub(name, "%W", "_")		
		
			file = "/scripts/neuronstatus/logs/" .. name .. ".log"	
			f = io.open(file,'w')
			f:write("")
			io.close(f)	

			--print("Writing history to: " .. file)
			
			f = io.open(file,'a')
			for k,v in ipairs(maxminFinals) do
				if v ~= nil then
					v = v:gsub("%s+", "")
					--if v ~= "" then
						--print(v)
						f:write(v .. "\n")
					--end
				end
			end
			io.close(f)			
		
			readLOGS = false	
			
		end		
		
    else
        sensorVoltageMax = 0
        sensorVoltageMin = 0
        sensorFuelMin = 0
        sensorFuelMax = 0
        sensorRPMMin = 0
        sensorRPMMax = 0
        sensorCurrentMin = 0
        sensorCurrentMax = 0
        sensorTempESCMin = 0
        sensorTempESCMax = 0
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

    if(indentLevel == nil) then
        print(print_r(arr, 0))
        return
    end

    for i = 0, indentLevel do
        indentStr = indentStr.."\t"
    end

    for index,value in ipairs(arr) do
        if type(value) == "table" then
            str = str..indentStr..index..": \n"..print_r(value, (indentLevel + 1))
        else 
            str = str..indentStr..index..": "..value.."\n"
        end
    end
    return str
end

local function updateFILTERING()
	if filteringParam == 2 then
		--print("Filtering: medium")
		local voltageNoiseQ = 150
		local fuelNoiseQ = 150
		local rpmNoiseQ = 150
		local temp_mcuNoiseQ = 150
		local temp_escNoiseQ = 150
		local rssiNoiseQ = 150
		local currentNoiseQ = 150
	elseif filteringParam == 3 then
		--print("Filtering: high")
		local voltageNoiseQ = 200
		local fuelNoiseQ = 200
		local rpmNoiseQ = 200
		local temp_mcuNoiseQ = 200
		local temp_escNoiseQ = 200
		local rssiNoiseQ = 200
		local currentNoiseQ = 200
	else
		--print("Filtering: low")
		local voltageNoiseQ = 100
		local fuelNoiseQ = 100
		local rpmNoiseQ = 100
		local temp_mcuNoiseQ = 100
		local temp_escNoiseQ = 100
		local rssiNoiseQ = 100
		local currentNoiseQ = 100
	end
end

function neuronstatus.kalmanCurrent(new, old)
    if old == nil then
        old = 0
    end
    if new == nil then
        new = 0
    end
    x = old
    local p = 100
    local k = 0
    p = p + 0.05
    k = p / (p + currentNoiseQ)
    x = x + k * (new - x)
    p = (1 - k) * p
    return x
end

function neuronstatus.kalmanRSSI(new, old)
    if old == nil then
        old = 0
    end
    if new == nil then
        new = 0
    end
    x = old
    local p = 100
    local k = 0
    p = p + 0.05
    k = p / (p + rssiNoiseQ)
    x = x + k * (new - x)
    p = (1 - k) * p
    return x
end



function neuronstatus.kalmanTempESC(new, old)
    if old == nil then
        old = 0
    end
    if new == nil then
        new = 0
    end
    x = old
    local p = 100
    local k = 0
    p = p + 0.05
    k = p / (p + temp_escNoiseQ)
    x = x + k * (new - x)
    p = (1 - k) * p
    return x
end

function neuronstatus.kalmanRPM(new, old)
    if old == nil then
        old = 0
    end
    if new == nil then
        new = 0
    end
    x = old
    local p = 100
    local k = 0
    p = p + 0.05
    k = p / (p + rpmNoiseQ)
    x = x + k * (new - x)
    p = (1 - k) * p
    return x
end

function neuronstatus.kalmanVoltage(new, old)
    if old == nil then
        old = 0
    end
    if new == nil then
        new = 0
    end
    x = old
    local p = 100
    local k = 0
    p = p + 0.05
    k = p / (p + voltageNoiseQ)
    x = x + k * (new - x)
    p = (1 - k) * p
    return x
end

function neuronstatus.sensorMakeNumber(x)
    if x == nil or x == "" then
        x = 0
    end

    x = string.gsub(x, "%D+", "")
    x = tonumber(x)
    if x == nil or x == "" then
        x = 0
    end

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
        return  mins .. ":" .. secs
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
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function neuronstatus.explode (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
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
	--print("Reading history")
	
	name = string.gsub(model.name(), "%s+", "_")	
	name = string.gsub(name, "%W", "_")
	file = "/scripts/neuronstatus/logs/" .. name .. ".log"
	local f = io.open(file, "rb")
	
	if f ~= nil then
		--file exists
		local rData
		c = 0
		tc = 1
		while c <= 10 do
			if c == 0 then
				rData = io.read(f,"l")
			else
				rData = io.read(f,"L")
			end
			if rData ~= "" or rData ~= nil then
				history[tc] = rData
				tc = tc+1
			end
			c = c+1
		end
		io.close(f)
	else
		return history
	end	


	return history
		
	

end



local function read()
		btypeParam = storage.read("btype")
		capacityParam = storage.read("capacity")
		cellsParam = storage.read("cells")
		lowfuelParam = storage.read("lowfuel")
		alertonParam = storage.read("alerton")
		alertintParam = storage.read("alertint")
		alrthptParam = storage.read("alrthptc")		
		announceVoltageSwitchParam = storage.read("announceswitchvltg")	
		announceRPMSwitchParam = storage.read("announceswitchrpm")
		announceCurrentSwitchParam = storage.read("announceswitchcrnt")
		announceFuelSwitchParam = storage.read("announceswitchfuel")		
		announceLQSwitchParam = storage.read("announceswitchlq")
		announceESCSwitchParam = storage.read("announceswitchesc")
		announceTimerSwitchParam = storage.read("announceswitchtmr")
		titleParam = storage.read("title")		
		maxminParam = storage.read("maxmin")
		tempconvertParamESC = storage.read("tempconvertesc")		
		lowvoltagsenseParam = storage.read("lvsense")
		sagParam = storage.read("sag")	
		filteringParam = storage.read("filtering")		
		announceIntervalParam = storage.read("announceint")		
		armSwitchParam = storage.read("armswitch")
		idleupSwitchParam = storage.read("idleupswitch")

		neuronstatus.resetALL()
		updateFILTERING()		
end

local function write()


		storage.write("btype", btypeParam)
		storage.write("capacity", capacityParam)
		storage.write("cells", cellsParam)
		storage.write("lowfuel", lowfuelParam)
		storage.write("alerton",alertonParam)
		storage.write("alertint", alertintParam)
		storage.write("alrthptc", alrthptParam)
		storage.write("announceswitchvltg", announceVoltageSwitchParam)
		storage.write("announceswitchrpm",announceRPMSwitchParam)
		storage.write("announceswitchcrnt",announceCurrentSwitchParam)
		storage.write("announceswitchfuel",announceFuelSwitchParam)		
		storage.write("announceswitchlq",announceLQSwitchParam)		
		storage.write("announceswitchesc",announceESCSwitchParam)		
		storage.write("announceswitchtmr",announceTimerSwitchParam)	
		storage.write("title", titleParam)
		storage.write("maxmin", maxminParam)
		storage.write("tempconvertesc",tempconvertParamESC)
		storage.write("lvsense",lowvoltagsenseParam)
		storage.write("sag",sagParam)
		storage.write("filtering",filteringParam)
		storage.write("announceint",announceIntervalParam)
		storage.write("armswitch",armSwitchParam)
		storage.write("idleupswitch",idleupSwitchParam)
		
		
		updateFILTERING()		
end

function neuronstatus.playCurrent(widget)
    if announceCurrentSwitchParam ~= nil then
        if announceCurrentSwitchParam:state() then
            currentannounceTimer = true
            currentDoneFirst = false
        else
            currentannounceTimer = false
            currentDoneFirst = true
        end

        if isInConfiguration == false then
            if sensors.current ~= nil then
                if currentannounceTimer == true then
                    --start timer
                    if currentannounceTimerStart == nil and currentDoneFirst == false then
                        currentannounceTimerStart = os.time()
						currentaudioannounceCounter = os.clock()
						--print ("Play Current Alert (first)")
                        system.playNumber(sensors.current/10, UNIT_AMPERE, 2)
                        currentDoneFirst = true
                    end
                else
                    currentannounceTimerStart = nil
                end

                if currentannounceTimerStart ~= nil then
                    if currentDoneFirst == false then
                        if ((tonumber(os.clock()) - tonumber(currentaudioannounceCounter)) >= announceIntervalParam) then
							--print ("Play Current Alert (repeat)")
                            currentaudioannounceCounter = os.clock()
                            system.playNumber(sensors.current/10, UNIT_AMPERE, 2)
                        end
                    end
                else
                    -- stop timer
                    currentannounceTimerStart = nil
                end
            end
        end
    end
end

function neuronstatus.playLQ(widget)
    if announceLQSwitchParam ~= nil then
        if announceLQSwitchParam:state() then
            lqannounceTimer = true
            lqDoneFirst = false
        else
            lqannounceTimer = false
            lqDoneFirst = true
        end

        if isInConfiguration == false then
            if sensors.rssi ~= nil then
                if lqannounceTimer == true then
                    --start timer
                    if lqannounceTimerStart == nil and lqDoneFirst == false then
                        lqannounceTimerStart = os.time()
						lqaudioannounceCounter = os.clock()
						--print ("Play LQ Alert (first)")
						system.playFile("/scripts/neuronstatus/sounds/alerts/lq.wav")						
                        system.playNumber(sensors.rssi, UNIT_PERCENT, 2)
                        lqDoneFirst = true
                    end
                else
                    lqannounceTimerStart = nil
                end

                if lqannounceTimerStart ~= nil then
                    if lqDoneFirst == false then
                        if ((tonumber(os.clock()) - tonumber(lqaudioannounceCounter)) >= announceIntervalParam) then
                            lqaudioannounceCounter = os.clock()
							--print ("Play LQ Alert (repeat)")
							system.playFile("/scripts/neuronstatus/sounds/alerts/lq.wav")
                            system.playNumber(sensors.rssi, UNIT_PERCENT, 2)
                        end
                    end
                else
                    -- stop timer
                    lqannounceTimerStart = nil
                end
            end
        end
    end
end

function neuronstatus.playESC(widget)
    if announceESCSwitchParam ~= nil then
        if announceESCSwitchParam:state() then
            escannounceTimer = true
            escDoneFirst = false
        else
            escannounceTimer = false
            escDoneFirst = true
        end

        if isInConfiguration == false then
            if sensors.temp_esc ~= nil then
                if escannounceTimer == true then
                    --start timer
                    if escannounceTimerStart == nil and escDoneFirst == false then
                        escannounceTimerStart = os.time()
						escaudioannounceCounter = os.clock()
						--print ("Playing ESC (first)")
						system.playFile("/scripts/neuronstatus/sounds/alerts/esc.wav")
                        system.playNumber(sensors.temp_esc/100, UNIT_DEGREE, 2)
                        escDoneFirst = true
                    end
                else
                    escannounceTimerStart = nil
                end

                if escannounceTimerStart ~= nil then
                    if escDoneFirst == false then
                        if ((tonumber(os.clock()) - tonumber(escaudioannounceCounter)) >= announceIntervalParam) then
                            escaudioannounceCounter = os.clock()
							--print ("Playing ESC (repeat)")
							system.playFile("/scripts/neuronstatus/sounds/alerts/esc.wav")
                            system.playNumber(sensors.temp_esc/100, UNIT_DEGREE, 2)
                        end
                    end
                else
                    -- stop timer
                    escannounceTimerStart = nil
                end
            end
        end
    end
end

function neuronstatus.playTIMER(widget)
    if announceTimerSwitchParam ~= nil then

        if announceTimerSwitchParam:state() then
            timerannounceTimer = true
            timerDoneFirst = false
        else
            timerannounceTimer = false
            timerDoneFirst = true
        end

        if isInConfiguration == false then
		
			if theTIME == nil then
				alertTIME = 0
			else
				alertTIME = theTIME
			end
		
		
            if alertTIME ~= nil then
			
			    hours = string.format("%02.f", math.floor(alertTIME / 3600))
				mins = string.format("%02.f", math.floor(alertTIME / 60 - (hours * 60)))
				secs = string.format("%02.f", math.floor(alertTIME - hours * 3600 - mins * 60))
			
                if timerannounceTimer == true then
                    --start timer
                    if timerannounceTimerStart == nil and timerDoneFirst == false then
                        timerannounceTimerStart = os.time()
						timeraudioannounceCounter = os.clock()
						--print ("Playing TIMER (first)" .. alertTIME)
	
						if mins ~= "00" then
							system.playNumber(mins, UNIT_MINUTE, 2)
						end
						system.playNumber(secs, UNIT_SECOND, 2)

                        timerDoneFirst = true
                    end
                else
                    timerannounceTimerStart = nil
                end

                if timerannounceTimerStart ~= nil then
                    if timerDoneFirst == false then
                        if ((tonumber(os.clock()) - tonumber(timeraudioannounceCounter)) >= announceIntervalParam) then
                            timeraudioannounceCounter = os.clock()
							--print ("Playing TIMER (repeat)" .. alertTIME)
							if mins ~= "00" then
								system.playNumber(mins, UNIT_MINUTE, 2)
							end
							system.playNumber(secs, UNIT_SECOND, 2)
                        end
                    end
                else
                    -- stop timer
                    timerannounceTimerStart = nil
                end
            end
        end
    end
end

function neuronstatus.playFuel(widget)
    if announceFuelSwitchParam ~= nil then
        if announceFuelSwitchParam:state() then
            fuelannounceTimer = true
            fuelDoneFirst = false
        else
            fuelannounceTimer = false
            fuelDoneFirst = true
        end

        if isInConfiguration == false then
            if sensors.fuel ~= nil then
                if fuelannounceTimer == true then
                    --start timer
                    if fuelannounceTimerStart == nil and fuelDoneFirst == false then
                        fuelannounceTimerStart = os.time()
						fuelaudioannounceCounter = os.clock()
						--print("Play fuel alert (first)")
						system.playFile("/scripts/neuronstatus/sounds/alerts/fuel.wav")	
                        system.playNumber(sensors.fuel, UNIT_PERCENT, 2)				
                        fuelDoneFirst = true
                    end
                else
                    fuelannounceTimerStart = nil
                end

                if fuelannounceTimerStart ~= nil then
                    if fuelDoneFirst == false then
                        if ((tonumber(os.clock()) - tonumber(fuelaudioannounceCounter)) >= announceIntervalParam) then
                            fuelaudioannounceCounter = os.clock()
							--print("Play fuel alert (repeat)")
							system.playFile("/scripts/neuronstatus/sounds/alerts/fuel.wav")	
                            system.playNumber(sensors.fuel, UNIT_PERCENT, 2)
													
                        end
                    end
                else
                    -- stop timer
                    fuelannounceTimerStart = nil
                end
            end
        end
    end
end

function neuronstatus.playRPM(widget)
    if announceRPMSwitchParam ~= nil then
        if announceRPMSwitchParam:state() then
            rpmannounceTimer = true
            rpmDoneFirst = false
        else
            rpmannounceTimer = false
            rpmDoneFirst = true
        end

        if isInConfiguration == false then
            if sensors.rpm ~= nil then
                if rpmannounceTimer == true then
                    --start timer
                    if rpmannounceTimerStart == nil and rpmDoneFirst == false then
                        rpmannounceTimerStart = os.time()
						rpmaudioannounceCounter = os.clock()
						--print("Play rpm alert (first)")
                        system.playNumber(sensors.rpm, UNIT_RPM, 2)
                        rpmDoneFirst = true
                    end
                else
                    rpmannounceTimerStart = nil
                end

                if rpmannounceTimerStart ~= nil then
                    if rpmDoneFirst == false then
                        if ((tonumber(os.clock()) - tonumber(rpmaudioannounceCounter)) >= announceIntervalParam) then
							--print("Play rpm alert (repeat)")
                            rpmaudioannounceCounter = os.clock()
                            system.playNumber(sensors.rpm, UNIT_RPM, 2)
                        end
                    end
                else
                    -- stop timer
                    rpmannounceTimerStart = nil
                end
            end
        end
    end
end

function neuronstatus.playVoltage(widget)
    if announceVoltageSwitchParam ~= nil then
        if announceVoltageSwitchParam:state() then
            lvannounceTimer = true
            voltageDoneFirst = false
        else
            lvannounceTimer = false
            voltageDoneFirst = true
        end

        if isInConfiguration == false then
            if sensors.voltage ~= nil then
                if lvannounceTimer == true then
                    --start timer
                    if lvannounceTimerStart == nil and voltageDoneFirst == false then
                        lvannounceTimerStart = os.time()
						lvaudioannounceCounter = os.clock()
						--print("Play voltage alert (first)")
						--system.playFile("/scripts/neuronstatus/sounds/alerts/voltage.wav")						
                        system.playNumber(sensors.voltage / 100, 2, 2)
                        voltageDoneFirst = true
                    end
                else
                    lvannounceTimerStart = nil
                end

                if lvannounceTimerStart ~= nil then
                    if voltageDoneFirst == false then
                        if ((tonumber(os.clock()) - tonumber(lvaudioannounceCounter)) >= announceIntervalParam) then
                            lvaudioannounceCounter = os.clock()
							--print("Play voltage alert (repeat)")
							--system.playFile("/scripts/neuronstatus/sounds/alerts/voltage.wav")								
                            system.playNumber(sensors.voltage / 100, 2, 2)
                        end
                    end
                else
                    -- stop timer
                    lvannounceTimerStart = nil
                end
            end
        end
    end
end

local function event(widget, category, value, x, y)

	--print("Event received:", category, value, x, y)
	
	-- disable menu if armed active
	if armSwitchParam ~= nil then
		if armSwitchParam:state() then
			if category == EVT_TOUCH then
				return true
			end
		end	
	end	

	if closingLOGS then
		if category == EVT_TOUCH and (value == 16640 or value == 16641)  then				
				closingLOGS = false
				return true
		end	
		
	end
			
	if showLOGS then
		if value == 35 then
			showLOGS = false
		end
		
		if category == EVT_TOUCH and (value == 16640 or value == 16641)  then		
			if (x >= (closeButtonX) and  (x <= (closeButtonX + closeButtonW))) and 
			   (y >= (closeButtonY) and  (y <= (closeButtonY + closeButtonH))) then
				showLOGS = false		
				closingLOGS = true
			end
			return true
		else
			if category == EVT_TOUCH then
				return true
			end
		end	
		
	end
	

  
end



armState = false
idleState = false
local function wakeup(widget)
    refresh = false

    linkUP = neuronstatus.getRSSI()
    sensors = neuronstatus.getSensors()
	
    if refresh == true then
        sensorsMAXMIN(sensors)	
        lcd.invalidate()
    end
	
	if linkUP == 0 then
		linkUPTime = os.clock()
	end
	
	if linkUP ~= 0 then


		if armSwitchParam ~= nil and armSwitchParam:state() == true and armState == false then
			system.playFile("/scripts/neuronstatus/sounds/triggers/armed.wav")
			armState = true
		end
		if armSwitchParam ~= nil and armSwitchParam:state() == false and armState == true then
			system.playFile("/scripts/neuronstatus/sounds/triggers/disarmed.wav")
			armState = false
		end

		if idleupSwitchParam ~= nil and idleupSwitchParam:state() == true and idleState == false then
			system.playFile("/scripts/neuronstatus/sounds/triggers/thr-active.wav")
			idleState = true
		end
		if idleupSwitchParam ~= nil and idleupSwitchParam:state() == false and idleState == true then
			system.playFile("/scripts/neuronstatus/sounds/triggers/thr-hold.wav")
			idleState = false
		end
		
	
		 if ((tonumber(os.clock()) - tonumber(linkUPTime)) >= 5) then
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

		else
			adjJUSTUP = true	
		end	
	end
	
    return
end

local function viewLogs()
	showLOGS = true
	
end

local function menu(widget)

return {
      { "View logs", function() viewLogs() end},
    }
	
end


local function init()
    system.registerWidget(
        {
            key = "zxkss",
            name = "Neuron Flight Status",
            create = create,
            configure = configure,
            paint = paint,
            wakeup = wakeup,
            read = read,
            write = write,
			event = event,
			menu = menu,
			persistent = false,
        }
    )

end

return {init = init}
