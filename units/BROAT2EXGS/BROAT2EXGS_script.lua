--------------------------------------------------------------
-- File     :  /cdimage/units/UAA0203/UAA0203_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  Aeon Gunship Script
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------
local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local util = import('/lua/utilities.lua')
local AeonWeapons = import('/lua/aeonweapons.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local fxutil = import('/lua/effectutilities.lua')

local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local ADFQuantumAutogunWeapon = AeonWeapons.ADFQuantumAutogunWeapon
local AAAZealotMissileWeapon = AeonWeapons.AAAZealotMissileWeapon

-- upvalue local functions
local CreateAttachedEmitter = CreateAttachedEmitter
local KillThread = KillThread
local CreateRotator = CreateRotator
local TrashBagAdd = TrashBag.Add

---@class BROAT2EXGS : AAirUnit
BROAT2EXGS = Class(AAirUnit){
	Weapons = {
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
		MainGun1 = Class(ADFQuantumAutogunWeapon){},
		MainGun2 = Class(ADFQuantumAutogunWeapon){},
		MainGun3 = Class(ADFQuantumAutogunWeapon){},
		MainGun4 = Class(ADFQuantumAutogunWeapon){},
		AntiAirMissiles01 = Class(AAAZealotMissileWeapon){},
		bigGun = Class(TDFGaussCannonWeapon){},
	},
	MovementAmbientExhaustBones = { 'ex01', 'ex02' },
	DestructionPartsChassisToss = { 'BROAT2EXGS' },
	DestroyNoFallRandomChance = 1.1,

	---@param self BROAT2EXGS
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		AAirUnit.OnStopBeingBuilt(self, builder, layer)
		local trash = self.Trash

		TrashBagAdd(trash, CreateRotator(self, 'Object09', 'y', nil, -750, 0, 0))
		TrashBagAdd(trash, CreateRotator(self, 'Object10', 'y', nil, 750, 0, 0))

		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,

	---@param self BROAT2EXGS
	---@param new VerticalMovementState
	---@param old VerticalMovementState
	OnMotionHorzEventChange = function(self, new, old)
		AAirUnit.OnMotionHorzEventChange(self, new, old)

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

	---@param self BROAT2EXGS
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

	---@param self BROAT2EXGS
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		AAirUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BROAT2EXGS
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['AeonBattleShipHit01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'BROAT2EXGS', army, v):ScaleEmitter(1.65))
		end
	end,
}

TypeClass = BROAT2EXGS
