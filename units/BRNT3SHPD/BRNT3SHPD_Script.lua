--------------------------------------------------------------------------------
-- File     :  /cdimage/units/UEB2301/UEB2301_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  UEF Heavy Gun Tower Script
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------
local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon
local WeaponsFile = import('/lua/terranweapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local TMMMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMavaEffectTemplates.lua')
local TSAMLauncher = WeaponsFile.TSAMLauncher

-- upvalue local functions
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRNT3SHPD : TStructureUnit
BRNT3SHPD = Class(TStructureUnit){
	Weapons = {
		Gauss01 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlash = EffectTemplate.TPlasmaGatlingCannonMuzzleFlash,
			FxMuzzleFlashScale = 3.75,
		},
		DeathWeapon = Class(SCUDeathWeapon){},
		MissileRack01 = Class(TSAMLauncher){},
		missile01 = Class(TDFGaussCannonWeapon){
			FxMuzzleFlash = EffectTemplate.TPlasmaGatlingCannonMuzzleFlash,
			FxMuzzleFlashScale = 0.0,
		},
	},

	---@param self BRNT3SHPD
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio 
	OnKilled = function(self, instigator, damageType, overkillRatio)
		TStructureUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMMMEffectTemplate['UEFmayhemRocketHit2A'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Turret', army, v):ScaleEmitter(2.25))
		end
	end,
}
TypeClass = BRNT3SHPD