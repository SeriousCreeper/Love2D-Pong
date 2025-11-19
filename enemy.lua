local Enemy = {}
Enemy.__index = Enemy

function Enemy:new(pedal)
    local enemy = setmetatable({}, Enemy)
    enemy.pedal = pedal
    return enemy
end

function Enemy:update(ball, dt)
    local pedalCenter = self.pedal.y + self.pedal.height / 2
    if ball.y < pedalCenter then
        self.pedal:moveUp(dt)
    elseif ball.y > pedalCenter then
        self.pedal:moveDown(dt)
    end
end

return Enemy