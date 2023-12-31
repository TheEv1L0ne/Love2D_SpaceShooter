local Bullet = classes.class()
local Utils = require("Helpers/Utils")
local Vector = require("Helpers/Vector")

function Bullet:init(params)
    print("Bullet init!")
    self.asset = params.asset
    self.speed = params.speed
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()
    
    self.position = Vector.new(params.x, params.y)

    self.angle = 0
end

function Bullet:draw()
    local newX , newY = Utils.screenCoordinates(self.position.x, self.position.y, self.w, self.h)
    love.graphics.draw(self.asset, newX,newY )
end

function Bullet:update(dt)
    self.position.x = self.position.x - (self.speed * dt) * self.angle
    self.position.y = self.position.y - (self.speed * dt)
end 

return Bullet