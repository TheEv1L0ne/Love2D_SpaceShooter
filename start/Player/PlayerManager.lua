local classes = require("classes")
local PlayerManager = classes.class()
local Model = require("Model")
local ShipCls = require("Player/Ship")
local Utils = require("Utils")
local Vector = require("Vector")

function PlayerManager:init(params)
    print("PlayerManager init!")

    self.maxHp = params.maxHp
    self.asset = params.asset

    self.ship = ShipCls.new( Model.shipParams )

    self.currentHp = self.maxHp

    self.shieldTimer = 0
end

function PlayerManager:update(dt)
    if self.ship ~= nil then
        local left = Model.movement.left
        local right = Model.movement.right
        local up = Model.movement.up
        local down = Model.movement.down

        local x = 0
        local y = 0

        if left then
            x = -dt
        end
        if right then
            x = dt
        end

        if up then
            y = -dt
        end
        if down then
            y = dt
        end

        self.ship:update(x,y)

        self:shieldActiveTime(dt)
    end
end

function PlayerManager:draw()
    if self.ship ~= nil then
        self.ship:draw()
    end

    for i = 1, self.currentHp do
        local assetPosition = ((i - 1) * (self.asset:getWidth() + 10))  + 20
        love.graphics.draw(self.asset, assetPosition, 0)
    end

    if self.shieldTimer > 0 then
        local p = Vector.new(self.ship.position.x - self.ship.w/2, self.ship.position.y - self.ship.h/2)
        local pos = Utils.rotateAroundPoint(p, 20,  math.fmod(self.shieldTimer,2))
        love.graphics.draw(Model.shieldParams.asset, pos.x, pos.y)
    end
end

function PlayerManager:destoryShip()
    if self.ship ~= nil then
        self.ship = nil
    end
end

function PlayerManager:takeDamage()
    if self.ship ~= nil then

        if self.shieldTimer > 0 then
            return
        end

        self.currentHp = self.currentHp - 1
        if self.currentHp == 0 then
            self:destoryShip()
        end
    end
end

function PlayerManager:increaseHealth()
    self.currentHp = self.currentHp + 1
    if self.currentHp > 3 then
        self.currentHp = 3
    end
end

function PlayerManager:shieldActiveTime(dt)
    if self.shieldTimer > 0 then
        self.shieldTimer = self.shieldTimer - dt
    else
        self.shieldTimer = 0
    end
end

function PlayerManager:setShieldActiveTime()
    self.shieldTimer = 5
end

return PlayerManager