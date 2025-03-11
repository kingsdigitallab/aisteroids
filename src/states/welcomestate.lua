local love = require('love')

local colours = require('src.utils.colours')

local WelcomeState = {
    active = false,
    title = "A(I)STEROIDS",
    instructions = "Press SPACE to start",
    instructions_colour = { colours.UI.COLOUR[1], colours.UI.COLOUR[2], colours.UI.COLOUR[3], colours.UI.COLOUR[4] },
    instructions_alpha_direction = -1,
    font = love.graphics.getFont(),
    title_width = 200,
}

function WelcomeState.init()
    WelcomeState.active = true
end

function WelcomeState.update(dt)
    if WelcomeState.instructions_colour[4] >= 1 then
        WelcomeState.instructions_alpha_direction = -1
    elseif WelcomeState.instructions_colour[4] <= 0.25 then
        WelcomeState.instructions_alpha_direction = 1
    end

    WelcomeState.instructions_colour[4] = WelcomeState.instructions_colour[4] +
        WelcomeState.instructions_alpha_direction * dt
end

function WelcomeState.draw()
    if not WelcomeState.active then return end

    love.graphics.setColor(colours.UI.COLOUR)
    love.graphics.print(
        WelcomeState.title,
        love.graphics.getWidth() / 2 - WelcomeState.font:getWidth(WelcomeState.title) / 2,
        love.graphics.getHeight() / 3
    )

    love.graphics.setColor(WelcomeState.instructions_colour)
    love.graphics.print(
        WelcomeState.instructions,
        love.graphics.getWidth() / 2 - WelcomeState.font:getWidth(WelcomeState.instructions) / 2,
        love.graphics.getHeight() / 2
    )

    love.graphics.setColor(colours.UI.COLOUR)
end

function WelcomeState.is_active()
    return WelcomeState.active
end

function WelcomeState.exit()
    WelcomeState.active = false
end

return WelcomeState
