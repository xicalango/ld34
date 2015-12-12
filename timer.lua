
Timer = class("Timer")

local log = Logger:new("Timer")

function Timer:initialize( name, delay, callback, unit )
  self.name = name
  self.delay = delay
  
  self.callback = callback
  
  self.unit = unit or "sec"
end

function Timer:update(dt)
  if self.delay <= 0 then
    return
  end
  
  if self.unit == "sec" then
    self.delay = self.delay - dt
  else
    self.delay = self.delay - 1
  end
  
  if self.delay <= 0 then
    self.delay = self.callback(self)
  end
end

TimerManager = class("TimerManager")

function TimerManager:initialize()
  self.timers = {}
end

function TimerManager:newTimer( name, delay, callback, unit, overwrite )
  if self.timers[name] ~= nil and overwrite ~= true then
    log:warn("timer %s already defined", name)
    return
  end
  
  local timer = Timer:new( name, delay, callback, unit )
  table.insert( self.timers, timer )
  
  return timer
end

function TimerManager:update(dt)
  local deleteTimers = {}
  for k, timer in pairs(self.timers) do
    timer:update(dt)
    
    if timer.delay == nil or timer.delay <= 0 then
      table.insert( deleteTimers, k )
    end
  end
  
  for _, v in ipairs(self.deleteTimers) do
    self.timers[v] = nil
  end
end


