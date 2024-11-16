local config = {}
config.widgetName = "Neuron Flight Status"
config.widgetKey = "zxkss"
config.widgetDir = "/scripts/neuronstatus/"


neuronstatus = assert(config.widgetDir .. "neuronstatus.lua")(config)

local function paint()
    return neuronstatus.paint()
end

local function configure()
    return neuronstatus.configure()
end

local function wakeup()
    return neuronstatus.wakeup()
end

local function read()
    return neuronstatus.read()
end

local function write()
    return neuronstatus.write()
end

local function event(widget, category, value, x, y)
    return neuronstatus.event(widget, category, value, x, y)
end

local function create()
    return neuronstatus.create()
end

local function menu()
    return neuronstatus.menu()
end

local function init()
    system.registerWidget({
        key = config.widgetKey,
        name = config.widgetName,
        create = create,
        configure = configure,
        paint = paint,
        wakeup = wakeup,
        read = read,
        write = write,
        event = event,
        menu = menu,
        persistent = false
    })

end

return {init = init}
