local classes = require("classes")
local PlayerManager = classes.class()
local Model = require("Model")
local ShipCls = require("Player/Ship")

function PlayerManager:init()
    print("PlayerManager init!")

    self.ship = ShipCls.new( Model.shipParams )
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
end

function PlayerManager:destoryShip()
    if self.ship ~= nil then
        self.ship = nil
    end
end

return PlayerManager