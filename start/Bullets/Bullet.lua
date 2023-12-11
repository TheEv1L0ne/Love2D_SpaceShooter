local Bullet = classes.class()
local Model = require("Model")
local Utils = require("Utils")
local Vector = require("Vector")

function Bullet:init(params)
    print("Bullet init!")
    self.asset = params.asset
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()

    self.position = Vector.new(params.x, params.y)

    local bulletArr = {}
    self.bulletArr = bulletArr

    fireCooldown = 0
end

function Bullet:update(dt, shipX , shipY)
    self:fly()
end

function Bullet:draw()
    local newX , newY = Utils.screenCoordinates(self.position.x, self.position.y, self.w, self.h)
    love.graphics.draw(self.asset, newX,newY )
end

function Bullet:fly()
    self.position.y = self.position.y - 1
end 

return Bullet