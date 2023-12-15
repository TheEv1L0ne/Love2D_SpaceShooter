local classes = require("classes")
local Item = classes.class()
local Model = require("Model")
local Utils = require("Helpers/Utils")
local Vector = require("Helpers/Vector")
local tween = require("Helpers/tween")

function Item:init()
    print("Item init!")
    self.position = Vector.new(Model.stage.stageWidth / 2, Model.stage.stageHeight / 2)

    self.ItemAlpha = 1
    self.timeCreated = 0

    self.fadeTween = nil
    self.fadeProperties = nil
end

function Item:setParams(params)
    self.asset = params.asset
    self.w = self.asset:getWidth()
    self.h = self.asset:getHeight()
    self.itemName = params.assetName
end

function Item:update(dt)
    self.fadeTween:update(dt)

    -- not most beautiful solution but at least works...
    self.ItemAlpha = self.fadeProperties.ItemAlpha
end

-- simple function to move item object
function Item:moveTo(destination, t)

    local xMove = math.abs(self.position.x - destination.x) * t * 2
    local yMove = math.abs(self.position.y - destination.y) * t * 2

    if self.position.x < destination.x then 						
        self.position.x = self.position.x + xMove			
    end
     
    if self.position.x > destination.x then 						
        self.position.x = self.position.x - xMove		
    end
     
    if self.position.y < destination.y then 						
        self.position.y = self.position.y + yMove	
    end
     
    if self.position.y > destination.y then 						
        self.position.y = self.position.y - yMove	
    end
end

function Item:createItem(position)

    self.timeCreated = love.timer.getTime()
    self.position = Vector.new(position.x, position.y)

    self.fadeProperties = {ItemAlpha = 0}
    self.fadeTween = tween.new(0.3, self.fadeProperties, {ItemAlpha = 1}, 'linear')
end

function Item:draw()
    local newX , newY = Utils.screenCoordinates(self.position.x, self.position.y, self.w, self.h)
    love.graphics.setColor(1,1,1,self.ItemAlpha)
    love.graphics.draw(self.asset, newX,newY )

    love.graphics.setColor(1,1,1,1)
end

return Item