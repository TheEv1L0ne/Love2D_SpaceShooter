local Enemy = classes.class()
local Model = require("Model")
local Ship = require("Ship")
local Utils = require("Utils")

function Enemy:init(params)
    print("Enemy init!")
    self.speed = params.speed
    self.asset = params.asset
    self.x = Model.stage.stageWidth / 2
    self.y = Model.stage.stageHeight / 2
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()

    local enemyArr = {}
    self.enemyArr = enemyArr

    enemySpawnCooldown = 0
    enemyCd = 1
end

function Enemy:update(dt)
    if enemySpawnCooldown <= 0 then
            local stageWidth = Model.stage.stageWidth

            local enemyArr = self.enemyArr
    
            local x = Utils.clamp(math.random() * stageWidth, self.w/2 , stageWidth - (self.w/2))
            local y = 0

            local enemy = {x = x,y = y}
            table.insert(enemyArr, enemy)

            enemySpawnCooldown = enemyCd
    else
        enemySpawnCooldown = enemySpawnCooldown - dt
    end

    self:fly(dt)
end

function Enemy:draw()
    for i=1, Utils.tablelength(self.enemyArr) do
        local enemy = self.enemyArr[i]

        local newX , newY = Utils.screenCoordinates(enemy.x, enemy.y, self.w, self.h)
        love.graphics.draw(self.asset, newX,newY )
    end
end

function Enemy:fly(dt)
    for i=1, Utils.tablelength(self.enemyArr) do
        if self.enemyArr[i] ~= nil then
            local enemy = self.enemyArr[i]
            enemy.y = (enemy.y + self.speed * dt)

            if enemy.y > Model.stage.stageHeight then
                self:DestoryEnemy(i)
            end
        end
    end
end 

function Enemy:DestoryEnemy(enemyIndex)
    table.remove(self.enemyArr,enemyIndex)
end

return Enemy