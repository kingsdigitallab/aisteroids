package = "aisteroids"
version = "dev-1"
source = {
   url = "*** please add URL for source tarball, zip or repository here ***"
}
description = {
   summary = "Asteroids clone",
   detailed = [[
A(I)steroids is an [Asteroids](<https://en.wikipedia.org/wiki/Asteroids_(video_game)>)
clone developed in the [Love2D](https://love2d.org/) framework. The classic
Asteroids game mechanics are used as a metaphor for the volatile and fragmented
nature of AI technology and markets.]],
   homepage = "*** please enter a project homepage ***",
   license = "MIT"
}
build = {
   type = "builtin",
   modules = {
      ["entities.asteroid"] = "src/entities/asteroid.lua",
      ["entities.bullet"] = "src/entities/bullet.lua",
      ["entities.player"] = "src/entities/player.lua",
      ["states.gamestate"] = "src/states/gamestate.lua",
      ["systems.collision"] = "src/systems/collision.lua",
      ["data.stock"] = "src/data/stock.lua",
      utils = "src/utils.lua"
   }
}
