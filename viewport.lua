
Viewport = Rect:subclass("Rect.Viewport")

function Viewport:initialize(x, y, w, h)
  Rect.initialize( self, x, y, w, h )
  
  self.originalX = x
  self.originalY = y
  
  self.shake = 0
  self.severity = 0
end

function Viewport:startShake( time, severity )
  self.shake = time or 1
  self.severity = severity or 10
end

function Viewport:update(dt)
  if self.shake > 0 then
    self:_shake(dt)
  end
end

function Viewport:_shake(dt)
  self.shake = self.shake - dt
  if self.shake <= 0 then
    self.x = self.originalX
    self.y = self.originalY
    return
  end
  
  local factor = self.shake * self.severity
  
  self.x = self.originalX + (love.math.random() * factor) - (factor/2)
  self.y = self.originalY + (love.math.random() * factor) - (factor/2)
  
end
