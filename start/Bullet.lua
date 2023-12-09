local Bullet = classes.class()
local Model = require("Model")

function Bullet:init(params)
    print("Bullet init!")
    self.fireRate = params.fireRate
    self.asset = params.asset
    self.x = Model.stage.stageWidth / 2
    self.y = Model.stage.stageHeight / 2
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()

    local bulletArr = {}
    self.bulletArr = bulletArr
end

function Bullet:update(dt)
    local fire = Model.fire.space

    if fire then
        fire = false

        local stageWidth = Model.stage.stageWidth
        local stageHeight = Model.stage.stageHeight

        local bulletArr = self.bulletArr

        local x = math.random() * stageWidth
        local y = math.random() * stageHeight

        local bullet = {x = x,y = y}
        table.insert(bulletArr, bullet)
    end
end

function Bullet:draw()
    for i=1, tablelength(self.bulletArr) do
        local bullet = self.bulletArr[i]

        local newX , newY = screenCoordinates(bullet.x, bullet.y, self.w, self.h)
        love.graphics.draw(self.asset, newX,newY )
    end
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
  end

return Bullet