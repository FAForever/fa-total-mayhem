---------------------------------------------------------------------	
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
---------------------------------------------------------------------
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/cybranweapons.lua')
local WeaponsFile2 = import('/lua/terranweapons.lua')
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local CDFHeavyDisintegratorWeapon = WeaponsFile.CDFHeavyDisintegratorWeapon
local CDFHeavyMicrowaveLaserGeneratorCom = WeaponsFile.CDFHeavyMicrowaveLaserGeneratorCom
local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon

---@class BRMT3GARG : CWalkingLandUnit
BRMT3GARG = Class(CWalkingLandUnit){
	Weapons = {
		MainGun = Class(CDFHeavyDisintegratorWeapon){},
		rockets = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		robottalk = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
		laser = Class(CDFHeavyMicrowaveLaserGeneratorCom){ FxMuzzleFlashScale = 2.7 },
		DeathWeapon = Class(SCUDeathWeapon){},
	},

	---@param self BRMT3GARG
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		CWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)

		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('robottalk', false)
		else
			self:SetWeaponEnabledByLabel('robottalk', true)
		end
	end,
}

TypeClass = BRMT3GARG
