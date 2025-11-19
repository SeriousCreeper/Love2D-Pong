local Pedal = require("pedal")
local Ball = require("ball")
local Enemy = require("enemy")
local Camera = require("camera")
local BallAfterImage = require("ballAfterImage")

StateGame = {
    cameras = {
        camGame = Camera:new(),
        camUi = Camera:new()
    }
}

local leftPedal = Pedal:new(50, 250, 20, 100, 300)
local rightPedal = Pedal:new(730, 250, 20, 100, 300)
local ball = Ball:new(400, 300, 10, 200, 150)
local afterImages = {}
local enemy = nil

function StateGame:load()
    if Global.playerCount == 1 then
        enemy = Enemy:new(rightPedal)
    end
    
    ball:reset()
    Global.playerScore = 0
    Global.enemyScore = 0

    self.cameras.camGame:newLayer(1, function ()
        self:draw()
    end)
    self.cameras.camUi:newLayer(1, function ()
        self:drawUI()
    end)
end

function StateGame:drawUI()
    love.graphics.printf("FPS: " .. tostring(love.timer.getFPS()), 10, 10, love.graphics.getWidth(), "left")
    love.graphics.printf("Player: " .. Global.playerScore .. "  Enemy: " .. Global.enemyScore, 0, 30, love.graphics.getWidth(), "center")
    love.graphics.printf("Use W/S to move the left pedal", 20, love.graphics.getHeight() - 20, love.graphics.getWidth(), "left")

    if not enemy then
        love.graphics.printf("Use Up/Down arrows to move the right pedal", 20, love.graphics.getHeight() - 20, love.graphics.getWidth(), "right")
    end
end

function StateGame:draw()
    leftPedal:draw()
    rightPedal:draw()

    for _, img in ipairs(afterImages) do
        img:draw()
    end

    ball:draw()
end

function StateGame:keypressed(key)
    if key == "escape" then
        Global.currentState = Global.states.mainMenu
        Global.currentState:load()
    end
end

function StateGame:update(dt)
    Global.cameras.camBackground:setPosition((ball.x - love.graphics.getWidth() / 2) / 10, (ball.y - love.graphics.getHeight() / 2) / 10)

    for _, cam in pairs(self.cameras) do
        cam:update(dt)
    end


    leftPedal:update(dt)
    rightPedal:update(dt)
    ball:move(dt)
    ball:update(dt)

    for i = #afterImages, 1, -1 do
        local img = afterImages[i]
        img:update(dt)
        if img.alpha <= 0 then
            table.remove(afterImages, i)
        end
    end

    table.insert(afterImages, BallAfterImage:new(ball.x, ball.y, ball.radius * ball.scaleWidth, ball.radius * ball.scaleHeight))

    if love.keyboard.isDown("w") then
        leftPedal:moveUp(dt)
    end
    if love.keyboard.isDown("s") then
        leftPedal:moveDown(dt)
    end

    if enemy then
        enemy:update(ball, dt)
    else
        if love.keyboard.isDown("up") then
            rightPedal:moveUp(dt)
        end
        if love.keyboard.isDown("down") then
            rightPedal:moveDown(dt)
        end
    end

    if  ball:checkPedalCollision(leftPedal) or ball:checkPedalCollision(rightPedal) then
        ball.speedX = -ball.speedX
        ball.speed = ball.speed + 0.1
    end

    ball:checkWallCollision()
    if ball:outOfBounds() then
        if ball.x < 0 then
            Global.enemyScore = Global.enemyScore + 1
        else
            Global.playerScore = Global.playerScore + 1
        end

        ball:reset()
        leftPedal:reset()
        rightPedal:reset()
    end
end

return StateGame