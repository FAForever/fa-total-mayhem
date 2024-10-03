--------------------------------------------------------------
-- File     :  /cdimage/units/UEB2301/UEB2301_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  UEF Heavy Gun Tower Script
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------
local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local TMMMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMavaEffectTemplates.lua')

-- upvalue for performance
local CreateRotator = CreateRotator
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRNT3PERSES : TStructureUnit
BRNT3PERSES = Class(TStructureUnit){
	Weapons = {
		Gauss01 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlash = EffectTemplate.TShipGaussCannonFlash,
			FxMuzzleFlashScale = 1.15,
		},
		Gauss02 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlash = EffectTemplate.TShipGaussCannonFlash,
			FxMuzzleFlashScale = 1.15,
		},
		Gauss03 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlash = EffectTemplate.TShipGaussCannonFlash,
			FxMuzzleFlashScale = 1.15,
		},
		Gauss04 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlash = EffectTemplate.TShipGaussCannonFlash,
			FxMuzzleFlashScale = 1.15,
		},
		DeathWeapon = Class(SCUDeathWeapon){},
	},

	---@param self BRNT3PERSES
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		TStructureUnit.OnStopBeingBuilt(self, builder, layer)
		local trash = self.Trash

		TrashBagAdd(trash, CreateRotator(self, 'Object05', 'y', nil, -230, 0, 0))

		self:CreateTheEffects()
	end,

	---@param self BRNT3PERSES
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		TStructureUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self any
	CreateTheEffects = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in EffectTemplate['CSoothSayerAmbient'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'perimetereff', army, v):ScaleEmitter(0.25))
		end
	end,

	---@param self any
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMMMEffectTemplate['UEFmayhemRocketHit2A'] do
			TrashBagAdd(trash,CreateAttachedEmitter(self, 'Object42', army, v):ScaleEmitter(2.25))
		end
		for _, v in TMEffectTemplate['UEFDeath02'] do
			TrashBagAdd(trash,CreateAttachedEmitter(self, 'Object17', army, v):ScaleEmitter(2.75))
		end
	end,
}

TypeClass = BRNT3PERSES
