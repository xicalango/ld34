-- #LD34 - 2015 by <weldale@gmail.com>
-- #LD31 - 2014 by <weldale@gmail.com>
-- Adapted from: Paddle Game - #LD30 -- by <weldale@gmail.com> https://github.com/xicalango/ld30
-- Original: Rocks-n-Blaster -- #LD48 -- by <weldale@gmail.com> https://github.com/xicalango/Rocks-n-Blaster

GameState = class("GameState")

function GameState:onActivation()
end

function GameState:onDeactivation()
end

function GameState:onStateChange(oldState)
  return true
end

function GameState:update(dt)
end

function GameState:draw()
end

function GameState:keypressed(key, isRepeated)
end

function GameState:keyreleased(key)
end

function GameState:mousepressed(x, y, button)
end

function GameState:mousereleased(x, y, button)
end

NilGameState = GameState:subclass("NilGameState")

GameStateManager = class("GameStateManager")

function GameStateManager:initialize()

	self.states = {}

	self.currentState = NilGameState:new()
	self.currentStateClass = NilGameState

	self.nextStateClass = nil
	self.activationParameters = nil

end

function GameStateManager:draw()
	self.currentState:draw()
end

function GameStateManager:update(dt)

	if self.nextStateClass then
		self:_changeState()
	end


	self.currentState:update(dt)
end

function GameStateManager:keypressed(key, isRepeated)
	self.currentState:keypressed(key, isRepeated)
end

function GameStateManager:keyreleased(key)
	self.currentState:keyreleased(key)
end

function GameStateManager:mousepressed(x, y, button)
  self.currentState:mousepressed(x, y, button)
end

function GameStateManager:mousereleased(x, y, button)
  self.currentState:mousereleased(x, y, button)
end


function GameStateManager:registerState(stateClass)
	self.states[stateClass] = stateClass:new()
end

function GameStateManager:registerAll(states)
  for k,v in pairs(states) do
    self.states[k] = v
  end
end

function GameStateManager:changeState(stateClass, ...)
	assert( self.states[stateClass] )

	self.nextStateClass = stateClass
	self.activationParameters = {...}
end

function GameStateManager:getCurrentState()
  return self.currentState
end

function GameStateManager:_changeState()
	if self.states[self.nextStateClass]:onStateChange( self.currentStateClass ) then

		self.currentState:onDeactivation()

		self.currentStateClass = self.nextStateClass
		self.currentState = self.states[self.nextStateClass]

		self.currentState:onActivation(unpack(self.activationParameters))
	end

	self.nextStateClass = nil
	self.activationParameters = nil
end



