--------------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

-- Upvale for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local CreateRotator = CreateRotator
local TrashBagAdd = TrashBag.Add

---@class BROBT1PERI : TStructureUnit
BROBT1PERI = Class(TStructureUnit){

	---@param self BROBT1PERI
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		TStructureUnit.OnStopBeingBuilt(self, builder, layer)
		self.Trash:Add(CreateRotator(self, 'Object02', 'y', nil, -10, 0, 0))

		self:CreateTheEffects()
	end,

	---@param self BROBT1PERI
	CreateTheEffects = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in EffectTemplate['CSoothSayerAmbient'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy02', army, v):ScaleEmitter(0.35))
		end
		for _, v in EffectTemplate['GenericTeleportCharge01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy01', army, v):ScaleEmitter(1.75))
		end
	end,

	---@param self BROBT1PERI
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		TStructureUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BROBT1PERI
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['AeonBattleShipHit01'] do
			TrashBagAdd(trash,CreateAttachedEmitter(self, 'Object02', army, v):ScaleEmitter(1.7))
		end
	end,
}

TypeClass = BROBT1PERI
