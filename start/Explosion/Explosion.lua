local classes = require("classes")
local Explosion = classes.class()
local Model = require("Model")
local Utils = require("Helpers/Utils")
local Vector = require("Helpers/Vector")
local tween = require("Helpers/tween")

function Explosion:init(params)
    print("Explosion init!")
    self.asset = params.asset
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()

    self.position = Vector.new(Model.stage.stageWidth / 2, Model.stage.stageHeight / 2)

    self.explosionAlpha = 1

    -- self:doExplosion(self.position)
end

function Explosion:update(dt)
    fadeTween:update(dt)

    --not the best solution but at least it works! xD
    self.explosionAlpha = properties.explosionAlpha
end

function Explosion:doExplosion(position)

    self.position = Vector.new(position.x, position.y)

    properties = {explosionAlpha = 0}
    fadeTween = tween.new(0.3, properties, {explosionAlpha = 1}, 'linear')
    
end

function Explosion:draw()
    local newX , newY = Utils.screenCoordinates(self.position.x, self.position.y, self.w, self.h)
    love.graphics.setColor(1,1,1,self.explosionAlpha)
    love.graphics.draw(self.asset, newX,newY )

    love.graphics.setColor(1,1,1,1)
end

return Explosion