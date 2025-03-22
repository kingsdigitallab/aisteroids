local love = require("love")

local fonts = require("src.utils.fonts")
local Stock = require("src.data.stock")

local Game = {
    game_over = false,
    level = 1,
    paused = false,
    score = 0,
    shield_time = 0,
    ship_collision_time = 0,
    ships = 3,
    welcome = true,
}

function Game.init()
    Game.game_over = false
    Game.level = 1
    Game.score = 0
    Game.shield_time = 0
    Game.ship_collision_time = 0
    Game.ships = 3
end

function Game.update(dt)
    if Game.shield_time > 0 then
        Game.shield_time = Game.shield_time - dt
    end

    if Game.ship_collision_time > 0 then
        Game.ship_collision_time = Game.ship_collision_time - dt
    end
end

function Game.draw()
    local height = love.graphics.getHeight()
    local width = love.graphics.getWidth()

    -- Game stats in top left corner
    love.graphics.printf("Score: $" .. string.format("%.2f", Game.get_score()), 10, 10, width, "left")
    love.graphics.printf("Level: " .. Game.get_level(), 10, 30, width, "left")
    love.graphics.printf("Ships: " .. Game.get_ships(), 10, 50, width, "left")

    -- Market date at top right
    love.graphics.printf(Game.get_date(), 0, 10, width - 10, "right")

    if Game.is_paused() then
        fonts.set_font("instructions")
        love.graphics.printf("Game Paused", 0, height / 3, width, "center")
        fonts.reset_font()
        love.graphics.printf("'P' to unpause", 0, height / 3 + 80, width, "center")
        love.graphics.printf("'R' to restart", 0, height / 3 + 100, width, "center")
        love.graphics.printf("'Q' to quit", 0, height / 3 + 120, width, "center")
    end

    if Game.is_game_over() then
        fonts.set_font("instructions")
        love.graphics.printf("Game Over", 0, height / 4, width, "center")
        fonts.reset_font()
        love.graphics.printf("'R' to restart", 0, height / 3 + 80, width, "center")
        love.graphics.printf("'Q' to quit", 0, height / 3 + 100, width, "center")
    end
end

function Game.get_date()
    return Stock.get_date(Game.level)
end

function Game.is_game_over()
    return Game.game_over
end

function Game.get_level()
    return Game.level
end

function Game.next_level()
    Game.level = Game.level + 1
end

function Game.previous_level()
    if Game.level > 1 then
        Game.level = Game.level - 1
    end
end

function Game.is_paused()
    return Game.paused
end

function Game.set_paused(paused)
    Game.paused = paused
end

function Game.toggle_pause()
    Game.paused = not Game.paused
end

function Game.get_score()
    return Game.score
end

function Game.add_score(points)
    Game.score = Game.score + points
end

function Game.has_shield()
    return Game.shield_time > 0
end

function Game.shield_up(duration)
    Game.shield_time = duration
end

function Game.get_shield_time()
    return Game.shield_time
end

function Game.set_ship_collision_time(duration)
    Game.ship_collision_time = duration
end

function Game.get_ship_collision_time()
    return Game.ship_collision_time
end

function Game.ship_collision()
    return Game.ship_collision_time > 0
end

function Game.get_ships()
    return Game.ships
end

function Game.lose_ship()
    Game.ships = Game.ships - 1
    if Game.ships <= 0 then
        Game.game_over = true
    end
end

return Game
