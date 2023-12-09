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

return Utils