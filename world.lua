

World = class("World")

function World:initialize( camera, player )
  self.camera = camera
  self.player = player
  self.entities = { player }
  self.addEntities = {}
  
  self.camera:setCenterOnEntity( self.player, 200 )
  
  self.player:start()
end

function World:addEntity( entity )
  table.insert( self.addEntities, entity )
end

function World:iterEntities()
  return ipairs(self.entities)
end

function World:update(dt)
  for i, e in self:iterEntities() do
    e:update(dt)
    
    if e.remove then
      table.remove( self.entities, i )
    end
  end
  
  for _, e in ipairs(self.addEntities) do
    table.insert( self.entities, e )
  end
  
  self.addEntities = {}
  
  self.camera:update(dt)
end

function World:draw( viewport )
  for _, e in self:iterEntities() do
    self.camera:draw( e, viewport )
  end
end

function World:keypressed(key, isRepeat)
  self.player:keypressed(key, isRepeat)
end

function World:keyreleased(key)
  self.player:keyreleased(key)
end

