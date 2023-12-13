local classes = require("classes")
local ItemHealthPack = classes.class()
local Model = require("Model")
local Utils = require("Utils")
local Vector = require("Vector")
local tween = require("tween")

function ItemHealthPack:init(params)
    print("ItemHealthPack init!")
    self.asset = params.asset
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()

    self.position = Vector.new(Model.stage.stageWidth / 2, Model.stage.stageHeight / 2)

    self.ItemHealthPackAlpha = 1
end

function ItemHealthPack:update(dt)
    fadeTween:update(dt)

    --not the best solution but at least it works! xD
    self.ItemHealthPackAlpha = properties.ItemHealthPackAlpha
end

function ItemHealthPack:createItem(position)

    self.position = Vector.new(position.x, position.y)

    properties = {ItemHealthPackAlpha = 0}
    fadeTween = tween.new(0.3, properties, {ItemHealthPackAlpha = 1}, 'linear')
end

function ItemHealthPack:draw()
    local newX , newY = Utils.screenCoordinates(self.position.x, self.position.y, self.w, self.h)
    love.graphics.setColor(1,1,1,self.ItemHealthPackAlpha)
    love.graphics.draw(self.asset, newX,newY )

    love.graphics.setColor(1,1,1,1)
end

return ItemHealthPack