local Global = require("global")
require "camera"

function love.load()
    love.window.setMode(800, 600)
    love.window.setTitle("Pong Game")

    math.randomseed(os.time())
    math.random()

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

        Camera:newLayer(i, function()
            for _, v in ipairs(rectangles) do
                local dimensions = unpack(v)
                love.graphics.setColor(v.color)
                love.graphics.rectangle('fill', unpack(v))
                love.graphics.setColor(1, 1, 1)
            end
        end)
    end

    Global.currentState:load()
end

function love.draw()
    Camera:draw()
    Global.currentState:draw()
end

function love.update(dt)
    Global.currentState:update(dt)
end

function love.keypressed(key)
    Global.currentState:keypressed(key)
end
