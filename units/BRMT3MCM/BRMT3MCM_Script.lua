--------------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/cybranweapons.lua')
local WeaponsFile2 = import('/lua/terranweapons.lua')
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local CCannonMolecularWeapon = WeaponsFile.CCannonMolecularWeapon
local CDFElectronBolterWeapon = WeaponsFile.CDFElectronBolterWeapon
local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon
local TDFRiotWeapon = WeaponsFile2.TDFRiotWeapon

-- upvalues for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRMT3MCM : CWalkingLandUnit
BRMT3MCM = Class(CWalkingLandUnit){
	Weapons = {
		HeavyBolter = Class(CDFElectronBolterWeapon){},
		HeavyBoltera = Class(CDFElectronBolterWeapon){},
		HeavyBolterb = Class(CDFElectronBolterWeapon){},
		robottalk = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
		HeavyBolter2 = Class(CDFElectronBolterWeapon){},
		HeavyBolter2a = Class(CDFElectronBolterWeapon){},
		HeavyBolter2b = Class(CDFElectronBolterWeapon){},
		mgweapon = Class(TDFRiotWeapon){
			FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank,
			FxMuzzleFlashScale = 0.75,
		},
		lefthandweapon = Class(CCannonMolecularWeapon){ FxMuzzleFlashScale = 1.4 },
		righthandweapon = Class(CCannonMolecularWeapon){ FxMuzzleFlashScale = 1.4 },
		rocket1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		rocket2 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		rocket3 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		rocket4 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		DeathWeapon = Class(SCUDeathWeapon){},
	},

	---@param self BRMT3MCM
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

	---@param self BRMT3MCM
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		CWalkingLandUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRMT3MCM
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['MadCatDeath01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Turret', army, v):ScaleEmitter(1.5))
		end
	end,
}

TypeClass = BRMT3MCM
