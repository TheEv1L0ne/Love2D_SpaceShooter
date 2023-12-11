local Enemy = classes.class()
local Utils = require("Utils")
local Vector = require("Vector")

function Enemy:init(params)
    print("Enemy init!")
    self.speed = params.speed
    self.asset = params.asset
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()
    self.position =  Vector.new(params.x, params.y)
end

function Enemy:update(dt)
    self.position.y = (self.position.y + self.speed * dt)
end 

function Enemy:draw()
    local newX , newY = Utils.screenCoordinates(self.position.x, self.position.y, self.w, self.h)
     love.graphics.draw(self.asset, newX, newY)
end

return Enemy