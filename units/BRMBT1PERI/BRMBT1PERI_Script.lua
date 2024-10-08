------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
------------------------------------------------------------------------
local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

-- Upvalue for Performance
local TrashBagAdd = TrashBag.Add
local CreateAttachedEmitter = CreateAttachedEmitter
local CreateRotator = CreateRotator

---@class BRMBT1PERI : TStructureUnit
BRMBT1PERI = Class(TStructureUnit){

	---@param self BRMBT1PERI
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		TStructureUnit.OnStopBeingBuilt(self, builder, layer)
		local trash = self.Trash
		TrashBagAdd(trash, CreateRotator(self, 'B02', 'y', nil, -90, 0, 0))

		self:CreateTheEffects()
	end,

	---@param self BRMBT1PERI
	CreateTheEffects = function(self)
		local army = self.Army
		local trash = self.Trash
		for _, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy01', army, v):ScaleEmitter(1.35))
		end
		for _, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy02', army, v):ScaleEmitter(1.35))
		end
		for _, v in EffectTemplate['CSoothSayerAmbient'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy02', army, v):ScaleEmitter(0.3))
		end
		for _, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy03', army, v):ScaleEmitter(6.75))
		end
		for _, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy04', army, v):ScaleEmitter(2.75))
		end
		for _, v in EffectTemplate['GenericTeleportCharge01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy05', army, v):ScaleEmitter(0.35))
		end
		for _, v in EffectTemplate['GenericTeleportCharge01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy06', army, v):ScaleEmitter(0.35))
		end
		for _, v in EffectTemplate['GenericTeleportCharge01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy07', army, v):ScaleEmitter(0.35))
		end
		for _, v in EffectTemplate['GenericTeleportCharge01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy08', army, v):ScaleEmitter(0.35))
		end
		for _, v in EffectTemplate['GenericTeleportCharge01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy09', army, v):ScaleEmitter(0.35))
		end
		for _, v in EffectTemplate['GenericTeleportCharge01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy10', army, v):ScaleEmitter(0.35))
		end
		for _, v in EffectTemplate['GenericTeleportCharge01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy11', army, v):ScaleEmitter(0.35))
		end
		for _, v in EffectTemplate['GenericTeleportCharge01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy12', army, v):ScaleEmitter(0.35))
		end
	end,

	---@param self BRMBT1PERI
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		TStructureUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRMBT1PERI
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash
		for _, v in TMEffectTemplate['MadCatDeath01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'BRMBT1PERI', army, v):ScaleEmitter(1.2))
		end
	end,
}
TypeClass = BRMBT1PERI