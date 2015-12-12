-- #LD34 - 2015 by <weldale@gmail.com>
-- Adapted from #LD31 - 2014 by <weldale@gmail.com>

Entity = class("Entity")

function Entity:initialize(x, y)
  self.x = x or 0
  self.y = y or 0

  self.graphics = nil

  self.rot = 0

  self.vx = 0
  self.vy = 0
  
  self.hitbox = {left = 0, top = 0, right = 0, bottom = 0} 
  
  self.remove = false

  self.isShot = false
  self.isMob = false

  self.hitEffectTime = 0
end

function Entity:graphicOffsetToHitbox()
  self.hitbox.left = self.graphics.offset[1] * self.graphics.scale[1]
  self.hitbox.right = self.graphics.offset[1] * self.graphics.scale[1]
  self.hitbox.top = self.graphics.offset[2] * self.graphics.scale[2]
  self.hitbox.bottom = self.graphics.offset[2] * self.graphics.scale[2]
end

function Entity:update(dt)

  if utils.vlen(self.vx, self.vy) > 0.01 then
    
    local oldX, oldY = self.x, self.y

    self.x = self.x + (self.vx * dt)
    self.y = self.y + (self.vy * dt)

  end

end

function Entity:updateVelocityByRot()
  self.vx, self.vy = utils.toCart( self.velocity, self.rot )
end

function Entity:getHitRectangle(ox, oy)
  ox = ox or self.x
  oy = oy or self.y
  return 
    ox - self.hitbox.left, 
    oy - self.hitbox.top, 
    ox + self.hitbox.right, 
    oy + self.hitbox.bottom
end

function Entity:dirTo(e)
  return toPol(e.x - self.x, e.y - self.y)
end

function Entity:collidesWith(entity, ox, oy)
  local sx1, sy1, sx2, sy2 = self:getHitRectangle(ox, oy)
  local ox1, oy1, ox2, oy2 = entity:getHitRectangle()

  return intersectRect( sx1, sy1, sx2, sy2, ox1, oy1, ox2, oy2 )
end

function Entity:blocks(e)
  return not e.isShot and self.isWall
end

function Entity:onCollideWith( obj )
end

function Entity:onHit(shot)
  self.hitEffectTime = .5  
  if not global.soundMute then
  --  hitSound:play()
  end
end

function Entity:die()
  self.remove=true
end

function Entity:draw()
  if debug.drawHitboxes then
    local x1, y1, x2, y2 = self:getHitRectangle()
    withColor( {255, 0, 0}, function()
      love.graphics.rectangle( "fill", x1, y1, x2-x1, y2-y1 )
    end)
  end
  
  if self.graphics then
    --if self.hitEffectTime >= 0 then
    --  love.graphics.setColor(255 * (self.hitEffectTime / .5), self.graphics.tint[2], self.graphics.tint[3], self.graphics.tint[4])
    --end
    self.graphics.rotation = self.rot
    self.graphics:draw(self.x, self.y)
  end

end

