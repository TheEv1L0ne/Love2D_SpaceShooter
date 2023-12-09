local Bullet = classes.class()
local Model = require("Model")
local Ship = require("Ship")
local Utils = require("Utils")

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

    fireCooldown = 0
end

function Bullet:update(dt, shipX , shipY)
    local fire = Model.fire.space

    if fireCooldown <= 0 then
        if fire then
            local stageWidth = Model.stage.stageWidth
            local stageHeight = Model.stage.stageHeight
    
            local bulletArr = self.bulletArr
    
            local x = shipX
            local y = shipY

            local bullet = {x = x,y = y}
            table.insert(bulletArr, bullet)

            fireCooldown = self.fireRate
        end
    else
        fireCooldown = fireCooldown - dt
    end

    self:fly()
end

function Bullet:draw()
    for i=1, Utils.tablelength(self.bulletArr) do
        local bullet = self.bulletArr[i]

        local newX , newY = Utils.screenCoordinates(bullet.x, bullet.y, self.w, self.h)
        love.graphics.draw(self.asset, newX,newY )
    end
end

function Bullet:fly()
    for i=1, Utils.tablelength(self.bulletArr) do
        if self.bulletArr[i] ~= nil then
            local bullet = self.bulletArr[i]
            bullet.y = bullet.y - 1

            if bullet.y < 0 then
                self:DestoryBullet(i)
            end
        end
    end
end 

function Bullet:DestoryBullet(bulletIndex)
    table.remove(self.bulletArr,bulletIndex)
end

return Bullet