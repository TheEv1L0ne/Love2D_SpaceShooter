local Enemy = classes.class()
local Utils = require("Helpers/Utils")
local Vector = require("Helpers/Vector")

function Enemy:init(params)
    print("Enemy init!")
    --Give enemy random speed up to 1.5 of default
    self.speed = math.floor(math.random() * params.speed /2) + params.speed
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