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
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local TMCSpiderLaserweapon = TMWeaponsFile.TMCSpiderLaserweapon
local CDFHeavyMicrowaveLaserGeneratorCom = WeaponsFile.CDFHeavyMicrowaveLaserGeneratorCom
local CDFHeavyDisintegratorWeapon = WeaponsFile.CDFHeavyDisintegratorWeapon
local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon

-- upvalues for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRMT3EXBM : CWalkingLandUnit
BRMT3EXBM = Class(CWalkingLandUnit){
	AirEffects = { '/effects/emitters/hydrocarbon_smoke_01_emit.bp' },
	AirEffectsBones = { 'AttachPoint' },
	WaterEffects = { '/effects/emitters/underwater_idle_bubbles_01_emit.bp' },
	WaterEffectsBones = { 'AttachPoint' },
	Weapons = {
		main = Class(TMCSpiderLaserweapon){
			FxMuzzleFlash = EffectTemplate.SDFExperimentalPhasonProjChargeMuzzleFlash,
			FxMuzzleFlashScale = 1.8,
		},
		mainredlaser1 = Class(CDFHeavyMicrowaveLaserGeneratorCom){},
		rocket = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.1 },
		laser1 = Class(CDFHeavyDisintegratorWeapon){},
		laser2 = Class(CDFHeavyDisintegratorWeapon){},
		laser3 = Class(CDFHeavyDisintegratorWeapon){},
		laser4 = Class(CDFHeavyDisintegratorWeapon){},
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
	},

	---@param self BRMT3EXBM
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		CWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
		local trash = self.Trash

		TrashBagAdd(trash, CreateRotator(self, 'Object01', 'z', nil, 150, 0, 0))
		TrashBagAdd(trash, CreateRotator(self, 'Object02', 'z', nil, -150, 0, 0))

		self:CreateTheEffects()

		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,

	---@param self BRMT3EXBM
	CreateTheEffects = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in EffectTemplate['CT2PowerAmbient'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'maineff01', army, v):ScaleEmitter(1.1))
		end
		for _, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect02', army, v):ScaleEmitter(2.00))
		end
		for _, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect01', army, v):ScaleEmitter(2.00))
		end
		for _, v in EffectTemplate['SmokePlumeLightDensityMed01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Object32', army, v):ScaleEmitter(0.65))
		end
		for _, v in EffectTemplate['SmokePlumeLightDensityMed01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Object44', army, v):ScaleEmitter(0.65))
		end
		for _, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect11', army, v):ScaleEmitter(0.35))
		end
		for _, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect10', army, v):ScaleEmitter(0.35))
		end
		for _, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect09', army, v):ScaleEmitter(0.35))
		end
		for _, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect08', army, v):ScaleEmitter(0.35))
		end
		for _, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect07', army, v):ScaleEmitter(0.35))
		end
		for _, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect06', army, v):ScaleEmitter(0.35))
		end
		for _, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect03', army, v):ScaleEmitter(2.00))
		end
		for _, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect04', army, v):ScaleEmitter(2.50))
		end
		for _, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect05', army, v):ScaleEmitter(3.00))
		end
		for _, v in EffectTemplate['CT2PowerAmbient'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Object02', army, v):ScaleEmitter(0.4))
		end
		for _, v in EffectTemplate['DamageSparks01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect03', army, v):ScaleEmitter(1.7))
		end
		for _, v in EffectTemplate['DamageSparks01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect04', army, v):ScaleEmitter(1.9))
		end
		for _, v in EffectTemplate['DamageSparks01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect05', army, v):ScaleEmitter(2.1))
		end
		for _, v in EffectTemplate['GenericTeleportCharge01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect11', army, v):ScaleEmitter(0.3))
		end
		for _, v in EffectTemplate['GenericTeleportCharge01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect10', army, v):ScaleEmitter(0.3))
		end
		for _, v in EffectTemplate['GenericTeleportCharge01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect08', army, v):ScaleEmitter(0.3))
		end
		for _, v in EffectTemplate['GenericTeleportCharge01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect09', army, v):ScaleEmitter(0.3))
		end
		for _, v in EffectTemplate['GenericTeleportCharge01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect07', army, v):ScaleEmitter(0.3))
		end
		for _, v in EffectTemplate['GenericTeleportCharge01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'effect06', army, v):ScaleEmitter(0.3))
		end
	end,

	---@param self BRMT3EXBM
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		CWalkingLandUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRMT3EXBM
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['UEFHEAVYMISSILE01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'BRMT3EXBM', army, v):ScaleEmitter(3.65))
		end
		for _, v in TMEffectTemplate['CYBRANHEAVYPROTONARTILLERYHIT01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'maineff01', army, v):ScaleEmitter(6.65))
		end
	end,
}

TypeClass = BRMT3EXBM
