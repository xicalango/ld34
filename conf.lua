-- #LD34 -- by <weldale@gmail.com>

function love.conf(t)
  t.title = "LD34"
  t.identity = "LD34"
  t.author = "Alexander Weld <weldale@gmail.com>"
  t.modules.physics = false -- don't need that

  t.window.width      = 640
  t.window.height     = 480

  t.console = true
end
