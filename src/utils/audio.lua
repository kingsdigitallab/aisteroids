local love = require('love')

local Audio = {
    bgm = love.audio.newSource('assets/music/aisteroids.ogg', 'stream'),
    laser = love.audio.newSource('assets/sounds/laser.ogg', 'static'),
    thrusters = love.audio.newSource('assets/sounds/thrusters.ogg', 'static'),
    explosion = love.audio.newSource('assets/sounds/explosion.ogg', 'static'),
    asteroid_hit = love.audio.newSource('assets/sounds/asteroid_hit.ogg', 'static')
}

function Audio.play_bgm()
    Audio.bgm:play()
    Audio.bgm:setLooping(true)
    Audio.bgm:setVolume(0.2)

    Audio.explosion:setVolume(0.5)
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

function Audio.play_explosion()
    Audio.explosion:play()
end

function Audio.play_asteroid()
    Audio.asteroid:play()
end

return Audio
