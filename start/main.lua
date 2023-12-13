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

local CollisionCls = require("Collision")
local collision = nil

local ExplosionManagerCls = require("ExplosionManager")
local explosionManager = nil

local ItemManagerCls = require("ItemManager")
local itemManager = nil

local AssetsManager = require("AssetsManager")
local Model = require("Model")

local Vector = require("Vector")
local Utils = require("Utils")

local LEFT_KEY = "left"
local RIGHT_KEY = "right"
local UP_KEY = "up"
local DOWN_KEY = "down"

local SPACE_KEY = "space"

local s = ""
local score = 0


function love.load()
    print("love.load")
    AssetsManager.init()
    Model.init()
    explosionManager = ExplosionManagerCls.new()

    score = 0
end

function initGame()
    stars = StarsCls.new( Model.starsParams)
    playerManager = PlayerManagerCls.new( Model.playerParams )
    bulletManager = BulletManagerCls.new( Model.bulletManagerParams )
    enemySpawnManager = EnemySpawnCls.new( Model.enemySpawnParams )
    itemManager = ItemManagerCls.new()
    collision = CollisionCls.new()
end

function isGameInit()
    return playerManager ~= nil 
    and bulletManager  ~= nil 
    and enemySpawnManager  ~= nil
    and collision  ~= nil
    and stars  ~= nil
    and itemManager  ~= nil
end

function resetGame()
    playerManager = nil 
    bulletManager  = nil 
    enemySpawnManager  = nil
    collision  = nil
    stars  = nil
    itemManager = nil
end

function love.update(dt)


    explosionManager:update(dt)


   -- print("update")
    if not isGameInit() then
        return
    end

    itemManager:update(dt)

    playerManager:update(dt)

    stars:update(dt)
    
    if playerManager.ship ~= nil then
        bulletManager:update(dt, playerManager.ship.position.x, playerManager.ship.position.y - (playerManager.ship.h/2))
    end

    enemySpawnManager:update(dt)

    if (itemManager.itemCoinArr ~= nil) then
        local itemColidedIndex = collision:checkCollision(playerManager.ship, itemManager.itemCoinArr)
        if itemColidedIndex ~= -1 then
            local itemName = itemManager.itemCoinArr[itemColidedIndex].itemName

            if itemName == "coin" then
                score = score + 33
            end

            if itemName == "health" then
                playerManager:increaseHealth()
            end

            itemManager:removeItem(itemColidedIndex)
        end
    end

    if (enemySpawnManager.enemyArr ~= nil) and (bulletManager.bulletArr ~= nil)then
        for i = 1, Utils.tablelength(bulletManager.bulletArr) do
            local enemyColidedIndex = collision:checkCollision(bulletManager.bulletArr[i], enemySpawnManager.enemyArr)
            if enemyColidedIndex ~= -1 then
                -- not best position... using bullet one and should use enemy... will refactor if I have time
                explosionManager:createExplosion(bulletManager.bulletArr[i].position)

                bulletManager:DestoryBullet(i);
                enemySpawnManager:DestoryEnemy(enemyColidedIndex)

                --Increase score by 100 when enemy is destoryed
                score = score + 100
            end
        end
    end

    if (enemySpawnManager.enemyArr ~= nil) then
        local enemyColidedIndex = collision:checkCollision(playerManager.ship, enemySpawnManager.enemyArr)
        if enemyColidedIndex ~= -1 then
            playerManager:takeDamage();
            enemySpawnManager:DestoryEnemy(enemyColidedIndex)

            if playerManager.currentHp <= 0 then
                resetGame()
            end
        end
    end

    if (enemySpawnManager.enemiesLeftToSpawn == 0) and (Utils.tablelength(enemySpawnManager.enemyArr) == 0) then
        resetGame()
    end
end


function love.draw()

    explosionManager:draw()


    if not isGameInit() then
        love.graphics.printf("Press S to start!!!", Model.stage.stageWidth/2 - 100, Model.stage.stageHeight/2 - 100, 200, "center")
        return
    end

    love.graphics.print("Score: "..tostring(score), Model.stage.stageWidth - 100, 0)

    --love.graphics.draw(AssetsManager.sprites.fireAngles, 0,0 )
    stars:draw()
    playerManager:draw()
    bulletManager:draw()
    enemySpawnManager:draw()
    itemManager:draw()
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



