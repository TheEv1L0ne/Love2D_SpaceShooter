local AssetsManager = require("AssetsManager")
local Model = {
    movement = {
        up = false,
        down = false,
        left = false,
        right = false,
    },
    fire = 
    {
        space = false
    }
}

Model.shipParams = {
    assetName = "ship",
    speed = 500,
    defaultCannons = 1,
    defaultAngles = 1
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
    speed = 500,
    baseScore = 100
}

Model.enemySpawnParams = {
    totalEnemies = 20
}

Model.explosionParams = {
    assetName = "explosion"
}


-- ITEMS START
Model.coinParams = {
    assetName = "coin",
    amount = 20
}

Model.healthParams = {
    assetName = "health",
    amount = 1
}

Model.fireAngleParams = {
    assetName = "fireAngles",
    duration = 5,
    amount = 3
}

Model.fireRateParams = {
    assetName = "fireRate",
    duration = 5,
    amount = 2,
}

Model.shieldParams = {
    assetName = "shield",
    duration = 5
}

Model.magnetParams = {
    assetName = "magnet",
    duration = 5
}
-- ITEMS END

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
    Model.explosionParams.asset = AssetsManager.sprites[Model.explosionParams.assetName]
    Model.coinParams.asset = AssetsManager.sprites[Model.coinParams.assetName]
    Model.healthParams.asset = AssetsManager.sprites[Model.healthParams.assetName]
    Model.fireRateParams.asset = AssetsManager.sprites[Model.fireRateParams.assetName]
    Model.fireAngleParams.asset = AssetsManager.sprites[Model.fireAngleParams.assetName]
    Model.shieldParams.asset = AssetsManager.sprites[Model.shieldParams.assetName]
    Model.magnetParams.asset = AssetsManager.sprites[Model.magnetParams.assetName]

end

return Model