local love = require('love')

local stock = require("src.data.stock")
local colours = require("src.utils.colours")

local Asteroid = {
    asteroids = {},
    initial_count = 3,
    sizes = {
        large = 50,
        small = 10
    }
}

function Asteroid.init_asteroids(level)
    local count = Asteroid.initial_count + level - 1
    for _ = 1, count do
        local asteroid_opts = stock.get_asteroid_opts(level)
        Asteroid.create(asteroid_opts)
    end
end

function Asteroid.create(opts)
    local num_segments = opts.segments or math.random(5, 15)
    local asteroid_size = opts.size or math.random(Asteroid.sizes.small, Asteroid.sizes.large)

    local asteroid = {
        label = opts.label,
        x = opts.x or math.random(0, love.graphics.getWidth()),
        y = opts.y or math.random(0, love.graphics.getHeight()),
        colour = opts.colour or { 1, 1, 1 },
        line_width = opts.line_width or 1,
        rotation = opts.rotation or math.random() * math.pi * 2,
        rotation_speed = opts.rotation_speed or math.random(-2, 2),
        segments = opts.segments or num_segments,
        size = opts.size or asteroid_size,
        dx = opts.dx or math.random(-100, 100),
        dy = opts.dy or math.random(-100, 100),
        vertices = Asteroid.generate_vertices(num_segments, asteroid_size)
    }

    table.insert(Asteroid.asteroids, asteroid)
end

function Asteroid.generate_vertices(segments, size)
    local vertices = {}

    for i = 1, segments do
        local angle = (i - 1) * 2 * math.pi / segments
        local radius = size * (0.8 + math.random() * 0.4)
        table.insert(vertices, math.cos(angle) * radius)
        table.insert(vertices, math.sin(angle) * radius)
    end

    return vertices
end

function Asteroid.draw_all()
    for _, asteroid in ipairs(Asteroid.asteroids) do
        love.graphics.push()
        love.graphics.translate(asteroid.x, asteroid.y)
        love.graphics.rotate(asteroid.rotation)
        love.graphics.setColor(asteroid.colour)
        love.graphics.setLineWidth(asteroid.line_width)
        love.graphics.polygon('line', asteroid.vertices)
        love.graphics.setLineWidth(1)
        love.graphics.setColor(colours.UI.COLOUR)
        love.graphics.print(asteroid.label, 0, 0)
        love.graphics.pop()
    end
end

function Asteroid.update_all(dt)
    for _, asteroid in ipairs(Asteroid.asteroids) do
        asteroid.x = asteroid.x + asteroid.dx * dt
        asteroid.y = asteroid.y + asteroid.dy * dt

        asteroid.rotation = asteroid.rotation + asteroid.rotation_speed * dt

        -- Screen wrapping
        asteroid.x = asteroid.x % love.graphics.getWidth()
        asteroid.y = asteroid.y % love.graphics.getHeight()
    end
end

function Asteroid.clear_all()
    Asteroid.asteroids = {}
end

function Asteroid.split(asteroid, index)
    if asteroid.size > Asteroid.sizes.small * 1.5 then
        local new_size = asteroid.size * 0.6

        for _ = 1, 2 do
            Asteroid.create({
                x = asteroid.x,
                y = asteroid.y,
                colour = asteroid.colour,
                line_width = asteroid.line_width,
                segments = asteroid.segments,
                size = new_size,
                label = asteroid.label,
                rotation = asteroid.rotation,
                rotation_speed = asteroid.rotation_speed,
            })
        end
    end

    table.remove(Asteroid.asteroids, index)
end

function Asteroid.bounce_asteroids(asteroids)
    for _, asteroid in ipairs(asteroids) do
        asteroid.dx = asteroid.dx * -1
        asteroid.dy = asteroid.dy * -1
        asteroid.rotation_speed = asteroid.rotation_speed * 0.75
    end
end

return Asteroid
