local AssetsManager = require("AssetsManager")
local Model = {
    movement = {
        up = false,
        down = false,
        left = false,
        right = false,
        space = false
    }
}

Model.shipParams = {
    assetName = "ship",
    speed = 500
}

Model.starsParams = {
    radius = 1,
    speed = 100,
    numStars = 200
}

Model.bulletParams = 
{
    assetName = "bullet",
    fireRate = 1
}

Model.init = function()
    Model.stage = {
        stageHeight = love.graphics.getHeight(),
        stageWidth = love.graphics.getWidth()
    }
    
    
    --init assets dynamically
    Model.shipParams.asset = AssetsManager.sprites[Model.shipParams.assetName]
    Model.bulletParams.asset = AssetsManager.sprites[Model.bulletParams.assetName]
    
    --define enemies here

end

Model.isInScreenBoundries = function(x,y,w,h)
    return (
        (x < Model.stage.stageWidth - w) 
        and ( 0  < x)
        and (y < Model.stage.stageHeight - h)
        and (0 < y)
    )
end


return Model