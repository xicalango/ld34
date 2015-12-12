-- #LD34 - 2015 by <weldale@gmail.com>
-- #LD31 - 2014 by <weldale@gmail.com>
-- Paddle Game - #LD30 -- by <weldale@gmail.com>
-- Original: Rocks-n-Blaster -- #LD48 -- by <weldale@gmail.com> https://github.com/xicalango/Rocks-n-Blaster

AbstractGraphics = class("AbstractGraphics")

function AbstractGraphics:initialize(ox, oy)
	self.offset = {ox or 0, oy or 0}
	self.scale = {1, 1}
	self.rotation = 0
  self.tint = {255, 255, 255, 255}
end

function AbstractGraphics:draw(x, y)
	self:_draw(x, y, self.offset[1], self.offset[2], self.rotation, self.scale[1], self.scale[2])
end

function AbstractGraphics:_draw(x, y, ox, oy, r, sx, sy)
	assert(false)
end

function AbstractGraphics:update(dt)
end

Graphics = AbstractGraphics:subclass("Graphics")

function Graphics:initialize(file, ox, oy)
	AbstractGraphics.initialize(self, ox, oy)

  if type(file) == "string" then
  	self.graphics = love.graphics.newImage(file)
  else
    self.graphics = file
  end
end 

function Graphics:_draw(x, y, ox, oy, r, sx, sy)
  withColor(self.tint, function()
  	love.graphics.draw( self.graphics, x, y, r, sx, sy, ox, oy)
  end)
end

TextGraphics = AbstractGraphics:subclass("TextGraphics")

function TextGraphics:initialize(text)
	AbstractGraphics.initialize(self)
	self.text = text
end

function TextGraphics:_draw(x, y, ox, oy, r, sx, sy)
	utils.withColor(self.tint, function()
		love.graphics.print( self.text, x, y, r, sx, sy, ox, oy ) 
	end)
end
