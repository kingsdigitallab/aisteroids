local love = require('love')

local audio = require('src.utils.audio')
local asteroid = require('src.entities.asteroid')
local background = require('src.entities.background')
local bullet = require('src.entities.bullet')
local collision = require('src.systems.collision')
local colours = require('src.utils.colours')
local fonts = require('src.utils.fonts')
local game_state = require('src.states.gamestate')
local player = require('src.entities.player')
local welcome_state = require('src.states.welcomestate')

local exit_game = 0
local restart_game = 0

math.randomseed(os.time())

local init_game = function()
    game_state.init()
    player.init()
    asteroid.init_asteroids(game_state.get_level())
end

function love.load()
    love.graphics.setBackgroundColor(colours.UI.BACKGROUND)

    background.init()
    fonts.init()

    audio.play_bgm()

    welcome_state.init()
    init_game()
end

local next_level = function()
    game_state.next_level()
    game_state.shield_up(3)
    asteroid.init_asteroids(asteroid.initial_count + game_state.get_level())
end

function love.update(dt)
    exit_game = exit_game - dt
    restart_game = restart_game - dt

    background.update(dt)

    if welcome_state.is_active() then
        welcome_state.update(dt)
        if math.random(1, 3000) == 1 then
            asteroid.clear_all()
            asteroid.init_asteroids(math.random(3, 10))
        end
        asteroid.update_all(dt)
        return
    end

    game_state.update(dt)

    if game_state.is_game_over() then
        return
    end

    if not game_state.ship_collision() then
        player.update(dt)
    else
        player.update(0.001)
    end

    asteroid.update_all(dt)
    bullet.update_all(dt)

    local collisions = collision.check_collisions(game_state, player, bullet.bullets, asteroid.asteroids)

    -- Handle collisions
    for _, col in ipairs(collisions) do
        asteroid.split(col.asteroid, col.asteroid_index)

        if col.type == "bullet" then
            table.remove(bullet.bullets, col.bullet_index)

            game_state.add_score(100)
        elseif col.type == "player" and not game_state.has_shield() then
            game_state.lose_ship()
            game_state.set_ship_collision_time(3)

            if not game_state.game_over then
                game_state.shield_up(6)
            end
        end
    end

    -- Check for level completion
    if #asteroid.asteroids == 0 then
        next_level()
    end
end

function love.draw()
    love.graphics.setColor(colours.UI.COLOUR)

    background.draw()

    if welcome_state.is_active() then
        asteroid.draw_all()
        welcome_state.draw()
        return
    end

    player.draw(game_state.get_shield_time(), game_state.get_ship_collision_time())
    asteroid.draw_all()
    bullet.draw_all()

    local height = love.graphics.getHeight()
    local width = love.graphics.getWidth()

    -- Game stats in top left corner
    love.graphics.printf("Score: " .. game_state.get_score(), 10, 10, width, "left")
    love.graphics.printf("Level: " .. game_state.get_level(), 10, 30, width, "left")
    love.graphics.printf("Ships: " .. game_state.get_ships(), 10, 50, width, "left")

    -- Date at top right
    love.graphics.printf(game_state.get_date(), 0, 10, width - 10, "right")

    -- Control instructions at bottom
    love.graphics.printf("Press 'r' twice to restart", 10, height - 50, width, "left")
    love.graphics.printf("Press 'q' twice to quit", 10, height - 30, width, "left")

    if game_state.is_game_over() then
        fonts.set_font("instructions")
        love.graphics.printf("Game Over", 0, height / 4, width, "center")
        fonts.reset_font()
    end
end

local reset_game = function()
    asteroid.clear_all()
    bullet.clear_all()

    init_game()
end

function love.keypressed(key)
    if welcome_state.is_active() then
        if key == 'space' then
            welcome_state.exit()
            reset_game()
        end
        return
    end

    if key == 'm' then
        if audio.bgm:isPlaying() then
            audio.stop_bgm()
        else
            audio.play_bgm()
        end
    end

    if key == 'q' then
        if exit_game <= 0 then
            exit_game = 1
        else
            welcome_state.init()
        end
    end

    if key == 'r' then
        if restart_game <= 0 then
            restart_game = 1
        else
            reset_game()
        end
    end

    if key == 'l' then
        asteroid.clear_all()
        bullet.clear_all()
        next_level()
    end

    if not game_state.ship_collision() then
        player.handle_key_press(key)
    end
end
