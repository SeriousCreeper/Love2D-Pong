local BallAfterImage = {}
BallAfterImage.__index = BallAfterImage

function BallAfterImage:new(x, y, radiusX, radiusY) 
    local afterImage = setmetatable({}, BallAfterImage)
    afterImage.x = x + math.random(-2, 2)
    afterImage.y = y + math.random(-2, 2)
    afterImage.radiusX = radiusX
    afterImage.radiusY = radiusY
    afterImage.alpha = 0.5
    return afterImage
end

function BallAfterImage:draw()
    love.graphics.setColor(0.5, 0.5, 0.5, self.alpha)
    local extraScale = self.alpha / 0.5
    love.graphics.ellipse("fill", self.x, self.y, self.radiusX * extraScale, self.radiusY * extraScale)
    love.graphics.setColor(1, 1, 1, 1)
end

function BallAfterImage:update(dt)
    self.alpha = self.alpha - dt
    if self.alpha < 0 then
        self.alpha = 0
    end
end

return BallAfterImage