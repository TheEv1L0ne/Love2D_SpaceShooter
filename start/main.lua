--EXAMPLES
----------------------
--for debugging in zero brane
-- require("mobdebug").start()

--this is to make prints appear right away in zerobrane
io.stdout:setvbuf("no")

----EXAMPLES: INSTANTIARING A CLASS
local PlayerManagerCls = require("Player/PlayerManager")
local playerManager = nil

local StarsCls = require("Stars")
local stars = nil

local BulletManagerCls = require("Bullets/BulletManager")
local bulletManager = nil

local EnemySpawnCls = require("Enemies/EnemySpawnManager")
local enemySpawnManager = nil

local CollisionCls = require("Helpers/Collision")
local collision = nil

local ExplosionManagerCls = require("Explosion/ExplosionManager")
local explosionManager = nil

local ItemManagerCls = require("Items/ItemManager")
local itemManager = nil

local AssetsManager = require("AssetsManager")
local Model = require("Model")

local Vector = require("Helpers/Vector")
local Utils = require("Helpers/Utils")

local LEFT_KEY = "left"
local RIGHT_KEY = "right"
local UP_KEY = "up"
local DOWN_KEY = "down"

local SPACE_KEY = "space"

local score = 0
local winFail = ""
level = 1


function love.load()
    print("love.load")
    AssetsManager.init()
    Model.init()
    
    level = 1
    score = 0
end

function initGame()
    stars = StarsCls.new(Model.starsParams)
    playerManager = PlayerManagerCls.new(Model.playerParams)
    bulletManager = BulletManagerCls.new(Model.bulletManagerParams)
    enemySpawnManager = EnemySpawnCls.new(Model.enemySpawnParams, level)
    itemManager = ItemManagerCls.new()
    collision = CollisionCls.new()
    explosionManager = ExplosionManagerCls.new()
end

function isGameInit()
    return playerManager ~= nil 
    and bulletManager  ~= nil 
    and enemySpawnManager  ~= nil
    and collision  ~= nil
    and stars  ~= nil
    and itemManager  ~= nil
    and explosionManager ~= nil
end

function resetGame()
    playerManager = nil 
    bulletManager  = nil 
    enemySpawnManager  = nil
    collision  = nil
    stars  = nil
    itemManager = nil
    explosionManager = nil
end

function love.update(dt)
   -- print("update")
    if not isGameInit() then
        return
    end

    playerManager:update(dt)
    itemManager:update(dt, playerManager.ship.position.x, playerManager.ship.position.y)
    stars:update(dt)
    
    if playerManager.ship ~= nil then
        bulletManager:update(dt, playerManager.ship.position.x, playerManager.ship.position.y - (playerManager.ship.h/2))
    end

    enemySpawnManager:update(dt)
    explosionManager:update(dt)
    
    checkItemCollected()
    checkBulletAndEnemyCollision()
    checkPlayerAndEnemyCollision()
    checkEnemiesLeft()

end

function love.draw()
    if not isGameInit() then
        endGameResults()
        return
    end

    gameScoreAndProgress()

    stars:draw()
    playerManager:draw()
    bulletManager:draw()
    enemySpawnManager:draw()
    itemManager:draw()
    explosionManager:draw()
end

function checkItemCollected()
    if (itemManager.itemCoinArr ~= nil) then
        local itemColidedIndex = collision:checkCollision(playerManager.ship, itemManager.itemCoinArr)
        if itemColidedIndex ~= -1 then
            local itemName = itemManager.itemCoinArr[itemColidedIndex].itemName

            doItemEffect(itemName)

            itemManager:removeItem(itemColidedIndex)
        end
    end
end

function doItemEffect(itemName)
    if itemName == Model.coinParams.assetName then
        score = score + math.floor(math.random() * Model.coinParams.amount) + Model.coinParams.amount
    elseif itemName == Model.healthParams.assetName then
        playerManager:increaseHealth()
    elseif itemName == Model.fireAngleParams.assetName then
        bulletManager:setAnglesRemaindingTime()
    elseif itemName == Model.fireRateParams.assetName then
        bulletManager:setGunsRemaindingTime()
    elseif itemName == Model.magnetParams.assetName then
        itemManager:setItemPullTime()
    elseif itemName == Model.shieldParams.assetName then
        playerManager:setShieldActiveTime()
    end
