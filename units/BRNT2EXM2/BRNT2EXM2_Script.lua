--------------------------------------------------------------------------------
-- File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  BRN Scavenger Medium Tank
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local AWeaponsFile = import('/lua/aeonweapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

local ACruiseMissileWeapon = AWeaponsFile.ACruiseMissileWeapon
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon

-- upvalue for performance
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BRNT2EXM2 : TLandUnit
BRNT2EXM2 = Class(TLandUnit){
	Weapons = {
		rocket = Class(ACruiseMissileWeapon){
			FxMuzzleFlash = EffectTemplate.CIFCruiseMissileLaunchSmoke,
			FxMuzzleFlashScale = 3.2,
		},
		rocket2 = Class(ACruiseMissileWeapon){
			FxMuzzleFlash = EffectTemplate.CIFCruiseMissileLaunchSmoke,
			FxMuzzleFlashScale = 3.2,
		},
		robottalk = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
	},

	ActiveState = State{ Main = function(self)
		self:SetImmobile(true)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationTransform)
		self.AnimManip:SetRate(0.5)
		WaitFor(self.AnimManip)
		self:SetWeaponEnabledByLabel('rocket', true)
		self:AddCommandCap('RULEUCC_Attack')
	end },
	InActiveState = State{ Main = function(self)
		self:SetImmobile(true)
		self:RemoveCommandCap('RULEUCC_Attack')
		self:SetWeaponEnabledByLabel('rocket', false)
		self.AnimManip:SetRate(-1)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationTransform)
		self.AnimManip:SetAnimationFraction(1)
		WaitFor(self.AnimManip)
		self:SetImmobile(false)
	end },

	---@param self BRNT2EXM2
	---@param builder Unit
	---@param layer Layer
	OnStopBeingBuilt = function(self, builder, layer)
		TLandUnit.OnStopBeingBuilt(self, builder, layer)
		if self:GetAIBrain().BrainType == 'Human' then
			self:SetWeaponEnabledByLabel('rocket2', false)
			self:SetWeaponEnabledByLabel('robottalk', false)
		end
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
		self:RemoveCommandCap('RULEUCC_Attack')
		self:SetWeaponEnabledByLabel('rocket', false)
	end,

	---@param self BRNT2EXM2
	---@param bit number
	OnScriptBitSet = function(self, bit)
		TLandUnit.OnScriptBitSet(self, bit)
		if bit == 7 then
			ChangeState(self, self.ActiveState)
		end
	end,

	---@param self BRNT2EXM2
	---@param bit number
	OnScriptBitClear = function(self, bit)
		TLandUnit.OnScriptBitClear(self, bit)
		if bit == 7 then
			ChangeState(self, self.InActiveState)
		end
	end,

	---@param self BRNT2EXM2
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		TLandUnit.OnKilled(self, instigator, damageType, overkillRatio)
		self:CreateTheEffectsDeath()
	end,

	CreateTheEffectsDeath = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in TMEffectTemplate['UEFHEAVYROCKET'] do
			TrashBagAdd(trash, CreateAttachedEmitter(self, 'BRNT2EXM2', army, v):ScaleEmitter(1.0))
		end
	end,
}

TypeClass = BRNT2EXM2
