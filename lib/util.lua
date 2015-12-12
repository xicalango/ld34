-- utils.lua 2013-2015 <weldale@gmail.com>

utils = {}

function utils.intersectRect( r1x1, r1y1, r1x2, r1y2, r2x1, r2y1, r2x2, r2y2 )
	return not ( 
		r1x2 < r2x1 or 
		r2x2 < r1x1 or
		r2y1 > r1y2 or
		r1y1 > r2y2)
end

function utils.signum( x )
	if x < 0 then
		return -1
	elseif x > 0 then
		return 1
	else
		return 0
	end
end

function utils.dirTo( sourceX, sourceY, destX, destY )
  return utils.toPol( destX - sourceX, destY - sourceY )
end

function utils.velocityTo( sourceX, sourceY, destX, destY, speed )
  local _, phi = utils.dirTo( sourceX, sourceY, destX, destY )
  
  return utils.toCart( speed, phi )
end

function utils.vlenSq( x, y )
	return (x * x) + (y * y)
end

function utils.vlen( x, y )
	return math.sqrt( utils.vlenSq(x, y) )
end

function utils.dstSq( x1, y1, x2, y2 )
	local dx = x2-x1
	local dy = y2-y1
	return (dx*dx) + (dy*dy)
end

function utils.toPol( x, y )
	return math.sqrt(x*x + y*y), math.atan2(y,x)
end

function utils.toCart( r, phi )
	return r * math.cos(phi), r * math.sin(phi)
end

function utils.dirToCart( dir )
	if dir == "up" then
		return 0, -1
	elseif dir == "down" then
		return 0, 1
	elseif dir == "left" then
		return -1, 0
	elseif dir == "right" then
		return 1, 0
	end
end

function utils.randomDir()
	dirs = {"up", "down", "left", "right"}
	return dirs[love.math.random(1,4)]
end

function utils.withColor(rgba, fn)

	local currentColor = {love.graphics.getColor()}

	love.graphics.setColor(rgba)
	fn()
	love.graphics.setColor(currentColor)

end

function utils.loadService( serviceSpecs )
  local services = {}
  
  for _, v in ipairs(serviceSpecs) do
    services[v] = v:new()
  end
  
  return services
end
