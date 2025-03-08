local love = require('love')

local utils = require('src.utils.utils')

local Bullet = {
    bullets = {},
    speed = 750,
    lifetime = 0.7,
    size = 2
}

function Bullet.create(x, y, rotation)
    local angle = utils.get_angle(rotation)

    local bullet = {
        x = x,
        y = y,
        size = Bullet.size,
        dx = math.cos(angle) * Bullet.speed,
        dy = math.sin(angle) * Bullet.speed,
        time_left = Bullet.lifetime
    }

    table.insert(Bullet.bullets, bullet)
end

function Bullet.draw_all()
    love.graphics.push()

    for _, bullet in ipairs(Bullet.bullets) do
        love.graphics.circle('fill', bullet.x, bullet.y, Bullet.size)
    end

    love.graphics.pop()
end

function Bullet.update_all(dt)
    for i, bullet in ipairs(Bullet.bullets) do
        bullet.x = bullet.x + bullet.dx * dt
        bullet.y = bullet.y + bullet.dy * dt

        bullet.x = bullet.x % love.graphics.getWidth()
        bullet.y = bullet.y % love.graphics.getHeight()

        bullet.time_left = bullet.time_left - dt
        if bullet.time_left <= 0 then
            table.remove(Bullet.bullets, i)
        end
    end
end

function Bullet.clear_all()
    Bullet.bullets = {}
end

return Bullet
