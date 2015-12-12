
Camera = Rect:subclass("Rect.Camera")

local log = GLM:createLogger("camera")

function Camera:initialize( x, y, w, h )
  Rect.initialize( self, x, y, w, h )
  
  self.centerEntity = nil
  self.centerOffsetX = 0
  self.centerOffsetY = 0
  self.velocity = 500
  
  self.destX = nil
  self.destY = nil
  
  self.moving = false
end

function Camera:update(dt)
  if self.centerEntity ~= nil then
    self:centerOnEntity(true)
  end
  
  if self.destX ~= nil then
    assert( self.destY ~= nil)
    
    local dst, phi = utils.dirTo( self.x, self.y, self.destX, self.destY )
    
    local vx, vy = utils.toCart( (dst * dst) * 0.05, phi )
    
    log:debug("dst = %d vx,vy = %d,%d", dst, vx, vy)
    
    self.x = self.x + vx * dt
    self.y = self.y + vy * dt
    
  end
  
end

function Camera:setCenterOnEntity( entity, offsetX, offsetY )
  self.centerEntity = entity
  self.centerOffsetX = offsetX or 0
  self.centerOffsetY = offsetY or 0
  
  if self.centerEntity == nil then
    self.destX = nil
    self.destY = nil
  end
end

function Camera:centerOnPosition( x, y, soft )
  if soft then
    self.destX = x - self.w / 2
    self.destY = y - self.h / 2
  else
    self.x = x - self.w / 2
    self.y = y - self.h / 2
  end
end

function Camera:centerOnEntity( soft )
  self:centerOnPosition( self.centerEntity.x + self.centerOffsetX, self.centerEntity.y + self.centerOffsetY, soft )
end

function Camera:draw( drawable, viewport )
  assert( viewport )
  local scaleX, scaleY = viewport:getScaleTo( self.w, self.h )
  
  love.graphics.push()
  
  love.graphics.translate( -self.x, -self.y )
  love.graphics.translate( viewport.x, viewport.y )
 
  love.graphics.scale( scaleX, scaleY )

  drawable:draw()
  
  love.graphics.pop()
  
  
  if Debug.drawViewPort then
    local midX = viewport.x + viewport.w / 2
    local midY = viewport.y + viewport.h / 2
    
    utils.withColor({255,0,0,200}, function() 
      love.graphics.rectangle( "line", viewport.x, viewport.y, viewport.w, viewport.h )
      love.graphics.rectangle( "fill", midX - 2, midY - 2, 4, 4 )
    end)
  end
end

