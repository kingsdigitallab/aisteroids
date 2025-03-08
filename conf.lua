local love = require('love')

-- https://love2d.org/wiki/Config_Files
function love.conf(t)
    t.gammacorrect = true

    t.window.highdpi = true
    t.window.height = 720
    t.window.resizable = true
    t.window.title = "A(I)steroids"
    t.window.usedpiscale = true
    t.window.width = 1280
end
