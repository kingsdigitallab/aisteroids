local love = require('love')

local colours = require('src.utils.colours')
local fonts = require('src.utils.fonts')

local WelcomeState = {
    active = false,
    title = "A(I)STEROIDS",
    instructions = "Press SPACE to start",
    instructions_colour = { colours.UI.COLOUR[1], colours.UI.COLOUR[2], colours.UI.COLOUR[3], colours.UI.COLOUR[4] },
    instructions_alpha_direction = -1,
    commands = "Use the arrow keys to move the ship and SPACE to fire",
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

    local height = love.graphics.getHeight()
    local width = love.graphics.getWidth()
    local instructions_y = height - height / 4

    love.graphics.setColor(colours.UI.COLOUR)
    fonts.set_font("title")
    love.graphics.printf(WelcomeState.title, 0, height / 4, width, "center")

    love.graphics.setColor(WelcomeState.instructions_colour)
    fonts.set_font("instructions")
    love.graphics.printf(WelcomeState.instructions, 0, instructions_y, width, "center")

    love.graphics.setColor(colours.UI.COLOUR)

    fonts.reset_font()
    love.graphics.printf(WelcomeState.commands, 0, instructions_y + 100, width, "center")
end

function WelcomeState.is_active()
    return WelcomeState.active
end

function WelcomeState.exit()
    WelcomeState.active = false
end

return WelcomeState
