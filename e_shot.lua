

Shot = Entity:subclass("Entity.Shot")

local log = Logger:new("shot")

function Shot:initialize( x, y, vx, vy, owner )
  Entity.initialize( self, x, y )
  
  self.vx = vx
  self.vy = vy
  
  self.owner = owner
  
  self.graphics = TextGraphics:new("*")
  
  self.lifeTime = 10
end

function Shot:update(dt)
  Entity.update(self, dt)
  
  self.lifeTime = self.lifeTime - dt
  
  if self.lifeTime <= 0 then
    self.remove = true
  end
end

