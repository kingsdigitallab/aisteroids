local love = require('love')

local Background = {
    stars = {}
}

function Background.init()
    Background.stars = {}

    for _ = 1, love.graphics.getWidth() / 10 do
        table.insert(Background.stars, {
            x = love.math.random(0, love.graphics.getWidth()),
            y = love.math.random(0, love.graphics.getHeight()),
            size = love.math.random(0.5, 1.5),
        })
    end
end

function Background.update(dt)
    for _, star in ipairs(Background.stars) do
        star.y = star.y + dt * 4
        if star.y > love.graphics.getHeight() then
            star.y = 0
        end
    end
end

function Background.draw()
    for _, star in ipairs(Background.stars) do
        love.graphics.circle('fill', star.x, star.y, star.size)
    end
end

return Background
