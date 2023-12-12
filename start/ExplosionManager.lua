local classes = require("classes")
local ExplosionManager = classes.class()
local Model = require("Model")
local Utils = require("Utils")
local ExplosionCls = require("Explosion")

function ExplosionManager:init()
    print("ExplosionManager init!")

    local explosionArr = {}
    self.explosionArr = explosionArr
end

function ExplosionManager:update(dt)
    for i=1, Utils.tablelength(self.explosionArr) do
        if self.explosionArr[i] ~= nil then
            local explosion = self.explosionArr[i]
            explosion:update(dt)

            if explosion.explosionAlfa == 1 then
                self:removeExplosion(i)
            end
        end
    end
end

function ExplosionManager:draw()
    for i=1, Utils.tablelength(self.explosionArr) do
        if self.explosionArr[i] ~= nil then
            local explosion = self.explosionArr[i]
            explosion:draw()
        end
    end
end

function ExplosionManager:createExplosion(position)

    local explosionArr = self.explosionArr
    local explosion = ExplosionCls.new(Model.explosionParams)
    explosion:doExplosion(position)
    table.insert(explosionArr, explosion)
end

function ExplosionManager:removeExplosion(expIndex)
    table.remove(self.explosionArr,expIndex)
end

return ExplosionManager