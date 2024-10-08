------------------------------------------------------------------------
-- File     :  /cdimage/units/UAA0203/UAA0203_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  Aeon Gunship Script
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
------------------------------------------------------------------------
local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local Utils = import('/lua/utilities.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local CAAMissileNaniteWeapon = CybranWeaponsFile.CAAMissileNaniteWeapon
local CDFHeavyMicrowaveLaserGeneratorCom = CybranWeaponsFile.CDFHeavyMicrowaveLaserGeneratorCom
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon

-- Upvalue for performance
local TrashBagAdd = TrashBag.Add
local CreateAttachedEmitter = CreateAttachedEmitter
local CreateBeamEmitterOnEntity = CreateBeamEmitterOnEntity
local ForkThread = ForkThread

---@class BRMAT2GUNSHIP : AAirUnit
BRMAT2GUNSHIP = Class(AAirUnit){
	Weapons = {
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
		MainGun = Class(CDFHeavyMicrowaveLaserGeneratorCom){},
		MainGun2 = Class(CDFHeavyMicrowaveLaserGeneratorCom){},
		MainGun3 = Class(CDFHeavyMicrowaveLaserGeneratorCom){},
		Missile01 = Class(CAAMissileNaniteWeapon){},
	},
	MovementAmbientExhaustBones = { 'ex01', 'ex02', 'ex03', 'ex04' },
	DestructionPartsChassisToss = { 'BRMAT2GUNSHIP' },
	DestroyNoFallRandomChance = 1.1,

	---@param self BRMAT2GUNSHIP
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		AAirUnit.OnStopBeingBuilt(self, builder, layer)

		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,

	---@param self BRMAT2GUNSHIP
	---@param new VerticalMovementState
	---@param old VerticalMovementState
	OnMotionHorzEventChange = function(self, new, old)
		AAirUnit.OnMotionHorzEventChange(self, new, old)
		local trash = self.Trash

		if self.ThrustExhaustTT1 == nil then
			if self.MovementAmbientExhaustEffectsBag then
				EffectUtils.CleanupEffectBag(self, 'MovementAmbientExhaustEffectsBag')
			else
				self.MovementAmbientExhaustEffectsBag = {}
			end
			self.ThrustExhaustTT1 = TrashBagAdd(trash,ForkThread(self.MovementAmbientExhaustThread,self))
		end

		if new == 'Stopped' and self.ThrustExhaustTT1 ~= nil then
			KillThread(self.ThrustExhaustTT1)
			EffectUtils.CleanupEffectBag(self, 'MovementAmbientExhaustEffectsBag')
			self.ThrustExhaustTT1 = nil
		end
	end,

	---@param self BRMAT2GUNSHIP
	MovementAmbientExhaustThread = function(self)
		while not self.Dead do
			local ExhaustEffects =
				{ '/effects/emitters/dirty_exhaust_smoke_01_emit.bp', '/effects/emitters/dirty_exhaust_sparks_01_emit.bp' }
			local ExhaustBeam = '/effects/emitters/missile_exhaust_fire_beam_03_emit.bp'
			local army = self.Army

			for _, vE in ExhaustEffects do
				for _, vB in self.MovementAmbientExhaustBones do
					table.insert(self.MovementAmbientExhaustEffectsBag, CreateAttachedEmitter(self, vB, army, vE))
					table.insert(self.MovementAmbientExhaustEffectsBag, CreateBeamEmitterOnEntity(self, vB, army, ExhaustBeam))
				end
			end

			WaitSeconds(2)
			EffectUtils.CleanupEffectBag(self, 'MovementAmbientExhaustEffectsBag')

			WaitSeconds(Utils.GetRandomFloat(1, 7))
		end
	end,

	---@param self BRMAT2GUNSHIP
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		AAirUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRMAT2GUNSHIP
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash
		for _, v in TMEffectTemplate['CybranT2BeetleHit01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'BRMAT2GUNSHIP', army, v):ScaleEmitter(2.35))
		end
	end,
}
TypeClass = BRMAT2GUNSHIP