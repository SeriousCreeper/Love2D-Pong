local Global = require("global")

function love.load()
    love.window.setMode(800, 600)
    love.window.setTitle("Pong Game")

    Global.currentState:load()
end

function love.draw()
    love.graphics.setColor(1, 1, 1, 1)
    Global.currentState:draw()
end

function love.update(dt)
    Global.currentState:update(dt)
end

function love.keypressed(key)
    Global.currentState:keypressed(key)
end