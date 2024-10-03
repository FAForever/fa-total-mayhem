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

local TOrbitalDeathLaserBeamWeapon = WeaponsFile.TOrbitalDeathLaserBeamWeapon
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TDFRiotWeapon = WeaponsFile.TDFRiotWeapon

---@class BRNT3BLASP : TWalkingLandUnit
BRNT3BLASP = Class(TWalkingLandUnit){
	Weapons = {
		Riotgun = Class(TDFRiotWeapon){
			FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank,
			FxMuzzleFlashScale = 0.75,
		},
		Riotgun2 = Class(TDFRiotWeapon){
			FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank,
			FxMuzzleFlashScale = 0.75,
		},
		rocket = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.45 },
		robottalk = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
		DeathWeapon = Class(SCUDeathWeapon){},
		laser = Class(TOrbitalDeathLaserBeamWeapon){ FxMuzzleFlashScale = 0.02 },
		laser2 = Class(TOrbitalDeathLaserBeamWeapon){ FxMuzzleFlashScale = 0.02 },
		gauss1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 1.2 },
		gauss2 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 1.2 },
	},

	---@param self BRNT3BLASP
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

TypeClass = BRNT3BLASP