end

function checkBulletAndEnemyCollision()
    if (enemySpawnManager.enemyArr ~= nil) and (bulletManager.bulletArr ~= nil)then
        for i = 1, Utils.tablelength(bulletManager.bulletArr) do
            local enemyColidedIndex = collision:checkCollision(bulletManager.bulletArr[i], enemySpawnManager.enemyArr)
            if enemyColidedIndex ~= -1 then
                -- not best position... using bullet one and should use enemy... will refactor if I have time
                explosionManager:createExplosion(bulletManager.bulletArr[i].position)

                bulletManager:DestoryBullet(i);
                enemySpawnManager:DestoryEnemy(enemyColidedIndex)

                --Increase score by X when enemy is destoryed
                score = score + math.floor(math.random() * Model.enemyParams.baseScore) + Model.enemyParams.baseScore
            end
        end
    end
end

function checkPlayerAndEnemyCollision()
    if (enemySpawnManager.enemyArr ~= nil) then
        local enemyColidedIndex = collision:checkCollision(playerManager.ship, enemySpawnManager.enemyArr)
        if enemyColidedIndex ~= -1 then
            explosionManager:createExplosion(playerManager.ship.position)
            playerManager:takeDamage();
            enemySpawnManager:DestoryEnemy(enemyColidedIndex)

            if playerManager.currentHp <= 0 then
                -- player was destoryed so we failed... 
                score = 0
                level = 1
                winFail = "FAILED"

                resetGame()
            end
        end
    end
end


function checkEnemiesLeft()
    if enemySpawnManager == nil then
        return
    end

    if (enemySpawnManager.enemiesLeftToSpawn == 0) and (Utils.tablelength(enemySpawnManager.enemyArr) == 0) then
        -- No enemies left so we won the game
        level = level + 1
        winFail = "WON"

        resetGame()
    end
end

function gameScoreAndProgress()
    love.graphics.print("Score: "..tostring(score), Model.stage.stageWidth - 100, 0)
    love.graphics.print("Enemies left: "..tostring(enemySpawnManager.enemiesLeftToSpawn), Model.stage.stageWidth/2 - 20, 0)
end

function endGameResults()
    local resultString = "You have [WON/FAILED] level [X]!"

    -- do not show this when game is started...
    if winFail == "" then
        resultString = ""
    else
        local lastLevelPlayed = level - 1
        if lastLevelPlayed < 1 then
            lastLevelPlayed = 1
        end

        resultString = resultString:gsub("%[WON/FAILED%]", winFail)
        resultString = resultString:gsub("%[X%]", lastLevelPlayed)
    end
    -- will not show at start cause resultString = ""
    love.graphics.printf(resultString, Model.stage.stageWidth/2 - 100, Model.stage.stageHeight/2 - 150, 200, "center")

    local startString = "Press S to start level [X] !!!"
    startString = startString:gsub("%[X%]", level)

    love.graphics.printf(startString, Model.stage.stageWidth/2 - 100, Model.stage.stageHeight/2 - 100, 200, "center")
end


function love.keypressed(key)
    if key == LEFT_KEY then
        Model.movement.left = true
    elseif key == RIGHT_KEY then
        Model.movement.right = true
    end
    
    if key == UP_KEY then
        Model.movement.up = true
    elseif key == DOWN_KEY then
        Model.movement.down = true
    end

    if key == SPACE_KEY then
        Model.fire.space = true
    end

end

function love.keyreleased(key)
    if key == LEFT_KEY then
        Model.movement.left = false
    elseif key == RIGHT_KEY then
        Model.movement.right = false
    end
    
    if key == UP_KEY then
        Model.movement.up = false
    elseif key == DOWN_KEY then
        Model.movement.down = false
    end

    if key == SPACE_KEY then
        Model.fire.space = false
    end

    if key == "s" then
        initGame()
    end
end

--
--



