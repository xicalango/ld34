
Logger = class("Logger")
Logger.static.logLevel = 5

function Logger.static.setLogLevel( level )
  Logger.static.logLevel = level
end

function Logger:initialize( tag )
  self.tag = tag
end

function Logger:_log( logLevel, formatstr, ... )
  local text = string.format(formatstr, ...)
  
  self:output(string.format("%s [%s] %s - %s", os.date("%X"), self.tag, logLevel, text))
end

function Logger:output(line)
  print(line)
end

function Logger:debug(text, ...)
  if Logger.static.logLevel < 4 then
    return
  end
  
  self:_log( "DEBUG", text, ... )
end

function Logger:info(text, ...)
  if Logger.static.logLevel < 3 then
    return
  end
  
  self:_log( "INFO", text, ... )
end

function Logger:warn(text, ...)
  if Logger.static.logLevel < 2 then
    return
  end
  
  self:_log( "WARN", text, ... )
end

function Logger:err(text, ...)
  if Logger.static.logLevel < 1 then
    return
  end
  
  self:_log( "ERROR", text, ... )
end

local GraphicLogger = Logger:subclass("Logger.GraphicLogger")

function GraphicLogger:initialize( tag, manager )
  Logger.initialize( self, tag )
  
  self.manager = manager
end

function GraphicLogger:output(line)
  self.manager:setLine( self.tag, line )
end

local GraphicLogManager = class("GraphicLogManager")

function GraphicLogManager:initialize()
  self.lineCounter = 0
  self.lines = {}
  self.tags = {}
end

function GraphicLogManager:createLogger( tag )
  local logger = GraphicLogger:new( tag, self )
  
  self.tags[tag] = self.lineCounter + 1
  self.lineCounter = self.lineCounter + 1
  
  return logger
end

function GraphicLogManager:draw()
  for i, v in ipairs(self.lines) do
    love.graphics.print( v, 5, ((i-1) * 15) + 5)
  end
end

function GraphicLogManager:setLine( tag, line )
  self.lines[ self.tags[tag] ] = line
end

GLM = GraphicLogManager:new()
