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

    isInBoundries = false
end

function Ship:update(dt)
    local left = Model.movement.left
    local right = Model.movement.right
    local up = Model.movement.up
    local down = Model.movement.down

    local x = 0
    local y = 0

    if left then
        x = x + -1
    end
    if right then
        x = x + 1
    end

    if up then
        y = y + -1
    end
    if down then
        y = y + 1
    end

    local x1 = self.position.x + (x * self.speed * dt)
    local y1 = self.position.y + (y * self.speed * dt)

    local newX , newY = Utils.screenCoordinates(x1, y1, self.w, self.h)
    isInBoundries = Model.isInScreenBoundries(newX, newY, self.w, self.h)

    if isInBoundries then
        self.position.x = self.position.x + (x * self.speed * dt)
        self.position.y = self.position.y + (y * self.speed * dt)
    end
end

function Ship:draw()
    local newX , newY = Utils.screenCoordinates(self.position.x, self.position.y, self.w, self.h)
    love.graphics.draw(self.asset, newX,newY )
end

return Ship