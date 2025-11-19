StateMainMenu = {}

function StateMainMenu:load()
end

function StateMainMenu:keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    
    if key == "1" then
        Global.playerCount = 1
        Global.currentState = Global.states.game
        Global.currentState:load()
    end
    
    if key == "2" then
        Global.playerCount = 2
        Global.currentState = Global.states.game
        Global.currentState:load()
    end
end

function StateMainMenu:update(dt)
end

function StateMainMenu:draw()
    love.graphics.printf("Welcome to Pong!", 0, love.graphics.getHeight() / 2 - 40, love.graphics.getWidth(), "center")
    love.graphics.printf("Press 1 to play Solo", 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
    love.graphics.printf("Press 2 to play Multiplayer", 0, love.graphics.getHeight() / 2 + 40, love.graphics.getWidth(), "center")
end

return StateMainMenu