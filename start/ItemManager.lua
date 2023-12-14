local classes = require("classes")
local ItemManager = classes.class()
local Model = require("Model")
local Utils = require("Utils")
local ItemCls = require("Item")

local Vector = require("Vector")

function ItemManager:init()
    print("ItemManager init!")

    local itemCoinArr = {}
    self.itemCoinArr = itemCoinArr

    itemSpawnCooldown = 1 --initial spawn cooldown
    itemCd = 2 --after then every x seconds

    self.pullTimer = 0
end

function ItemManager:update(dt, playerX, playerY)

    self:itemPullTime(dt)
    self:canSpawnItem(dt)

    for i=1, Utils.tablelength(self.itemCoinArr) do
        if self.itemCoinArr[i] ~= nil then
            local item = self.itemCoinArr[i]
            item:update(dt)

            if self.pullTimer > 0 then
                item:moveTo(Vector.new(playerX, playerY), dt)
            end

            if ((love.timer.getTime() - item.timeCreated) > 3) then
                self:removeItem(i)
            end
        end
    end
end

function ItemManager:canSpawnItem(dt)
    if (itemSpawnCooldown <= 0) then

        local params = self:chooseNextItemToSpawn()
        self:spawnItem(self.itemCoinArr, ItemCls.new(), params)

        itemSpawnCooldown = itemCd
    else
        itemSpawnCooldown = itemSpawnCooldown - dt
    end
end

function ItemManager:chooseNextItemToSpawn()
    local random = math.random() * 100
    local params = nil
    if (random <= 15) then
        params = Model.magnetParams
    elseif (random > 15) and (random <= 30) then
        params = Model.healthParams
    elseif (random > 30) and (random <= 45) then
        params = Model.fireAngleParams
    elseif (random > 45) and (random <= 60) then
        params = Model.fireRateParams
    elseif (random > 60) and (random <= 75) then
        params = Model.shieldParams
    else
        params = Model.coinParams
    end

    return params
end

function ItemManager:spawnItem(itemArray, itemClass, itemParams)
    local stageWidth = Model.stage.stageWidth
    local stageHeight = Model.stage.stageHeight

    local itemArr = itemArray

    local params = itemParams
    local itemMinSpawnX = params.asset:getWidth() / 2
    local itemMaxSPawnX = stageWidth - itemMinSpawnX

    local coinMinSpawnY = params.asset:getHeight() / 2 + 50 -- +50 so it dosent spawn over top UI
    local coinMaxSPawnY = stageHeight - coinMinSpawnY

    local x = Utils.clamp(math.random() * stageWidth, itemMinSpawnX, itemMaxSPawnX)
    local y = Utils.clamp(math.random() * stageHeight, coinMinSpawnY, coinMaxSPawnY)

    local item = itemClass
    item:setParams(params)
    item:createItem(Vector.new(x,y))
    table.insert(itemArr, item)
end

function ItemManager:draw()
    for i=1, Utils.tablelength(self.itemCoinArr) do
        if self.itemCoinArr[i] ~= nil then
            local item = self.itemCoinArr[i]
            item:draw()
        end
    end
end

function ItemManager:createItem(position)

    local itemCoinArr = self.itemCoinArr
    local item = CoinCls.new(Model.explosionParams)
    item:doExplosion(position)
    table.insert(itemCoinArr, item)
end

function ItemManager:removeItem(ItemIndex)
    table.remove(self.itemCoinArr,ItemIndex)
end

function ItemManager:itemPullTime(dt)
    if self.pullTimer > 0 then
        self.pullTimer = self.pullTimer - dt
    else
        self.pullTimer = 0
    end
end

function ItemManager:setItemPullTime()
    self.pullTimer = 5
end

return ItemManager