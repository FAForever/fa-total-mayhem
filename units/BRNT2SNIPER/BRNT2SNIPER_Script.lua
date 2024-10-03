--------------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Tiger Light Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon

-- upvalue for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRNT2SNIPER : TLandUnit
BRNT2SNIPER = Class(TLandUnit){
	Weapons = {
		MainGun = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 4.5,
			FxMuzzleFlash = EffectTemplate.TPlasmaCannonHeavyMuzzleFlash,
		},
		rockets = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
	},

	---@param self BRNT2SNIPER
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		TLandUnit.OnStopBeingBuilt(self, builder, layer)

		if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
			self:SetWeaponEnabledByLabel('autoattack', false)
		else
			self:SetWeaponEnabledByLabel('autoattack', true)
		end
	end,

	---@param self BRNT2SNIPER
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		TLandUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRNT2SNIPER
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['UEFDeath03'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'Object04', army, v):ScaleEmitter(1.3))
		end
	end,
}

TypeClass = BRNT2SNIPER
