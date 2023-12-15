local EnemySpawnManager = classes.class()
local Model = require("Model")
local Utils = require("Helpers/Utils")
local Vector = require("Helpers/Vector")

local EnemyCls = require("Enemies/Enemy")

function EnemySpawnManager:init(params)
    print("EnemySpawnManager init!")
    local enemyArr = {}
    self.enemyArr = enemyArr
    self.enemiesLeftToSpawn = params.totalEnemies * level --global level defined in main.lua

    enemySpawnCooldown = 0
    enemyCd = 1
end

function EnemySpawnManager:update(dt)
    if (enemySpawnCooldown <= 0) and (self.enemiesLeftToSpawn > 0) then
            local stageWidth = Model.stage.stageWidth
        
            local enemyArr = self.enemyArr

            local params = Model.enemyParams
            local enemyMinSpawnX = params.asset:getWidth() / 2
            local enemyMaxSPawnX = stageWidth - enemyMinSpawnX
            params.x = Utils.clamp(math.random() * stageWidth, enemyMinSpawnX, enemyMaxSPawnX)
            params.y = 0

            local enemy = EnemyCls.new(params)
            table.insert(enemyArr, enemy)

            enemySpawnCooldown = enemyCd

            self.enemiesLeftToSpawn = self.enemiesLeftToSpawn - 1
    else
        enemySpawnCooldown = enemySpawnCooldown - dt
    end

    self:fly(dt)
end

function EnemySpawnManager:draw()
    for i=1, Utils.tablelength(self.enemyArr) do
        local enemy = self.enemyArr[i]
        enemy:draw()
    end
end

function EnemySpawnManager:fly(dt)
    for i=1, Utils.tablelength(self.enemyArr) do
        if self.enemyArr[i] ~= nil then
            local enemy = self.enemyArr[i]
            enemy:update(dt)

            if enemy.position.y > Model.stage.stageHeight then
                self:DestoryEnemy(i)
            end
        end
    end
end 

function EnemySpawnManager:DestoryEnemy(enemyIndex)
    table.remove(self.enemyArr,enemyIndex)
end

return EnemySpawnManager