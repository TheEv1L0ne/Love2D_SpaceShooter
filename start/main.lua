--EXAMPLES
----------------------
--for debugging in zero brane
-- require("mobdebug").start()

--this is to make prints appear right away in zerobrane
io.stdout:setvbuf("no")

----EXAMPLES: INSTANTIARING A CLASS

local ShipCls = require("Player/Ship")
local ship = nil

local PlayerManagerCls = require("Player/PlayerManager")
local playerManager = nil

local StarsCls = require("Stars")
local stars = nil

local BulletManagerCls = require("Bullets/BulletManager")
local bulletManager = nil

local EnemySpawnCls = require("Enemies/EnemySpawnManager")
local enemySpawnManager = nil

local Collision = require("Collision")
local collision = nil

local AssetsManager = require("AssetsManager")
local Model = require("Model")

local Vector = require("Vector")
local Utils = require("Utils")

local LEFT_KEY = "left"
local RIGHT_KEY = "right"
local UP_KEY = "up"
local DOWN_KEY = "down"

local SPACE_KEY = "space"


function love.load()
    print("love.load")
    AssetsManager.init()
    Model.init()
    stars = StarsCls.new( Model.starsParams)
    playerManager = PlayerManagerCls.new()
    bulletManager = BulletManagerCls.new( Model.bulletManagerParams )
    enemySpawnManager = EnemySpawnCls.new(Model.enemyParams)
    collision = Collision.new()

end

function love.update(dt)
   -- print("update")
    playerManager:update(dt)
    stars:update(dt)
    
    bulletManager:update(dt, playerManager.ship.position.x, playerManager.ship.position.y - (playerManager.ship.h/2))
    enemySpawnManager:update(dt)

    if (enemySpawnManager.enemyArr ~= nil) and (bulletManager.bulletArr ~= nil)then
        for i = 1, Utils.tablelength(bulletManager.bulletArr) do
            local enemyColidedIndex = collision:checkCollision(bulletManager.bulletArr[i], enemySpawnManager.enemyArr)
            if enemyColidedIndex ~= -1 then
                bulletManager:DestoryBullet(i);
                enemySpawnManager:DestoryEnemy(enemyColidedIndex)
            end
        end
    end
end


function love.draw()
    --love.graphics.draw(AssetsManager.sprites.fireAngles, 0,0 )
    stars:draw()
    playerManager:draw()
    bulletManager:draw()
    enemySpawnManager:draw()
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
end

--
--



