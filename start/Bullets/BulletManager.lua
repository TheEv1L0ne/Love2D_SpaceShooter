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

    self.moreCannonsTime = 0
    self.moreAnglesTime = 0
    self.numberOfCannons = params.defaultCannons
    self.numberOfAngles = params.defaultAngles
end

function BulletManager:update(dt, shipX , shipY)
    local fire = Model.fire.space

    if fireCooldown <= 0 then
        if fire then

            local r = self:GunAngles(self.numberOfAngles) -- calculates angles besed on how many we want to have
            local n = self:numberOfGuns(self.numberOfCannons) -- calculates guns offsets besed on how many we want to have
            for i = 1, table.getn(r) do
                for j = 1, table.getn(n) do
                    self:spawnBullet(shipX + n[j], shipY, r[i])
                end
            end
           

            fireCooldown = self.fireRate
        end
    else
        fireCooldown = fireCooldown - dt
    end

    self:fly(dt)
    self:getGunsRemaindingTime(dt)
    self:getAnglesRemaindingTime(dt)
end

function BulletManager:getGunsRemaindingTime(dt)
    if self.moreCannonsTime > 0 then
        self.moreCannonsTime = self.moreCannonsTime - dt
    else
        self.moreCannonsTime = 0
        self.numberOfCannons = Model.shipParams.defaultCannons
    end
end

function BulletManager:setGunsRemaindingTime()
    self.moreCannonsTime = Model.fireRateParams.duration
    self.numberOfCannons = Model.fireRateParams.amount
end

function BulletManager:getAnglesRemaindingTime(dt)
    if self.moreAnglesTime > 0 then
        self.moreAnglesTime = self.moreAnglesTime - dt
    else
        self.moreAnglesTime = 0
        self.numberOfAngles = Model.shipParams.defaultAngles
    end
end

function BulletManager:setAnglesRemaindingTime()
    self.moreAnglesTime = Model.fireAngleParams.duration
    self.numberOfAngles = Model.fireAngleParams.amount
end

function BulletManager:numberOfGuns(number)

    if number < 1 then
        number = 1
    end
    
    local index = 1
    local array = {}
    if math.fmod(number, 2) == 0 then
        for i = 1, number / 2 do
            array[index] = -10*i;
            array[index+1] = 10*i;
            index= index + 2
        end
    else
        array[index] = 0
        index= index + 1
        for i = 1, (number - 1) / 2 do
            array[index] = -10*i;
            array[index+1] = 10*i;
            index= index + 2
        end
    end

    return array
end

function BulletManager:GunAngles(number)

    if number < 1 then
        number = 1
    end

    local index = 1
    local array = {}

    local x = 2 / (number - 1)
    if math.fmod(number, 2) == 0 then
        for i = 1, number / 2 do
            array[index] = -x*i * 0.1;
            array[index+1] = x*i * 0.1;
            index= index + 2
        end
    else
        array[index] = 0
        index= index + 1
        for i = 1, (number - 1) / 2 do
            array[index] = -x*i;
            array[index+1] = x*i;
            index= index + 2
        end
    end

    return array
end

function BulletManager:spawnBullet(shipX , shipY, angle)
    local bulletArr = self.bulletArr

    local params = Model.bulletParams
    params.x = shipX
    params.y = shipY

    local bullet = BulletCls.new(params)
    bullet.angle = angle
    table.insert(bulletArr, bullet)
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

            if self:checkIfBulletIsOutside(bullet) then
                self:DestoryBullet(i)
            end
        end
    end
end 

function BulletManager:checkIfBulletIsOutside(bullet)
    return (bullet.position.y < 0)  
            or (bullet.position.y > Model.stage.stageHeight) 
            or (bullet.position.x < 0)
            or (bullet.position.x > Model.stage.stageWidth)
end

function BulletManager:DestoryBullet(bulletIndex)
    table.remove(self.bulletArr,bulletIndex)
end

return BulletManager