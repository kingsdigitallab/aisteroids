local love = require('love')

local asteroid = require('src.entities.asteroid')
local bullet = require('src.entities.bullet')
local collision = require('src.systems.collision')
local colours = require('src.utils.colours')
local game_state = require('src.states.gamestate')
local player = require('src.entities.player')

local exit_game = 0
local restart_game = 0

math.randomseed(os.time())

function love.load()
    love.graphics.setBackgroundColor(colours.UI.BACKGROUND)

    game_state.init()

    player.init()

    asteroid.init_asteroids(game_state.get_level())
end

function love.update(dt)
    exit_game = exit_game - dt
    restart_game = restart_game - dt

    game_state.update(dt)

    if game_state.is_game_over() then
        return
    end

    player.update(dt)
    asteroid.update_all(dt)
    bullet.update_all(dt)

    local collisions = collision.check_collisions(game_state, player, bullet.bullets, asteroid.asteroids)

    -- Handle collisions
    for _, collision in ipairs(collisions) do
        asteroid.split(collision.asteroid, collision.asteroid_index)

        if collision.type == "bullet" then
            table.remove(bullet.bullets, collision.bullet_index)

            game_state.add_score(100)
        elseif collision.type == "player" and not game_state.has_shield() then
            game_state.lose_ship()

            -- Player.init()
            bullet.clear_all()

            if not game_state.game_over then
                game_state.shield_up(3)
            end
        end
    end

    -- Check for level completion
    if #asteroid.asteroids == 0 then
        game_state.next_level()
        game_state.shield_up(3)
        asteroid.init_asteroids(asteroid.initial_count + game_state.get_level())
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1, 1)

    player.draw(game_state.has_shield())
    asteroid.draw_all()
    bullet.draw_all()

    love.graphics.print("Ships: " .. game_state.get_ships(), 10, 10)
    love.graphics.print("Level: " .. game_state.get_level(), 10, 25)
    love.graphics.print("Date: " .. game_state.get_date(), 10, 40)
    love.graphics.print("Score: " .. game_state.get_score(), 10, 55)
    love.graphics.print("Press escape twice to quit", 10, love.graphics.getHeight() - 20)
    love.graphics.print("Press n twice to restart", 10, love.graphics.getHeight() - 40)


    if game_state.is_game_over() then
        love.graphics.setColor(1, 0, 0)
        love.graphics.print("Game Over", love.graphics.getWidth() / 4, love.graphics.getHeight() / 2)
        love.graphics.setColor(1, 1, 1)
    end
end

local reset_game = function()
    asteroid.clear_all()
    bullet.clear_all()

    game_state.init()
    player.init()
    asteroid.init_asteroids(game_state.get_level())
end

function love.keypressed(key)
    if key == 'escape' then
        if exit_game <= 0 then
            exit_game = 1
        else
            love.event.quit()
        end
    end

    if key == 'n' then
        if restart_game <= 0 then
            restart_game = 1
        else
            reset_game()
        end
    end

    if key == 'x' then
        reset_game()
        game_state.shield_up(3)
    end

    player.handle_key_press(key)
end
