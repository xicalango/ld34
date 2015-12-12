

Game = {}

function Game.getPlayerPlane()
  return gameStateManager.currentState.world.player
end

function Game.addEntity( entity )
  gameStateManager.currentState.world:addEntity( entity )
end

function Game.shoot( x, y, vx, vy, owner )
  local shot = Shot:new( x, y, vx, vy, owner )
  
  Game.addEntity( shot )
end

function Game.shake( duration, severity )
  gameStateManager.currentState.viewport:startShake( duration, severity )
end
