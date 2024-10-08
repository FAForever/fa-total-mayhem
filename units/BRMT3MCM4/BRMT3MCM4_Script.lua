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
local EffectTemplate = import('/lua/EffectTemplates.lua')
local RobotTalkFile = import('/lua/cybranweapons.lua')
local TMWeaponsFile = import('/mods/fa-total-mayhem/lua/TMAeonWeapons.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

local CDFHeavyMicrowaveLaserGeneratorCom = WeaponsFile.CDFHeavyMicrowaveLaserGeneratorCom
local CAAMissileNaniteWeapon = WeaponsFile.CAAMissileNaniteWeapon

local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon

local TMMadCatmk4laserweapon = TMWeaponsFile.TMMadCatmk4laserweapon

local CIFGrenadeWeapon = RobotTalkFile.CIFGrenadeWeapon

-- upvalues for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRMT3MCM4 : CWalkingLandUnit
BRMT3MCM4 = Class(CWalkingLandUnit){
	Weapons = {
		robottalk = Class(CIFGrenadeWeapon){ FxMuzzleFlashScale = 0 },
		laserhandweapon = Class(CDFHeavyMicrowaveLaserGeneratorCom){ FxMuzzleFlashScale = 1.6 },
		laserbodyweapon = Class(CDFHeavyMicrowaveLaserGeneratorCom){ FxMuzzleFlashScale = 1.6 },
		lefthandweapon = Class(TMMadCatmk4laserweapon){},
		righthandweapon = Class(TMMadCatmk4laserweapon){},
		Cannon = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 1.00,
			FxMuzzleFlash = EffectTemplate.CArtilleryFlash01,
		},
		Cannon2 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 1.00,
			FxMuzzleFlash = EffectTemplate.CArtilleryFlash01,
		},
		rocket1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		rocket2 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		rocket3 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		rocket4 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		rocket5 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		rocket6 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		rocket7 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		rocket8 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		rocket9 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		rocket10 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		DeathWeapon = Class(SCUDeathWeapon){},
		aarockets = Class(CAAMissileNaniteWeapon){},
		longrangerockets = Class(CAAMissileNaniteWeapon){},
	},

	---@param self BRMT3MCM4
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

	---@param self BRMT3MCM4
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		CWalkingLandUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRMT3MCM4
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['MadCatDeath03'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Turret', army, v):ScaleEmitter(1.5))
		end
	end,
}

TypeClass = BRMT3MCM4
