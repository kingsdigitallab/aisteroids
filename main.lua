local love = require('love')

local audio = require('src.utils.audio')
local asteroid = require('src.entities.asteroid')
local background = require('src.entities.background')
local bullet = require('src.entities.bullet')
local collision = require('src.systems.collision')
local colours = require('src.utils.colours')
local debris = require('src.entities.debris')
local fonts = require('src.utils.fonts')
local game_state = require('src.states.gamestate')
local player = require('src.entities.player')
local welcome_state = require('src.states.welcomestate')

math.randomseed(os.time())

local init_game = function()
    game_state.init()
    player.init()
    game_state.shield_up(2)
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
    asteroid.clear_all()
    bullet.clear_all()

    game_state.next_level()
    game_state.shield_up(3)

    background.init()
    asteroid.init_asteroids(game_state.get_level())
end

local previous_level = function()
    asteroid.clear_all()
    bullet.clear_all()

    game_state.previous_level()
    game_state.shield_up(3)

    background.init()
    asteroid.init_asteroids(game_state.get_level())
end

function love.update(dt)
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

    if game_state.is_paused() then
        return
    end

    game_state.update(dt)

    debris.update(dt)

    if game_state.is_changing_level() then
        return
    end

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
        audio.play_asteroid_hit()

        asteroid.split(col.asteroid, col.asteroid_index)
        debris.create(col.asteroid)

        if col.type == "bullet" then
            table.remove(bullet.bullets, col.bullet_index)

            game_state.add_score(col.asteroid.value)
        elseif col.type == "player" and not game_state.has_shield() then
            audio.play_explosion()

            game_state.add_score(-1 * col.asteroid.value)
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

    debris.draw()

    if not game_state.is_changing_level() then
        player.draw(game_state.get_shield_time(), game_state.get_ship_collision_time())
        bullet.draw_all()
        asteroid.draw_all()
    end

    game_state.draw()
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

        return
    end

    if key == 'p' then
        game_state.toggle_pause()
        return
    end

    if (game_state.is_paused() or game_state.is_game_over()) then
        if key == 'q' then
            game_state.set_paused(false)
            welcome_state.init()
            return
        end

        if key == 'r' then
            reset_game()
            return
        end
    end

    if key == 'h' then
        previous_level()
        return
    end

    if key == 'l' then
        next_level()
        return
    end

    if not game_state.is_paused() and not game_state.ship_collision() and not game_state.is_game_over() then
        player.handle_key_press(key)
    end
end
