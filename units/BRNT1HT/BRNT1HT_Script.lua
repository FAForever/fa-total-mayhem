----------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Tiger Light Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon

-- Upvale for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRNT1HT: TLandUnit
BRNT1HT = Class(TLandUnit){
	Weapons = {
		MainGun = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 1.5 },
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
	},

	---@param self BRNT1HT
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		TLandUnit.OnStopBeingBuilt(self, builder, layer)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRNT1HT
	---@param transport Unit
	---@param bone string
	OnDetachedFromTransport = function(self, transport, bone)
		TLandUnit.OnDetachedFromTransport(self, transport, bone)
		self.SetAIAutoattackWeapon(self)
	end,

	---@param self BRNT1HT
	SetAIAutoattackWeapon = function(self)
		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,

	---@param self BRNT1HT
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		TLandUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRNT1HT
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['UEFDeathSML01'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'BRNT1HT', army, v):ScaleEmitter(0.6))
		end
	end,
}

TypeClass = BRNT1HT
