local Ball = {}
Ball.__index = Ball

function Ball:new(x, y, radius, speedX, speedY)
    local ball = setmetatable({}, Ball)
    ball.x = x
    ball.y = y
    ball.radius = radius
    ball.defaultSpeedX = speedX
    ball.defaultSpeedY = speedY
    ball.speedX = speedX
    ball.speedY = speedY
    ball.speed = 1
    ball.isColliding = false
    ball.scaleWidth = 1
    ball.scaleHeight = 1
    ball.extraSpeed = 1
    return ball
end

function Ball:move(dt)
    self.x = self.x + self.speedX * dt * self.speed * self.extraSpeed
    self.y = self.y + self.speedY * dt * self.speed * self.extraSpeed 
end

function Ball:draw()
    love.graphics.ellipse("fill", self.x, self.y, self.radius * self.scaleWidth, self.radius * self.scaleHeight)
end

function Ball:reset()
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.speedX = self.defaultSpeedX * (math.random(0, 1) == 0 and -1 or 1)
    self.speedY = self.defaultSpeedY * (math.random(0, 1) == 0 and -1 or 1)
    self.speed = 1
    self.extraSpeed = 1
end

function Ball:checkPedalCollision(pedal)
    if self.x - self.radius < pedal.x + pedal.width and
       self.x + self.radius > pedal.x and
       self.y - self.radius < pedal.y + pedal.height and
       self.y + self.radius > pedal.y then
        if pedal.canCollide then
            pedal.canCollide = false
            pedal:bounce()
            self:squishWidth()
            self.extraSpeed = 4
            Global.currentState.cameras.camGame:shake(5, 0.1)
            return true
        end

        return false
    end
    pedal.canCollide = true
    return false
end

function Ball:checkWallCollision()
    local windowHeight = love.graphics.getHeight()
    if self.y - self.radius < 0 or self.y + self.radius > windowHeight then
        self.y = math.max(self.radius, math.min(windowHeight - self.radius, self.y))
        self.speedY = -self.speedY
        self:squishHeight()
        Global.currentState.cameras.camGame:shake(3, 0.1)
    end
end

function Ball:outOfBounds()
    local windowWidth = love.graphics.getWidth()
    if self.x + self.radius < 0 or self.x - self.radius > windowWidth then
        return true
    end

    return false
end

function Ball:squishHeight()
    self.scaleHeight = 0.6
end

function Ball:squishWidth()
    self.scaleWidth = 0.6
end

function Ball:update(dt)
    if self.scaleWidth < 1 then
        self.scaleWidth = self.scaleWidth + dt * 2
    else
        self.scaleWidth = 1
    end

    if self.scaleHeight < 1 then
        self.scaleHeight = self.scaleHeight + dt * 2
    else
        self.scaleHeight = 1
    end

    if self.extraSpeed > 1 then
        self.extraSpeed = self.extraSpeed - dt * 4
    else
        self.extraSpeed = 1
    end
end

return Ball