local classes = require("classes")
local ItemCoin = classes.class()
local Model = require("Model")
local Utils = require("Utils")
local Vector = require("Vector")
local tween = require("tween")

function ItemCoin:init()
    print("ItemCoin init!")
    self.position = Vector.new(Model.stage.stageWidth / 2, Model.stage.stageHeight / 2)

    self.ItemCoinAlpha = 1
    self.timeCreated = 0

    self.fadeTween = nil
    self.properties = nil

    self.itemName = "coin"
end

function ItemCoin:setParams(params)
    self.asset = params.asset
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()
end

function ItemCoin:update(dt)
    self.fadeTween:update(dt)

    --not the best solution but at least it works! xD
    self.ItemCoinAlpha = self.properties.ItemCoinAlpha
end

function ItemCoin:createItem(position)

    self.timeCreated = love.timer.getTime()
    self.position = Vector.new(position.x, position.y)

    self.properties = {ItemCoinAlpha = 0}
    self.fadeTween = tween.new(0.3, self.properties, {ItemCoinAlpha = 1}, 'linear')
end

function ItemCoin:draw()
    local newX , newY = Utils.screenCoordinates(self.position.x, self.position.y, self.w, self.h)
    love.graphics.setColor(1,1,1,self.ItemCoinAlpha)
    love.graphics.draw(self.asset, newX,newY )

    love.graphics.setColor(1,1,1,1)
end

return ItemCoin