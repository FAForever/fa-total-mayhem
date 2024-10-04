------------------------------------------------------------------------------
-- File     :  /cdimage/units/UAA0203/UAA0203_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  Aeon Gunship Script
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
------------------------------------------------------------------------------
local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local AeonWeapons = import('/lua/aeonweapons.lua')
local TMWeaponsFile = import('/mods/fa-total-mayhem/lua/TMAeonWeapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local util = import('/lua/utilities.lua')
local fxutil = import('/lua/effectutilities.lua')

local AAAZealotMissileWeapon = AeonWeapons.AAAZealotMissileWeapon
local TMAnovacatbluelaserweapon = TMWeaponsFile.TMAnovacatbluelaserweapon
local TMAnovacatgreenlaserweapon = TMWeaponsFile.TMAnovacatgreenlaserweapon
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon

-- upvalue local functions
local CreateAttachedEmitter = CreateAttachedEmitter
local KillThread = KillThread
local CreateRotator = CreateRotator
local TrashBagAdd = TrashBag.Add

---@class BROAT3PRIDE : AAirUnit
BROAT3PRIDE = Class(AAirUnit){
	Weapons = {
		laserblue = Class(TMAnovacatbluelaserweapon){},
		lasergreen = Class(TMAnovacatgreenlaserweapon){
			FxMuzzleFlash = EffectTemplate.SDFExperimentalPhasonProjChargeMuzzleFlash,
			FxMuzzleFlashScale = 2.8,
		},
		lasergreen2 = Class(TMAnovacatgreenlaserweapon){},
		lasergreen3 = Class(TMAnovacatgreenlaserweapon){},
		lasergreen4 = Class(TMAnovacatgreenlaserweapon){},
		lasergreen5 = Class(TMAnovacatgreenlaserweapon){},
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
		AntiAirMissiles01 = Class(AAAZealotMissileWeapon){},
		bigGun = Class(TDFGaussCannonWeapon){},
	},
	MovementAmbientExhaustBones = { 'ex01', 'ex02', 'ex03', 'ex04', 'ex05', 'ex06', 'ex07', 'ex08' },
	DestructionPartsChassisToss = { 'BROAT3PRIDE' },
	DestroyNoFallRandomChance = 1.1,

	---@param self BROAT3PRIDE
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		AAirUnit.OnStopBeingBuilt(self, builder, layer)
		local trash = self.Trash

		TrashBagAdd(trash, CreateRotator(self, 'Object12', 'y', nil, -20, 0, 0))
		TrashBagAdd(trash, CreateRotator(self, 'Cylinder02', 'y', nil, 20, 0, 0))

		self:CreateTheEffects()

		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,

	---@param self BROAT3PRIDE
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

	---@param self BROAT3PRIDE
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

	---@param self BROAT3PRIDE
	CreateTheEffects = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in EffectTemplate['GenericTeleportCharge01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'eff01', army, v):ScaleEmitter(4.35))
		end
		for _, v in EffectTemplate['GenericTeleportCharge01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'eff01', army, v):ScaleEmitter(4.35))
		end
	end,

	---@param self BROAT3PRIDE
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		--		self:CreateTheEffectsDeath()
		AAirUnit.OnKilled(self, instigator, damageType, overkillRatio)
	end,

	---@param self BROAT3PRIDE
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['AeonBattleShipHit01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'BROAT3PRIDE', army, v):ScaleEmitter(8.65))
		end
	end,
}
TypeClass = BROAT3PRIDE
