--------------------------------------------------------------------------------
-- File     :  /cdimage/units/UEA0304/UEA0304_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  UEF Strategic Bomber Script
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------
local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TIFSmallYieldNuclearBombWeapon = import('/lua/terranweapons.lua').TIFSmallYieldNuclearBombWeapon
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local util = import('/lua/utilities.lua')
local fxutil = import('/lua/effectutilities.lua')

-- upvalue for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local CreateBeamEmitterOnEntity = CreateBeamEmitterOnEntity
local KillThread = KillThread
local TrashBagAdd = TrashBag.Add
local WaitSeconds = WaitSeconds

---@class BRNAT3BOMBER: TAirUnit
BRNAT3BOMBER = Class(TAirUnit){
	Weapons = { Bomb = Class(TIFSmallYieldNuclearBombWeapon){} },
	MovementAmbientExhaustBones = { 'Exhaust_Right01', 'Exhaust_Right03' },
	DestructionPartsChassisToss = { 'BRNAT3BOMBER' },
	DestroyNoFallRandomChance = 1.1,

	---@param self BRNAT3BOMBER
	---@param new VerticalMovementState
	---@param old VerticalMovementState
	OnMotionHorzEventChange = function(self, new, old)
		TAirUnit.OnMotionHorzEventChange(self, new, old)

		if self.ThrustExhaustTT1 == nil then
			if self.MovementAmbientExhaustEffectsBag then
				fxutil.CleanupEffectBag(self, 'MovementAmbientExhaustEffectsBag')
			else
				self.MovementAmbientExhaustEffectsBag = {}
			end
			self.ThrustExhaustTT1 = self:ForkThread(self.MovementAmbientExhaustThread)
		end

		if new == 'Stopped' and self.ThrustExhaustTT1 ~= nil then
			KillThread(self.ThrustExhaustTT1)
			fxutil.CleanupEffectBag(self, 'MovementAmbientExhaustEffectsBag')
			self.ThrustExhaustTT1 = nil
		end
	end,

	---@param self BRNAT3BOMBER
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
			fxutil.CleanupEffectBag(self, 'MovementAmbientExhaustEffectsBag')

			WaitSeconds(util.GetRandomFloat(1, 7))
		end
	end,

	---@param self BRNAT3BOMBER
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		TAirUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRNAT3BOMBER
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['UEFDeath02'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'BRNAT3BOMBER', army, v):ScaleEmitter(1.25))
		end
	end,
}

TypeClass = BRNAT3BOMBER
