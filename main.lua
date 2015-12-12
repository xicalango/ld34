-- #LD34 - 2015 by <weldale@gmail.com>

class = require("lib/middleclass")

require("lib/gamestate")
require("lib/graphics")
require("lib/util")
require("lib/slam")
require("lib/log4l")

require("rect")
require("viewport")
require("camera")
require("world")

require("entity")
require("entities")

keyconfig = require("keyconfig")

require("game")

Debug = {
  drawViewPort = true,
  camera = true
}

LOG = Logger:new("GLOBAL")

function love.load()
  
  LOG:debug("startup")
  
  gameStateManager = GameStateManager:new()
  
  local loadedStates = utils.loadService( require("states") )
  
  gameStateManager:registerAll( loadedStates )
  
  gameStateManager:changeState( InGameState )
end

function love.draw()
  gameStateManager:draw()
  GLM:draw()
end

function love.update(dt)
  gameStateManager:update(dt)
end

function love.keypressed(key, isRepeated)
  gameStateManager:keypressed(key, isRepeated)
end

function love.keyreleased(key)
  gameStateManager:keyreleased(key)
end

function love.mousepressed(x, y, button)
  gameStateManager:mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
  gameStateManager:mousereleased(x, y, button)
end


