local classes = require("classes")
local PlayerManager = classes.class()
local Model = require("Model")
local ShipCls = require("Player/Ship")

function PlayerManager:init(params)
    print("PlayerManager init!")

    self.maxHp = params.maxHp
    self.asset = params.asset

    self.ship = ShipCls.new( Model.shipParams )

    self.currentHp = self.maxHp
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
end

function PlayerManager:destoryShip()
    if self.ship ~= nil then
        self.ship = nil
    end
end

function PlayerManager:takeDamage()
    if self.ship ~= nil then
        self.currentHp = self.currentHp - 1
        if self.currentHp == 0 then
            self:destoryShip()
        end
    end
end

return PlayerManager