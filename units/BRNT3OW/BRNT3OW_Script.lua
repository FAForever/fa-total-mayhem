--------------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------
local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')

local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TDFRiotWeapon = WeaponsFile.TDFRiotWeapon

---@class BRNT3OW : TWalkingLandUnit
BRNT3OW = Class(TWalkingLandUnit){
	Weapons = {
		Riotgun = Class(TDFRiotWeapon){
			FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank,
			FxMuzzleFlashScale = 0.75,
		},
		topgunaa = Class(TDFRiotWeapon){
			FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank,
			FxMuzzleFlashScale = 0.75,
		},
		rocket = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.45 },
		robottalk = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
		DeathWeapon = Class(SCUDeathWeapon){},
	},

	---@param self BRNT3OW
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		TWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)

		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('robottalk', false)
		else
			self:SetWeaponEnabledByLabel('robottalk', true)
		end
	end,
}

TypeClass = BRNT3OW
