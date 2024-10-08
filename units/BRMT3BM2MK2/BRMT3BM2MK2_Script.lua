--------------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local CWeapons = import('/lua/cybranweapons.lua')
local WeaponsFile = import('/lua/terranweapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local CDFHeavyMicrowaveLaserGeneratorCom = CWeapons.CDFHeavyMicrowaveLaserGeneratorCom

-- upvalues for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRMT3BM2MK2 : CWalkingLandUnit
BRMT3BM2MK2 = Class(CWalkingLandUnit){
	Weapons = {
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
		robottalk = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
		maingun1 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 4.1,
			FxMuzzleFlash = EffectTemplate.CElectronBolterMuzzleFlash01,
		},
		maingun2 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 4.1,
			FxMuzzleFlash = EffectTemplate.CElectronBolterMuzzleFlash01,
		},
		gatling1 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 1.1,
			FxMuzzleFlash = EffectTemplate.CElectronBolterMuzzleFlash01,
		},
		gatling2 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 1.1,
			FxMuzzleFlash = EffectTemplate.CElectronBolterMuzzleFlash01,
		},
		gatling3 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 1.1,
			FxMuzzleFlash = EffectTemplate.CElectronBolterMuzzleFlash01,
		},
		gatling4 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 1.1,
			FxMuzzleFlash = EffectTemplate.CElectronBolterMuzzleFlash01,
		},
		laserfront = Class(CDFHeavyMicrowaveLaserGeneratorCom){},
	},

	---@param self BRMT3BM2MK2
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		CWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)

		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,

	---@param self BRMT3BM2MK2
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		CWalkingLandUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRMT3BM2MK2
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['CybranT3BattleBotDeath'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'BRMT3BM2MK2', army, v):ScaleEmitter(6.0))
		end
	end,
}

TypeClass = BRMT3BM2MK2
