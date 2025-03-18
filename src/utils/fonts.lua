local love = require("love")

local Fonts = {
    default = {
        family = "assets/fonts/space-grotesk-latin-400-normal.ttf",
        size = 16,
    },
    title = {
        family = "assets/fonts/space-mono-latin-400-normal.ttf",
        size = love.graphics.getHeight() / 10,
    },
    instructions = {
        family = "assets/fonts/space-mono-latin-400-normal.ttf",
        size = love.graphics.getHeight() / 20,
    },
    fonts = {}
}

function Fonts.init()
    Fonts.fonts.default = love.graphics.newFont(Fonts.default.family, Fonts.default.size)
    Fonts.fonts.title = love.graphics.newFont(Fonts.title.family, Fonts.title.size)
    Fonts.fonts.instructions = love.graphics.newFont(Fonts.instructions.family, Fonts.instructions.size)

    love.graphics.setFont(Fonts.fonts.default)
end

function Fonts.get_font(name)
    return Fonts.fonts[name]
end

function Fonts.set_font(name)
    if not Fonts.fonts[name] then
        love.graphics.setFont(Fonts.fonts.default)
    else
        love.graphics.setFont(Fonts.fonts[name])
    end
end

function Fonts.reset_font()
    love.graphics.setFont(Fonts.fonts.default)
end

return Fonts
