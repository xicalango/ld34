

Rect = class("Rect")

function Rect:initialize(x, y, w, h)
  self.x = x or 0
  self.y = y or 0
  self.w = w or 0
  self.h = h or 0
end

function Rect:transformPoint( other, x, y )
  x = (x / self.w) * other.w
  y = (y / self.y) * other.h
  
  return x, y
end

function Rect:getScaleTo( w, h )
  return self.w / w, self.h / h
end

function Rect:scale( sx, sy )
  sy = sy or sx
  
  self.w = self.w * sx
  self.h = self.h * sy
end


function Rect:transpose( dx, dy )
  self.x = self.x + dx
  self.y = self.y + dy
end
