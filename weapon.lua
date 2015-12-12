

WeaponSpec = class("WeaponSpec")

function WeaponSpec:initialize(name)
  self.name = name
  self.coolDown = 0.1
  self.shotsAtOnce = 
end

Weapon = class("Weapon")
