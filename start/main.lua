--EXAMPLES
----------------------
--for debugging in zero brane
-- require("mobdebug").start()

--this is to make prints appear right away in zerobrane
io.stdout:setvbuf("no")

----EXAMPLES: INSTANTIARING A CLASS

local ShipCls = require("Ship")
local ship = nil

local StarsCls = require("Stars")
local stars = nil

local BulletCls = require("Bullet")
local bullet = nil

local EnemyCls = require("Enemy")
local enemy = nil

local Collision = require("Collision")
local collision = nil

local AssetsManager = require("AssetsManager")
local Model = require("Model")

local Vector = require("Vector")

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
    ship = ShipCls.new( Model.shipParams )
    bullet = BulletCls.new(Model.bulletParams)
    enemy = EnemyCls.new(Model.enemyParams)
    collision = Collision.new()

    local v1 = Vector.new(2,4)
end

function love.update(dt)
   -- print("update")
    ship:update(dt)
    stars:update(dt)
    
    bullet:update(dt, ship.position.x, ship.position.y)
    enemy:update(dt)

    collision:checkCollision(ship.position.x, enemy.enemyArr)
end


function love.draw()
    --love.graphics.draw(AssetsManager.sprites.fireAngles, 0,0 )
    stars:draw()
    ship:draw()
    bullet:draw()
    enemy:draw()
    
    love.graphics.print(tostring(ship.position.x), 180, 350)
end


function love.keypressed(key)
    print(key)
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



