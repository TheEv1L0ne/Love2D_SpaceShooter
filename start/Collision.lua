local classes = require("classes")
local Collision = classes.class()
local Utils = require("Utils")

function Collision:checkCollision(x, y, minDistance)
    local distance = Utils.distanceBetweenTwoPoints(x,y)

    return distance <= minDistance
end

return Collision