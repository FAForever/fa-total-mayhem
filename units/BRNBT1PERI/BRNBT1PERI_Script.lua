--------------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------

local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit

-- upvalue for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRNBT1PERI: TStructureUnit
BRNBT1PERI = Class(TStructureUnit){

	---@param self BRNBT1PERI
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		TStructureUnit.OnStopBeingBuilt(self, builder, layer)

		local trash = self.Trash

		TrashBagAdd(trash, CreateRotator(self, 'Object01', 'y', nil, -30, 0, 0))

		self:CreateTheEffects()
	end,

	---@param self BRNBT1PERI
	CreateTheEffects = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in EffectTemplate['CSoothSayerAmbient'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'perieffect', army, v):ScaleEmitter(0.3))
		end
		for _, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy01', army, v):ScaleEmitter(1.50))
		end
		for _, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy02', army, v):ScaleEmitter(1.50))
		end
	end,

	---@param self BRNBT1PERI
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		TStructureUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRNBT1PERI
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['UEFDeath01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'BRNBT1PERI', army, v):ScaleEmitter(1.4))
		end
	end,
}

TypeClass = BRNBT1PERI
