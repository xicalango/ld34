

Shot = Entity:subclass("Entity.Shot")

function Shot:initialize( x, y, vx, vy, owner )
  Entity.initialize( x, y )
  
  self.vx = vx
  self.vy = vy
  
  self.owner = owner
  
  self.graphics = TextGraphics:new("*")
  
  self.lifeTime = 1
end

function Shot:update(dt)
  self.lifeTime = self.lifeTime - dt
  
  if self.lifeTime <= 0 then
    self.remove = true
  end
end

