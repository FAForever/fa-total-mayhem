--------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------
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

---@class BRMT1BEETLE : CWalkingLandUnit
BRMT1BEETLE = Class(CWalkingLandUnit){
	Weapons = {
		HeavyBolter = Class(CCannonMolecularWeapon){
			FxMuzzleFlash = EffectTemplate.CElectronBolterMuzzleFlash01,
			FxMuzzleFlashScale = 3.55,
		},
		HeavyBolter2 = Class(CCannonMolecularWeapon){
			FxMuzzleFlash = EffectTemplate.CElectronBolterMuzzleFlash01,
			FxMuzzleFlashScale = 3.55,
		},
		rocket = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.45 },
		MainGun = Class(CDFHeavyMicrowaveLaserGeneratorCom){},
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
	},

	---@param self BRMT1BEETLE
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

	---@param self BRMT1BEETLE
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		CWalkingLandUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRMT1BEETLE
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash
		for _, v in TMEffectTemplate['CybranT2BeetleHit01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'BRMT1BEETLE', army, v):ScaleEmitter(1.25))
		end
	end,
}

TypeClass = BRMT1BEETLE
