local classes = require("classes")
local Ship = classes.class()
local Model = require("Model")

function Ship:init(params)
    print("Ship init!")
    self.speed = params.speed
    self.asset = params.asset
    self.x = Model.stage.stageWidth / 2 -- this will put ship in center of screen X
    self.y = Model.stage.stageHeight / 2 -- this will put ship in center of screen Y
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()

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

    local x1 = self.x + (x * self.speed * dt)
    local y1 = self.y + (y * self.speed * dt)

    local newX , newY = screenCoordinates(x1, y1, self.w, self.h)
    isInBoundries = Model.isInScreenBoundries(newX, newY, self.w, self.h)

    if isInBoundries then
        self.x = self.x + (x * self.speed * dt)
        self.y = self.y + (y * self.speed * dt)
    end
end

function Ship:draw()
    local newX , newY = screenCoordinates(self.x, self.y, self.w, self.h)
    love.graphics.draw(self.asset, newX,newY )
end

function screenCoordinates(x,y,w,h) -- offset ship graphics up-left
    local newX = x - (w/2)
    local newY = y - (h/2)
    return newX, newY
end

function Ship:shipCoordinates()
    return self.x, self.y - (self.h/2)
end

return Ship