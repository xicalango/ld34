
InGameState = GameState:subclass("GameState.InGameState")

function InGameState:initialize()
  self.viewport = Viewport:new(0, 0, 640, 480)
  
  local camera = Camera:new(0, 0, 640, 480, self.viewport)
  local playerPlane = Plane:new(160, 120)
  
  self.world = World:new( camera, playerPlane )
end

function InGameState:draw()
  self.world:draw( self.viewport )
end

function InGameState:update(dt)
  self.viewport:update(dt)
  
  self.world:update(dt)
end

function InGameState:keypressed(key, isRepeat)
  if key == "s" then
    self.viewport:startShake( 1, 10 )
 end
  
  self.world:keypressed(key, isRepeat)
end

function InGameState:keyreleased(key)
  self.world:keyreleased(key)
end

return InGameState
