------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
------------------------------------------------------------------------
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/cybranweapons.lua')
local WeaponsFile2 = import('/lua/terranweapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local CCannonMolecularWeapon = WeaponsFile.CCannonMolecularWeapon
local CDFHeavyMicrowaveLaserGeneratorCom = WeaponsFile.CDFHeavyMicrowaveLaserGeneratorCom
local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon

-- Upvalue for performance
local TrashBagAdd = TrashBag.Add
local CreateAttachedEmitter = CreateAttachedEmitter
local IsUnit = IsUnit


---@class BRMT1ADVBOT : CWalkingLandUnit
BRMT1ADVBOT = Class(CWalkingLandUnit){
	Weapons = {
		HeavyBolter = Class(CCannonMolecularWeapon){
			FxMuzzleFlash = EffectTemplate.CElectronBolterMuzzleFlash01,
			FxMuzzleFlashScale = 0.4,
		},
		HeavyBolter2 = Class(CCannonMolecularWeapon){
			FxMuzzleFlash = EffectTemplate.CElectronBolterMuzzleFlash01,
			FxMuzzleFlashScale = 0.8,
		},
		rocket = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.45 },
		MainGun = Class(CDFHeavyMicrowaveLaserGeneratorCom){},
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
	},

	---@param self BRMT1ADVBOT
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

	---@param self BRMT1ADVBOT
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		CWalkingLandUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRMT1ADVBOT
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['CybranT2BeetleHit01'] do
			TrashBagAdd(trash,CreateAttachedEmitter(self, 'BRMT1ADVBOT', army, v):ScaleEmitter(1.25))
		end
	end,
}
TypeClass = BRMT1ADVBOT