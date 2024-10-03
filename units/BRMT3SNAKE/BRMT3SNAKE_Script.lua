--------------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/cybranweapons.lua')
local WeaponsFile2 = import('/lua/terranweapons.lua')
local TMWeaponsFile = import('/mods/fa-total-mayhem/lua/TMAeonWeapons.lua')
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')

local CDFElectronBolterWeapon = WeaponsFile.CDFElectronBolterWeapon
local TMCSpiderLaserweapon = TMWeaponsFile.TMCSpiderLaserweapon
local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon

-- upvalue for performance
local CreateRotator = CreateRotator
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRMT3SNAKE: CWalkingLandUnit
BRMT3SNAKE = Class(CWalkingLandUnit){
	Weapons = {
		main = Class(TMCSpiderLaserweapon){
			FxMuzzleFlash = EffectTemplate.SDFExperimentalPhasonProjChargeMuzzleFlash,
			FxMuzzleFlashScale = 1.0,
		},
		MainGun = Class(CDFElectronBolterWeapon){ FxMuzzleFlashScale = 1.0 },
		HeavyBoltera = Class(CDFElectronBolterWeapon){},
		rocket1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
		DeathWeapon = Class(SCUDeathWeapon){},
	},

	---@param self BRMT3SNAKE
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		CWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
		local trash = self.Trash

		TrashBagAdd(trash, CreateRotator(self, 'Object04', 'z', nil, 650, 0, 0))
		TrashBagAdd(trash, CreateRotator(self, 'Object03', 'z', nil, -650, 0, 0))
		self:CreateTheEffects()

		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('robottalk', false)
		else
			self:SetWeaponEnabledByLabel('robottalk', true)
		end
	end,

	---@param self BRMT3SNAKE
	CreateTheEffects = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Object04', army, v):ScaleEmitter(6.00))
		end
		for _, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Object03', army, v):ScaleEmitter(6.00))
		end
		for _, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Object04', army, v):ScaleEmitter(1))
		end
		for _, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Object03', army, v):ScaleEmitter(1))
		end
		for _, v in EffectTemplate['OthuyAmbientEmanation'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Object04', army, v):ScaleEmitter(0.3))
		end
		for _, v in EffectTemplate['OthuyAmbientEmanation'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Object03', army, v):ScaleEmitter(0.3))
		end
		for _, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'eff01', army, v):ScaleEmitter(0.14))
		end
		for _, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'eff02', army, v):ScaleEmitter(0.14))
		end
		for _, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'eff03', army, v):ScaleEmitter(0.14))
		end
		for _, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'eff04', army, v):ScaleEmitter(0.14))
		end
	end,

	---@param self BRMT3SNAKE
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		CWalkingLandUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRMT3SNAKE
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['MadCatDeath01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Turret', army, v):ScaleEmitter(1.5))
		end
	end,
}

TypeClass = BRMT3SNAKE
