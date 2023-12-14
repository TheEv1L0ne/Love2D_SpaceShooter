local classes = require("classes")
local Item = classes.class()
local Model = require("Model")
local Utils = require("Utils")
local Vector = require("Vector")
local tween = require("tween")

function Item:init()
    print("Item init!")
    self.position = Vector.new(Model.stage.stageWidth / 2, Model.stage.stageHeight / 2)

    self.ItemAlpha = 1
    self.timeCreated = 0

    self.fadeTween = nil
    self.properties = nil
end

function Item:setParams(params)
    self.asset = params.asset
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()
    self.itemName = params.assetName
end

function Item:update(dt)
    self.fadeTween:update(dt)

    --not the best solution but at least it works! xD
    self.ItemAlpha = self.properties.ItemAlpha
end

function Item:createItem(position)

    self.timeCreated = love.timer.getTime()
    self.position = Vector.new(position.x, position.y)

    self.properties = {ItemAlpha = 0}
    self.fadeTween = tween.new(0.3, self.properties, {ItemAlpha = 1}, 'linear')
end

function Item:draw()
    local newX , newY = Utils.screenCoordinates(self.position.x, self.position.y, self.w, self.h)
    love.graphics.setColor(1,1,1,self.ItemAlpha)
    love.graphics.draw(self.asset, newX,newY )

    love.graphics.setColor(1,1,1,1)
end

return Item