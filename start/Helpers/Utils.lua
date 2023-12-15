local Utils = classes.class()
local Vector = require("Helpers/Vector")

function Utils.screenCoordinates(x,y,w,h)
    local newX = x - (w/2)
    local newY = y - (h/2)
    return newX, newY
end

function Utils.tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function Utils.clamp(number, min, max)
    if number < min then
        return min
    end

    if number > max then
        return max
    end

    return number
end

function Utils.distanceFrom(x1,y1,x2,y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) 
end

function Utils.distanceBetweenTwoPoints(p1, p2)
    return math.sqrt((p2.x - p1.x) ^ 2 + (p2.y - p1.y) ^ 2) 
end

function Utils.rotateAroundPoint(p1, radius, t)
    x = math.cos(2*math.pi*t/2) * radius + p1.x
    y = math.sin(2*math.pi*t/2) * radius + p1.y

    return Vector.new(x,y)
end

return Utils