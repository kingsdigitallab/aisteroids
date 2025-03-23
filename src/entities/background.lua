local love = require('love')

local colours = require('src.utils.colours')

local Background = {
    stars = {}
}

function Background.init()
    Background.stars = {}

    for _ = 1, love.graphics.getWidth() / 10 do
        table.insert(Background.stars, {
            x = love.math.random(0, love.graphics.getWidth()),
            y = love.math.random(0, love.graphics.getHeight()),
            colour = { colours.UI.COLOUR[1], colours.UI.COLOUR[2], colours.UI.COLOUR[3], math.random(0.25, 0.75) },
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
        love.graphics.setColor(star.colour)
        love.graphics.circle('fill', star.x, star.y, star.size)
        love.graphics.setColor(colours.UI.COLOUR)
    end
end

return Background
