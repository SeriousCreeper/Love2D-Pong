local Pedal = {}
Pedal.__index = Pedal

function Pedal:new(x, y, width, height, speed)
    local pedal = setmetatable({}, Pedal)
    pedal.x = x
    pedal.y = y
    pedal.width = width
    pedal.height = height
    pedal.speed = speed
    pedal.canCollide = true
    pedal.scale = 1
    pedal.offsetX = 0
    return pedal
end

function Pedal:moveUp(dt)
    self.y = math.max(0, self.y - self.speed * dt)
end

function Pedal:moveDown(dt)
    local windowHeight = love.graphics.getHeight()
    self.y = math.min(windowHeight - self.height, self.y + self.speed * dt)
end

function Pedal:draw()
    local scaledWidth = self.width * self.scale
    local scaledHeight = self.height * self.scale
    local tempOffsetX = (scaledWidth - self.width) / 2
    local tempOffsetY = (scaledHeight - self.height) / 2

    if(self.x > love.graphics.getWidth() / 2) then
        tempOffsetX = tempOffsetX + self.offsetX * -1
    else
        tempOffsetX = tempOffsetX + self.offsetX
    end

    love.graphics.rectangle("fill", self.x - tempOffsetX, self.y - tempOffsetY, scaledWidth, scaledHeight)
end

function Pedal:bounce()
    self.scale = 1.4
    self.offsetX = self.width / 2
end

function Pedal:update(dt)
    if self.scale > 1 then
        self.scale = self.scale - dt * 2
    else
        self.scale = 1
    end

    if self.offsetX > 0 then
        self.offsetX = self.offsetX - dt * 100
    else
        self.offsetX = 0
    end
end

function Pedal:reset()
    self.canCollide = true
    self.scale = 1
    self.offsetX = 0
    self.y = (love.graphics.getHeight() - self.height) / 2
end

return Pedal