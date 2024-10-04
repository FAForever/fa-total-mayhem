--------------------------------------------------------------------------------
-- File     :  /cdimage/units/UEB2301/UEB2301_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  UEF Heavy Gun Tower Script
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------
local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TMWeaponsFile = import('/mods/fa-total-mayhem/lua/TMAeonWeapons.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

local TMAmizurabluelaserweapon = TMWeaponsFile.TMAmizurabluelaserweapon

-- Upvale for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BROT1EXPD : TStructureUnit
BROT1EXPD = Class(TStructureUnit){
	Weapons = {
		laserblue = Class(TMAmizurabluelaserweapon){},
		laserblue2 = Class(TMAmizurabluelaserweapon){},
		laserblue3 = Class(TMAmizurabluelaserweapon){},
		laserblue4 = Class(TMAmizurabluelaserweapon){},
	},

	---@param self BROT1EXPD
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		TStructureUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BROT1EXPD
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['AeonUnitDeathRing03'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'BROT1EXPD', army, v):ScaleEmitter(0.85))
		end
	end,
}

TypeClass = BROT1EXPD
