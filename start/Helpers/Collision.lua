local classes = require("classes")
local Collision = classes.class()
local Utils = require("Helpers/Utils")

function Collision:checkCollision(x, y)
    -- we check if rects overlap
    for i=1, Utils.tablelength(y) do
        if self:rectOverlap(x, y[i]) then
            return i
        end
    end

    return -1
end

function Collision:valueInRange(value, min, max)
    return value >= min and value <= max 
end

-- using rects for simplicity
function Collision:rectOverlap(rectA, rectB)
    if rectA == nil or rectB == nil then
        return false
    end
    
    local xOverlap = self:valueInRange(rectA.position.x, rectB.position.x, rectB.position.x + rectB.w)
        or self:valueInRange(rectB.position.x, rectA.position.x, rectA.position.x + rectA.w);

    local yOverlap = self:valueInRange(rectA.position.y, rectB.position.y, rectB.position.y + rectB.h) 
        or self:valueInRange(rectB.position.y, rectA.position.y, rectA.position.y + rectA.h);

    return xOverlap and yOverlap;
end

return Collision