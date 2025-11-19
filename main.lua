local Global = require("global")
local Camera = require("camera")

Global.cameras.camBackground = Camera:new()

function love.load()
    love.window.setMode(800, 600)
    love.window.setTitle("Pong Game")
    -- make the background dark burgundy color

    math.randomseed(os.time())
    math.random()

    love.graphics.setBackgroundColor(0.5 + math.random(10) / 100, 0.5 + math.random(10) / 100, 0.5 + math.random(10) / 100)

    for i = .5, 3, .5 do
        local rectangles = {}

        for j = 1, math.random(5, 10) do
            local alpha = math.random(5, 20) / 255
            local size = math.random(30, 120)
            table.insert(rectangles, {
                math.random(0, love.graphics.getWidth()),
                math.random(0, love.graphics.getHeight()),
                size,
                size,
                color = { 1, 1, 1, alpha }
            })
        end

        Global.cameras.camBackground:newLayer(i, function()
            for _, v in ipairs(rectangles) do
                love.graphics.setColor(v.color)
                love.graphics.rectangle('fill', unpack(v))
                love.graphics.setColor(1, 1, 1)
            end
        end)
    end

    Global.currentState:load()
end

function love.draw()
    for _, cam in pairs(Global.cameras) do
        cam:draw()
    end

    for _, cam in pairs(Global.currentState.cameras) do
        cam:draw()
    end
end

function love.update(dt)
    Global.currentState:update(dt)
    for _, cam in pairs(Global.cameras) do
        cam:update(dt)
    end
end

function love.keypressed(key)
    Global.currentState:keypressed(key)
end
