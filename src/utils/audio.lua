local love = require('love')

local Audio = {
    bgm = love.audio.newSource('assets/music/aisteroids.ogg', 'stream'),
    laser = love.audio.newSource('assets/sounds/laser.ogg', 'static'),
    thrusters = love.audio.newSource('assets/sounds/thrusters.ogg', 'static')
}

function Audio.play_bgm()
    Audio.bgm:play()
    Audio.bgm:setLooping(true)
    Audio.bgm:setVolume(0.2)
end

function Audio.stop_bgm()
    Audio.bgm:stop()
end

function Audio.play_laser()
    if Audio.laser:isPlaying() then
        Audio.laser:stop()
    end

    Audio.laser:play()
end

function Audio.play_thrusters()
    if not Audio.thrusters:isPlaying() then
        Audio.thrusters:play()
    end
end

function Audio.stop_thrusters()
    Audio.thrusters:stop()
end

return Audio
