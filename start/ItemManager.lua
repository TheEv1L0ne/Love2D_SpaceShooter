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

    itemSpawnCooldown = 2 --initial spawn cooldown
    itemCd = 4 --after then every 4 seconds
end

function ItemManager:update(dt)

    self:canSpawnItem(dt)

    for i=1, Utils.tablelength(self.itemCoinArr) do
        if self.itemCoinArr[i] ~= nil then
            local item = self.itemCoinArr[i]
            item:update(dt)

            if ((love.timer.getTime() - item.timeCreated) > 3) then
                self:removeItem(i)
            end
        end
    end
end

function ItemManager:canSpawnItem(dt)
    if (itemSpawnCooldown <= 0) then

        local random = math.random() * 100
        local params = nil
        if random <= 85 then --15% chance to spawn health pack
            params = Model.coinParams
        else
            params = Model.healthParams
        end

        self:spawnItem(self.itemCoinArr, ItemCls.new(), params)

        itemSpawnCooldown = itemCd
    else
        itemSpawnCooldown = itemSpawnCooldown - dt
    end
end

function ItemManager:spawnItem(itemArray, itemClass, itemParams)
    local stageWidth = Model.stage.stageWidth
    local stageHeight = Model.stage.stageHeight

    local itemArr = itemArray

    local params = itemParams
    local coinMinSpawnX = params.asset:getWidth() / 2
    local coinMaxSPawnX = stageWidth - coinMinSpawnX

    local coinMinSpawnY = params.asset:getHeight() / 2
    local coinMaxSPawnY = stageHeight - coinMinSpawnY

    local x = Utils.clamp(math.random() * stageWidth, coinMinSpawnX, coinMaxSPawnX)
    local y = Utils.clamp(math.random() * stageHeight, coinMinSpawnY, coinMaxSPawnY)

    local coin = itemClass
    coin:setParams(params)
    coin:createItem(Vector.new(x,y))
    table.insert(itemArr, coin)
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

return ItemManager