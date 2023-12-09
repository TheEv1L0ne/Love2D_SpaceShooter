local Bullet = classes.class()
local Model = require("Model")

function Bullet:init(params)
    print("Bullet init!")
    self.fireRate = params.fireRate
    self.asset = params.asset
    self.x = Model.stage.stageWidth / 2 -- this will put ship in center of screen X
    self.y = Model.stage.stageHeight / 2 -- this will put ship in center of screen Y
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()
end

function Bullet:update(dt)
    
end

function Bullet:draw()
    local newX , newY = screenCoordinates(self.x, self.y, self.w, self.h)
    love.graphics.draw(self.asset, newX,newY )
end

return Bullet