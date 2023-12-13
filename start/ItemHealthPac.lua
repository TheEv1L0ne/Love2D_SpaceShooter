local classes = require("classes")
local ItemHealthPack = classes.class()
local Model = require("Model")
local Utils = require("Utils")
local Vector = require("Vector")
local tween = require("tween")

function ItemHealthPack:init(params)
    print("ItemHealthPack init!")
    self.position = Vector.new(Model.stage.stageWidth / 2, Model.stage.stageHeight / 2)

    self.ItemHealthPackAlpha = 1
    self.timeCreated = 0

    self.fadeTween = nil
    self.properties = nil
end

function ItemHealthPack:setParams(params)
    self.asset = params.asset
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()
end

function ItemHealthPack:update(dt)
    self.fadeTween:update(dt)

    --not the best solution but at least it works! xD
    self.ItemHealthPackAlpha = self.properties.ItemHealthPackAlpha
end

function ItemHealthPack:createItem(position)

    self.timeCreated = love.timer.getTime()
    self.position = Vector.new(position.x, position.y)

    self.properties = {ItemHealthPackAlpha = 0}
    self.fadeTween = tween.new(0.3, self.properties, {ItemHealthPackAlpha = 1}, 'linear')
end

function ItemHealthPack:draw()
    local newX , newY = Utils.screenCoordinates(self.position.x, self.position.y, self.w, self.h)
    love.graphics.setColor(1,1,1,self.ItemHealthPackAlpha)
    love.graphics.draw(self.asset, newX,newY )

    love.graphics.setColor(1,1,1,1)
end

return ItemHealthPack