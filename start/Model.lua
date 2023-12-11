local AssetsManager = require("AssetsManager")
local Model = {
    movement = {
        up = false,
        down = false,
        left = false,
        right = false,
        space = false
    },
    fire = 
    {
        space = false
    }
}

Model.shipParams = {
    assetName = "ship",
    speed = 500
}

Model.playerParams = {
    maxHp = 3,
    assetName = "health",
}

Model.starsParams = {
    radius = 1,
    speed = 100,
    numStars = 200
}

Model.bulletParams = 
{
    assetName = "bullet",
    speed = 1000,
    x = 0,
    y = 0
}

Model.bulletManagerParams = 
{
    fireRate = 0.2
}

Model.enemyParams = {
    assetName = "enemy",
    speed = 500
}

Model.init = function()
    Model.stage = {
        stageHeight = love.graphics.getHeight(),
        stageWidth = love.graphics.getWidth()
    }
    
    
    --init assets dynamically
    Model.shipParams.asset = AssetsManager.sprites[Model.shipParams.assetName]
    Model.bulletParams.asset = AssetsManager.sprites[Model.bulletParams.assetName]
    Model.enemyParams.asset = AssetsManager.sprites[Model.enemyParams.assetName]
    Model.playerParams.asset = AssetsManager.sprites[Model.playerParams.assetName]
    
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