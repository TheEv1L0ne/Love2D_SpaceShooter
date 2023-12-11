local Utils = classes.class()

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

return Utils