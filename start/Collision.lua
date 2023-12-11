local classes = require("classes")
local Collision = classes.class()
local Utils = require("Utils")
local Vector = require("Vector")

function Collision:checkCollision(x, y)
    -- we check if rects overlap
    for i=1, Utils.tablelength(y) do
        if self:rectOverlap(x, y[i]) then
            return true
        end
    end

    return false
end

function Collision:valueInRange(value, min, max)
    return value >= min and value <= max 
end

function Collision:rectOverlap(rectA, rectB)
    local xOverlap = self:valueInRange(rectA.position.x, rectB.position.x, rectB.position.x + rectB.w)
        or self:valueInRange(rectB.position.x, rectA.position.x, rectA.position.x + rectA.w);

    local yOverlap = self:valueInRange(rectA.position.y, rectB.position.y, rectB.position.y + rectB.h) 
        or self:valueInRange(rectB.position.y, rectA.position.y, rectA.position.y + rectA.h);

    return xOverlap and yOverlap;
end

return Collision