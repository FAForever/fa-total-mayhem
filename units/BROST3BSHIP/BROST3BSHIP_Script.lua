-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/UAS0302/UAS0302_script.lua
-- **  Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  Aeon Battleship Script
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local ASeaUnit = import('/lua/aeonunits.lua').ASeaUnit
local WeaponsFile = import('/lua/aeonweapons.lua')
local ADFCannonOblivionWeapon = WeaponsFile.ADFCannonOblivionWeapon
local AAAZealotMissileWeapon = WeaponsFile.AAAZealotMissileWeapon
local AANChronoTorpedoWeapon = WeaponsFile.AANChronoTorpedoWeapon

BROST3BSHIP = Class(ASeaUnit){
	FxDamageScale = 2,
	DestructionTicks = 400,
	Weapons = {
		Turret1 = Class(ADFCannonOblivionWeapon){},
		Turret2 = Class(ADFCannonOblivionWeapon){},
		Turret3 = Class(ADFCannonOblivionWeapon){},
		Turret4 = Class(ADFCannonOblivionWeapon){},
		Turret5 = Class(ADFCannonOblivionWeapon){},
		MTurret1 = Class(ADFCannonOblivionWeapon){},
		MTurret2 = Class(ADFCannonOblivionWeapon){},
		AntiAirMissiles = Class(AAAZealotMissileWeapon){},
		Missiles1 = Class(AAAZealotMissileWeapon){},
		Missiles2 = Class(AAAZealotMissileWeapon){},
		Torpedo01 = Class(AANChronoTorpedoWeapon){},
	},
	OnCreate = function(self)
		ASeaUnit.OnCreate(self)
		for i = 1, 3 do
			self.Trash:Add(CreateAnimator(self):PlayAnim(self.Blueprint.Weapon[i].AnimationOpen))
		end
	end,
}

TypeClass = BROST3BSHIP
