local classes = require("classes")
local Ship = classes.class()
local Model = require("Model")
local Utils = require("Utils")
local Vector = require("Vector")

function Ship:init(params)
    print("Ship init!")
    self.speed = params.speed
    self.asset = params.asset
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()

    self.position = Vector.new(Model.stage.stageWidth / 2, Model.stage.stageHeight / 2)
end

function Ship:update(xDT, yDT)
    local x = self.position.x + (xDT * self.speed)
    local y = self.position.y + (yDT * self.speed)

    self.position.x = Utils.clamp(x, 0, Model.stage.stageWidth)
    self.position.y = Utils.clamp(y, 0, Model.stage.stageHeight)
end

function Ship:draw()
    local newX , newY = Utils.screenCoordinates(self.position.x, self.position.y, self.w, self.h)
    love.graphics.draw(self.asset, newX,newY )
end

return Ship