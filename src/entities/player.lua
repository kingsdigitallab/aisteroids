local love = require('love')
local colours = require('src.utils.colours')
local Utils = require('src.utils.utils')
local Bullet = require('src.entities.bullet')

local Player = {
    x = 0,
    y = 0,
    rotation = 0,
    dx = 0,
    dy = 0,
    size = 20,
    thrust = 500,
    is_thrusting = false,
    rotation_speed = 5,
    friction = 0.99
}

function Player.init(thrust)
    Player.x = love.graphics.getWidth() / 2
    Player.y = love.graphics.getHeight() / 2
    Player.rotation = 0
    Player.dx = 0
    Player.dy = 0
    Player.thrust = thrust or 500
end

function Player.update(dt)
    -- Rotation
    if love.keyboard.isDown('left') then
        Player.rotation = Player.rotation - Player.rotation_speed * dt
    elseif love.keyboard.isDown('right') then
        Player.rotation = Player.rotation + Player.rotation_speed * dt
    end

    local angle = Utils.get_angle(Player.rotation)

    -- Velocity
    if love.keyboard.isDown('up') then
        Player.dx = Player.dx + math.cos(angle) * Player.thrust * dt
        Player.dy = Player.dy + math.sin(angle) * Player.thrust * dt
        Player.is_thrusting = true
    else
        Player.is_thrusting = false
    end

    -- Break
    if love.keyboard.isDown('down') then
        Player.dx = Player.dx - math.cos(angle) * Player.thrust / 2 * dt
        Player.dy = Player.dy - math.sin(angle) * Player.thrust / 2 * dt
    end

    -- Apply friction
    Player.dx = Player.dx * Player.friction
    Player.dy = Player.dy * Player.friction

    -- Update position
    Player.x = Player.x + Player.dx * dt
    Player.y = Player.y + Player.dy * dt

    -- Screen wrapping
    Player.x = Player.x % love.graphics.getWidth()
    Player.y = Player.y % love.graphics.getHeight()
end

function Player.draw(has_shield)
    love.graphics.push()

    love.graphics.translate(Player.x, Player.y)
    love.graphics.rotate(Player.rotation)

    if has_shield then
        love.graphics.setColor(colours.PLAYER.SHIELD)
        love.graphics.circle('line', 0, 0, Player.size * 1.5)
        love.graphics.setColor(colours.UI.COLOUR)
    end

    love.graphics.polygon('line', 0, -Player.size,
        -Player.size / 1.5, Player.size / 1.5,
        Player.size / 1.5, Player.size / 1.5)

    if Player.is_thrusting then
        love.graphics.setColor(colours.PLAYER.SHIP_THRUST)
        love.graphics.polygon('fill', 0, Player.size * 1.5,
            -Player.size / 2.5, Player.size / 2.5 + 5,
            Player.size / 2.5, Player.size / 2.5 + 5)
    end

    love.graphics.setColor(colours.UI.COLOUR)

    love.graphics.pop()
end

function Player.handle_key_press(key)
    if key == 'space' then
        local angle = Utils.get_angle(Player.rotation)
        Bullet.create(Player.x + math.cos(angle) * Player.size / 2,
            Player.y + math.sin(angle) * Player.size / 2,
            Player.rotation)
    end
end

return Player
