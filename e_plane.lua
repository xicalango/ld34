

Plane = Entity:subclass("Entity.Plane")

local log = GLM:createLogger("plane")

function Plane:initialize(x, y)
  Entity.initialize( self, x, y )
  
  self.graphics = TextGraphics:new("PLANE")
  self.moving = false
  self.isUp = true
  
  self.shooting = false
  
  self.velocity = 100
  self.rotV = 2
  
  self.coolDown = .1
  self.coolDownCounter = 0
  self.shotSpeed = 300
end

function Plane:start()
  self:updateVelocityByRot()
end


function Plane:keypressed(key, isrepeat)
  if key == keyconfig.player.move then
    self.moving = true
  elseif key == keyconfig.player.action then
    self.shooting = true
  end
  
  self:_logState()
end

function Plane:_logState()
  log:debug("moving: %s, isUp: %s", self.moving, self.isUp)
end

function Plane:keyreleased(key)
  if key == keyconfig.player.move then
    self.moving = false
    self.isUp = not self.isUp
  elseif key == keyconfig.player.action then
    self.shooting = false
  end

  self:_logState()
end

function Plane:update(dt)
  Entity.update( self, dt )
  
  if self.moving then
    
    if self.isUp then
      self.rot = self.rot + dt * self.rotV
    end
    
    if not self.isUp then
      self.rot = self.rot - dt * self.rotV
    end
    
    self:updateVelocityByRot()
    
  end
  
  if self.coolDownCounter >= 0 then
    self.coolDownCounter = self.coolDownCounter - dt
  end
  
  if self.shooting then
    self:_shoot(dt)
  end
  
end

function Plane:_shoot(dt)
  if self.coolDownCounter >= 0 then
    return
  end
  
  local dx, dy = utils.toCart( self.shotSpeed, self.rot )
  
  Game.shoot( self.x, self.y, dx, dy, self )
  
  self.coolDownCounter = self.coolDown
end


