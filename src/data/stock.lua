local colours = require("src.utils.colours")
local historical_data = require("src.data.historical_data")

local Stock = {}

function Stock.get_date(level)
    local level_data = Stock.get_level_data(level)
    return level_data[1].date
end

function Stock.get_level_data(level)
    local index = level % #historical_data + 1
    return historical_data[index]
end

function Stock.get_asteroid_opts(level)
    local level_data = Stock.get_level_data(level)
    local data = level_data[math.random(1, #level_data)]

    local last_open_diff = data.last - data.open
    local high_low_diff = data.high - data.low
    local velocity = math.max(100, math.abs(high_low_diff))

    local opts = {
        label = data.stock,
        colour = Stock.get_colour(data.last, data.open),
        segments = math.min(50, data.last / 10),
        size = math.min(75, data.volume / 1000000),
        line_width = high_low_diff,
        rotation_speed = last_open_diff,
        dx = math.random(-1 * velocity, velocity),
        dy = math.random(-1 * velocity, velocity),
    }

    return opts
end

function Stock.get_colour(last, open)
    if last > open then
        return colours.ASTEROID.GAIN
    elseif (open - last) > 5.0 then
        return colours.ASTEROID.LARGE_LOSS
    else
        return colours.ASTEROID.SMALL_LOSS
    end
end

return Stock
