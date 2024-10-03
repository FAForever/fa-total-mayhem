--------------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------
local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon

-- upvalue for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRNBAAFAC: TStructureUnit
BRNBAAFAC = Class(TStructureUnit){
	Weapons = {
		MainGun = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 0.5,
			FxMuzzleFlash = EffectTemplate.CIFCruiseMissileLaunchSmoke,
		}
	},

	---@param self BRNBAAFAC
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		TStructureUnit.OnStopBeingBuilt(self, builder, layer)
		self:CreateTheEffects()
	end,

	---@param self BRNBAAFAC
	CreateTheEffects = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy01', army, v):ScaleEmitter(1.35))
		end
		for _, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy02', army, v):ScaleEmitter(1.35))
		end
		for _, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy03', army, v):ScaleEmitter(1.35))
		end
		for _, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Dummy04', army, v):ScaleEmitter(1.35))
		end
	end,

	---@param self BRNBAAFAC
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		TStructureUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRNBAAFAC
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['UEFDeath01'] do
			TrashBagAdd(trash,CreateAttachedEmitter(self, 'death', army, v):ScaleEmitter(1.25))
		end
	end,
}

TypeClass = BRNBAAFAC
