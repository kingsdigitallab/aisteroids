local Stock = require("src.data.stock")

local Game = {
    game_over = false,
    level = 1,
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
