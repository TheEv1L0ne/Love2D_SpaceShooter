local BulletManager = classes.class()
local Model = require("Model")
local Utils = require("Utils")
local Vector = require("Vector")

local BulletCls = require("Bullets/Bullet")


function BulletManager:init(params)
    print("BulletManager init!")

    self.fireRate = params.fireRate
    local bulletArr = {}
    self.bulletArr = bulletArr

    fireCooldown = 0
end

function BulletManager:update(dt, shipX , shipY)
    local fire = Model.fire.space

    if fireCooldown <= 0 then
        if fire then
            local bulletArr = self.bulletArr

            local params = Model.bulletParams
            params.x = shipX
            params.y = shipY

            local bullet = BulletCls.new(params)
            table.insert(bulletArr, bullet)

            fireCooldown = self.fireRate
        end
    else
        fireCooldown = fireCooldown - dt
    end

    self:fly(dt)
end

function BulletManager:draw()
    for i=1, Utils.tablelength(self.bulletArr) do
        local bullet = self.bulletArr[i]
        bullet:draw()
    end
end

function BulletManager:fly(dt)
    for i=1, Utils.tablelength(self.bulletArr) do
        if self.bulletArr[i] ~= nil then
            local bullet = self.bulletArr[i]
            bullet:update(dt)

            if bullet.position.y < 0 then
                self:DestoryBullet(i)
            end
        end
    end
end 

function BulletManager:DestoryBullet(bulletIndex)
    table.remove(self.bulletArr,bulletIndex)
end

return BulletManager