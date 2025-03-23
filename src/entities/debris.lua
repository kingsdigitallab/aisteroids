local love = require('love')

local asteroid = require('src.entities.asteroid')
local colours = require('src.utils.colours')

local Debris = {
    debris = {},
    lifetime = .2
}

function Debris.create(asteroid_opts)
    local num_debris = math.max(math.floor(asteroid_opts.size / 2), 3)

    for i = 1, num_debris do
        local angle = (i / num_debris) * math.pi * 2
        local speed = math.random(10, 25)
        local debris = asteroid.create({
            x = asteroid_opts.x + math.random(-10, 10),
            y = asteroid_opts.y + math.random(-10, 10),
            size = math.random(1, 3),
            colour = asteroid_opts.colour,
            segments = math.max(asteroid_opts.segments / 4, 3),
            rotation = asteroid_opts.rotation,
            rotation_speed = asteroid_opts.rotation_speed * 4,
            dx = math.cos(angle) * speed,
            dy = math.sin(angle) * speed,
        })

        debris.lifetime = Debris.lifetime * asteroid_opts.size

        table.insert(Debris.debris, debris)
    end
end

function Debris.update(dt)
    for i, debris in ipairs(Debris.debris) do
        debris.x = debris.x + debris.dx * 7.5 * dt
        debris.y = debris.y + debris.dy * 7.5 * dt

        debris.rotation = debris.rotation + debris.rotation_speed * dt

        debris.x = debris.x % love.graphics.getWidth()
        debris.y = debris.y % love.graphics.getHeight()

        local alpha = debris.colour[4] - dt / 2
        local colour = { debris.colour[1], debris.colour[2], debris.colour[3], alpha }
        debris.colour = colour

        debris.lifetime = debris.lifetime - dt

        if debris.lifetime <= 0 then
            table.remove(Debris.debris, i)
        end
    end
end

function Debris.draw()
    for _, debris in ipairs(Debris.debris) do
        love.graphics.push()
        love.graphics.translate(debris.x, debris.y)
        love.graphics.rotate(debris.rotation)
        love.graphics.setColor(debris.colour)
        love.graphics.polygon('line', debris.vertices)
        love.graphics.setColor(colours.UI.COLOUR)
        love.graphics.pop()
    end
end

return Debris
