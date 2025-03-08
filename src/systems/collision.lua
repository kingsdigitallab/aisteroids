local utils = require("src.utils.utils")

local Collision = {
    collisions = {}
}

function Collision.check_collisions(game_state, player, bullets, asteroids)
    Collision.collisions = {} -- Clear previous collisions

    -- Check collisions with bullets
    for bullet_index, bullet in ipairs(bullets) do
        for asteroid_index, asteroid in ipairs(asteroids) do
            if utils.circle_collision(
                    bullet.x, bullet.y, bullet.size,
                    asteroid.x, asteroid.y, asteroid.size
                ) then
                table.insert(Collision.collisions, {
                    type = "bullet",
                    asteroid = asteroid,
                    asteroid_index = asteroid_index,
                    bullet_index = bullet_index
                })
            end
        end
    end

    -- Check collision with player
    for i, asteroid in ipairs(asteroids) do
        if not game_state.has_shield() then
            -- Use 80% of player size for better feel
            if utils.circle_collision(
                    player.x, player.y, player.size * 0.8,
                    asteroid.x, asteroid.y, asteroid.size
                ) then
                table.insert(Collision.collisions, {
                    type = "player",
                    asteroid = asteroid,
                    asteroidIndex = i
                })
            end
        end
    end

    -- Check collisions with other asteroids
    -- for asteroid_index, asteroid in ipairs(Asteroid.asteroids) do
    --     for other_asteroid_index, other_asteroid in ipairs(Asteroid.asteroids) do
    --         if asteroid_index ~= other_asteroid_index then
    --             if Utils.circleCollision(asteroid.x, asteroid.y, asteroid.size, other_asteroid.x, other_asteroid.y, other_asteroid.size) then
    --                 Asteroid.bounceAsteroids({ asteroid, other_asteroid })
    --             end
    --         end
    --     end
    -- end

    return Collision.collisions
end

return Collision
