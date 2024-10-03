------------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
------------------------------------------------------------------------------
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/cybranweapons.lua')
local WeaponsFile2 = import('/lua/terranweapons.lua')
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon

local CDFElectronBolterWeapon = WeaponsFile.CDFElectronBolterWeapon
local CCannonMolecularWeapon = WeaponsFile.CCannonMolecularWeapon
local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon

---@class BRMT3VUL: CWalkingLandUnit
BRMT3VUL = Class(CWalkingLandUnit){
	Weapons = {
		HeavyBolter = Class(CDFElectronBolterWeapon){},
		robottalk = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
		HeavyBolter2 = Class(CDFElectronBolterWeapon){},
		HeavyBolter3 = Class(CDFElectronBolterWeapon){},
		lefthandweapon = Class(CCannonMolecularWeapon){ FxMuzzleFlashScale = 1.6 },
		righthandweapon = Class(CCannonMolecularWeapon){ FxMuzzleFlashScale = 1.6 },
		rocket1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		DeathWeapon = Class(SCUDeathWeapon){},
	},

	---@param self BRMT3VUL
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

TypeClass = BRMT3VUL
