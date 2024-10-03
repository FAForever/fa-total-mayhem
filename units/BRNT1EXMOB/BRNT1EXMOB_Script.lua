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
local TSAMLauncher = WeaponsFile.TSAMLauncher

-- upvalue for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRNT1EXMOB: TLandUnit
BRNT1EXMOB = Class(TLandUnit){
	Weapons = {
		MainGun = Class(TDFGaussCannonWeapon){
			FxMuzzleFlashScale = 6.5,
			FxMuzzleFlash = EffectTemplate.TPlasmaGatlingCannonMuzzleFlash,
		},
		smallgun01 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 1.0 },
		smallgun02 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 1.0 },
		smallgun03 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 1.0 },
		smallgun04 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 1.0 },
		autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
		MissileRack01 = Class(TSAMLauncher){},
	},

	---@param self BRNT1EXMOB
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

	---@param self BRNT1EXMOB
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		TLandUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	---@param self BRNT1EXMOB
	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['UEFDeath04'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'BRNT1EXMOB', army, v):ScaleEmitter(2.7))
		end
	end,
}

TypeClass = BRNT1EXMOB
